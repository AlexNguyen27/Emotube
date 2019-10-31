package ptit.projectjava.controller.admin;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptit.projectjava.DAO.IAdminDAO;
import ptit.projectjava.DAO.ICategoryDAO;
import ptit.projectjava.DAO.ICommonDAO;
import ptit.projectjava.DAO.IVideoDAO;
import ptit.projectjava.entity.Category;
import ptit.projectjava.entity.User;
import ptit.projectjava.entity.Video;

@Controller
@RequestMapping("/admin/")
public class AdminVideoController {

	@Autowired
	IVideoDAO videoDAO;

	@Autowired
	ICategoryDAO categoryDAO;

	@Autowired
	IAdminDAO adminDAO;

	@Autowired
	ICommonDAO commonDAO;
	
	// Delete Video
	@RequestMapping(value = "user-{userId}/delete-video/{id}", method = RequestMethod.GET)
	public String delete(@PathVariable("id") Integer id, @PathVariable("userId") Integer userId,
			HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);

		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("admin")) {
				videoDAO.deleteVideo(id);
				return "redirect:/admin/user/view-user/{userId}.htm";
			}
		} else {
			return "redirect:/sign-in.htm";
		}

		return "not-found";
	}

	// Update Video - GET
	@RequestMapping(value = "user-{userId}/update-video/{id}", method = RequestMethod.GET)
	public String updated(Model model, @PathVariable("id") Integer id, @PathVariable("userId") Integer userId,
			HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);

		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("admin")) {
				Video video = videoDAO.getVideoById(id);
				video.setVideo_url("https://www.youtube.com/watch?v=" + video.getVideo_url());
				model.addAttribute("video", video);
				model.addAttribute("userId", userId);

				List<Category> categories = categoryDAO.getCategoryList();
				model.addAttribute("categories", categories);
				return "admin/video/update-video";
			}
		} else {
			return "redirect:/sign-in.htm";
		}

		return "not-found";

	}

	private String getYoutubeVideoCode(String input) {
		String[] arr = input.split("v=");
		return arr[1];
	}

	// Update Video - POST
	@RequestMapping(value = "user-{userId}/update-video/{id}", method = RequestMethod.POST)
	public String update(Model model, @ModelAttribute("video") @Validated Video video, BindingResult errors,
			@PathVariable("id") Integer id, @PathVariable("userId") Integer userId) {
		video.setId(id);
		if (video.getVideo_url().trim().length() == 0) {
			errors.rejectValue("video_url", "video", "*Video url is required!");
		}
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
			return "redirect:/admin/user/view-user/{userId}.htm";
		} else {
			List<Category> categories = categoryDAO.getCategoryList();
			model.addAttribute("categories", categories);
			return "admin/video/update-video";
		}
	}

}
