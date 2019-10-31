package ptit.projectjava.controller.user;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptit.projectjava.DAO.IAdminDAO;
import ptit.projectjava.DAO.ICategoryDAO;
import ptit.projectjava.DAO.ICommentDAO;
import ptit.projectjava.DAO.ICommonDAO;
import ptit.projectjava.DAO.ILikevsDislikeDAO;
import ptit.projectjava.DAO.ISubscribeDAO;
import ptit.projectjava.DAO.IVideoDAO;
import ptit.projectjava.entity.Category;
import ptit.projectjava.entity.Comment;
import ptit.projectjava.entity.Subscribe;
import ptit.projectjava.entity.User;
import ptit.projectjava.entity.Video;

@Controller
@RequestMapping("/user/")
public class UserVideoController {

	@Autowired
	IVideoDAO videoDAO;

	@Autowired
	IAdminDAO adminDAO;

	@Autowired
	ICommentDAO commentDAO;

	@Autowired
	ILikevsDislikeDAO likeDAO;

	@Autowired
	ICategoryDAO categoryDAO;

	@Autowired
	ICommonDAO commonDAO;

	@Autowired
	ISubscribeDAO subscribeDAO;

	@RequestMapping(value = "view-video/{id}", method = RequestMethod.GET)
	public String viewVideo(ModelMap model, @PathVariable("id") Integer id, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);

		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");

			Video video = videoDAO.getVideoById(id);
			videoDAO.updateViewVideo(id, 1);
			video.setViews(video.getViews() + 1);

			model.addAttribute("video", video);
			model.addAttribute("videos", videoDAO.getVideoList());
			model.addAttribute("comments", commentDAO.getCommentByVideoId(id));
			model.addAttribute("likes", likeDAO.getLikeList(id));
			model.addAttribute("dislikes", likeDAO.getDislikeList(id));
			model.addAttribute("comment", new Comment());
			model.addAttribute("user", adminDAO.getUser(userLogin.getId()));

			if (likeDAO.userLikedVideo(userLogin.getId(), id) != null) {
				model.addAttribute("liked", true);
			}
			if (likeDAO.userDislikedVideo(userLogin.getId(), id) != null) {
				model.addAttribute("disliked", true);
			}

			Subscribe sub = subscribeDAO.isSubscribed(video.getUser().getId(), userLogin.getId());
			if (sub != null) {
				model.addAttribute("isSub", "yes");
			} else {
				model.addAttribute("isSub", "no");
			}

			return "user/video/view-video";

		} else {
			return "redirect:/sign-in.htm";
		}
	}

	// Comment video
	@RequestMapping(value = "view-video/{id}", method = RequestMethod.POST)
	public String comment(ModelMap model, @PathVariable("id") Integer videoId, @ModelAttribute("comment") Comment comment,
			BindingResult errors, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);

		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			Video video = videoDAO.getVideoById(videoId);

			comment.setDate(new Date());
			comment.setUser(userLogin);
			comment.setVideo(video);

			model.addAttribute("video", video);

			List<Video> videos = videoDAO.getVideoList();
			model.addAttribute("videos", videos);

			// if comment blank return view video
			if (comment.getComment().trim().length() != 0) {
				commentDAO.addComment(comment);
				model.addAttribute("comments", commentDAO.getCommentByVideoId(videoId));
				model.addAttribute("comment", new Comment());
			}
			/* return "redirect:/user/view-video/{videoId}.htm"; */
			return "user/video/view-video";
		}
		else {
			return "redirect:/sign-in.htm";
		}

		
	}

	private String getYoutubeVideoCode(String input) {
		String[] arr = input.split("v=");
		return arr[1];
	}

	@RequestMapping(value = "user-{userId}/add-video", method = RequestMethod.POST)
	public String addVideo(ModelMap model, @PathVariable("userId") Integer userId,
			@ModelAttribute("video") @Validated Video video, BindingResult errors, HttpServletRequest request) {
		if (video.getTitle().trim().length() == 0) {
			errors.rejectValue("title", "video", "*Title is required!");
		}
		if (video.getDescription().trim().length() == 0) {
			errors.rejectValue("description", "video", "*Description is required!");
		}
		if (video.getVideo_url().trim().length() == 0) {
			errors.rejectValue("video_url", "video", "*Video url is required!");
		}

		User user = adminDAO.getUser(userId);
		model.addAttribute("user", user);

		List<Video> videos = videoDAO.getVideoListByUserId(userId);
		model.addAttribute("videos", videos);

		List<Category> categories = categoryDAO.getCategoryList();
		model.addAttribute("categories", categories);

		if (!errors.hasErrors()) {
			HttpSession httpSession = request.getSession(true);

			User userLogin = (User) httpSession.getAttribute("user");
			try {
				// Document doc =
				// Jsoup.connect("https://www.youtube.com/results?search_query=K9M4SASBmTY").get();
				Document doc = Jsoup.connect(
						"https://www.youtube.com/results?search_query=" + getYoutubeVideoCode(video.getVideo_url()))
						.get();

				Elements newsHeadlines = doc.select("ol.item-section li:first-child");
//				System.out.println(newsHeadlines.toString());
//				System.out.println("----------------------");
//				System.out.println(newsHeadlines.select(".yt-uix-tile-link").attr("href"));
//				System.out.println(newsHeadlines.select(".video-thumb img").attr("src").toString());
//				System.out.println(newsHeadlines.select(".video-time").text());

				String image_url = newsHeadlines.select(".video-thumb img").attr("src").toString();
				String duration = newsHeadlines.select(".video-time").text();
				String video_code = getYoutubeVideoCode(video.getVideo_url());

				video.setVideo_url(video_code);
				video.setImage_url(image_url);
				video.setDuration(duration);
				video.setUpload_date(new Date());
				video.setUser(userLogin);
				video.setViews(0);
				videoDAO.addNewVideo(video);
				return "redirect:/user/your-channel.htm";
			} catch (Exception e) {
				errors.rejectValue("video_url", "video", "*Video URL is incorrect!");
				model.addAttribute("openModal", "yes");
			}

		} else {
			model.addAttribute("openModal", "yes");
		}

		return "user/your-channel/your-channel";
	}

	// Update video user
	@RequestMapping(value = "user-{userId}/update-video/{id}", method = RequestMethod.GET)
	public String updated(Model model, @PathVariable("id") Integer id, @PathVariable("userId") Integer userId,
			HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);

		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("user")) {
				Video video = videoDAO.getVideoById(id);
				video.setVideo_url("https://www.youtube.com/watch?v=" + video.getVideo_url());

				model.addAttribute("video", video);
				model.addAttribute("userId", userLogin.getId());
				model.addAttribute("categories", categoryDAO.getCategoryList());
				return "user/video/update-video";
			}
		} else {
			return "redirect:/sign-in.htm";
		}
		return "not-found";
	}

	@RequestMapping(value = "user-{userId}/update-video/{id}", method = RequestMethod.POST)
	public String update(Model model, @ModelAttribute("video") @Validated Video video, BindingResult errors,
			@PathVariable("id") Integer id, @PathVariable("userId") Integer userId) {
		video.setId(id);
		if (video.getTitle().trim().length() == 0) {
			errors.rejectValue("title", "video", "*Title is required!");
		}
		if (video.getDescription().trim().length() == 0) {
			errors.rejectValue("description", "video", "*Description is required!");
		}
		if (!errors.hasErrors()) {
			String video_code = getYoutubeVideoCode(video.getVideo_url());
			video.setVideo_url(video_code);
			video.setUpload_date(new Date());
			video.setUser(adminDAO.getUser(userId));
			videoDAO.updateVideo(video);
			return "redirect:/user/your-channel.htm";
		} else {
			List<Category> categories = categoryDAO.getCategoryList();
			model.addAttribute("categories", categories);
			return "user/video/update-video";
		}
	}

	// Delete video
	@RequestMapping(value = "user-{userId}/delete-video/{id}", method = RequestMethod.GET)
	public String delete(@PathVariable("id") Integer id, @PathVariable("userId") Integer userId,
			HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);
		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("user")) {
				videoDAO.deleteVideo(id);
				return "redirect:/user/your-channel.htm";
			}
		} else {
			return "redirect:/sign-in.htm";
		}
		return "not-found";

	}
}
