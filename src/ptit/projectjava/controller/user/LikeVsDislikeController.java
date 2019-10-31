package ptit.projectjava.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ptit.projectjava.DAO.IAdminDAO;
import ptit.projectjava.DAO.ICommentDAO;
import ptit.projectjava.DAO.ICommonDAO;
import ptit.projectjava.DAO.ILikevsDislikeDAO;
import ptit.projectjava.DAO.IVideoDAO;
import ptit.projectjava.entity.Dislike;
import ptit.projectjava.entity.Like;
import ptit.projectjava.entity.User;
import ptit.projectjava.entity.Video;

@Controller
@RequestMapping("/user/")
public class LikeVsDislikeController {

	@Autowired
	IVideoDAO videoDAO;

	@Autowired
	IAdminDAO adminDAO;

	@Autowired
	ICommentDAO commentDAO;

	@Autowired
	ILikevsDislikeDAO likeDAO;

	@Autowired
	ICommonDAO commonDAO;

	// Like video
	@RequestMapping(value = "like-video/{videoId}", method = RequestMethod.GET)
	public String likeVideo(ModelMap model, @PathVariable("videoId") Integer id, RedirectAttributes redirectAttributes,
			HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);

		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("user")) {
				Like like = new Like();

				like.setVideo(videoDAO.getVideoById(id));
				like.setUser(adminDAO.getUser(userLogin.getId()));

				Integer[] total = likeDAO.onClickLike(like);

				String totalLike = total[0].toString();
				String totalDislike = total[1].toString();
				return "redirect:/user/test/" + totalLike + "/" + totalDislike + ".htm";
			}
		} else {
			return "redirect:/sign-in.htm";
		}

		return "not-found";

	}
	
	// Dislike video
	@RequestMapping(value = "dislike-video/{videoId}", method = RequestMethod.GET)
	public String dislikeVideo(ModelMap model, @PathVariable("videoId") Integer id,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);

		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("user")) {
				Dislike dislike = new Dislike();

				dislike.setVideo(videoDAO.getVideoById(id));
				dislike.setUser(adminDAO.getUser(userLogin.getId()));

				Integer[] total = likeDAO.onClickDislike(dislike);

				String totalLike = total[0].toString();
				String totalDislike = total[1].toString();
				return "redirect:/user/test/" + totalLike + "/" + totalDislike + ".htm";
			}
		} else {
			return "redirect:/sign-in.htm";
		}
		return "not-found";

	}

	// Get data from ajax
	@RequestMapping(value = "test/{totalLike}/{totalDislike}")
	public String test(ModelMap model, @PathVariable("totalLike") Integer totalLike,
			@PathVariable("totalDislike") Integer totalDislike) {
		model.addAttribute("totalLike", totalLike);
		model.addAttribute("totalDislike", totalDislike);

		return "user/video/test";
	}
	
	// Delete comment
	@RequestMapping(value = "delete-comment/{cmtId}", method = RequestMethod.GET)
	public String deleteComment(ModelMap model, @PathVariable("cmtId") Integer id,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);
		
		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			boolean isValidate = commentDAO.getCommentById(id).getUser().getId().equals(userLogin.getId());
			if (isValidate) {
				Video video = commentDAO.getCommentById(id).getVideo();
				
				String videoId = video.getId().toString();
				commentDAO.deleteComment(id);
				
				// minus the view when delete
				videoDAO.updateViewVideo(video.getId(), -1);
				return "redirect:/user/view-video/" + videoId + ".htm";
			}
		} else {
			return "redirect:/sign-in.htm";
		}
		return "not-found";

	}


}
