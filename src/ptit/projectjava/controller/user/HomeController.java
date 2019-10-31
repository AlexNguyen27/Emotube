package ptit.projectjava.controller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import ptit.projectjava.DAO.IAdminDAO;
import ptit.projectjava.DAO.ICategoryDAO;
import ptit.projectjava.DAO.ICommonDAO;
import ptit.projectjava.DAO.IVideoDAO;
import ptit.projectjava.entity.Category;
import ptit.projectjava.entity.User;
import ptit.projectjava.entity.Video;

@Controller
@RequestMapping("/user/")
public class HomeController {

	@Autowired
	ICategoryDAO categoryDAO;

	@Autowired
	IVideoDAO videoDAO;

	@Autowired
	ICommonDAO commonDAO;

	@Autowired
	IAdminDAO adminDAO;

	@RequestMapping("home")
	public String home(ModelMap model, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);

		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("user")) {
				List<Category> categories = categoryDAO.getCategoryList();
				model.addAttribute("categories", categories);

				List<Video> videos = videoDAO.getPublicVideoList();
				model.addAttribute("videos", videos);
				
				model.addAttribute("user", adminDAO.getUser(userLogin.getId()));
				return "user/homev2";
			}
		} else {
			return "redirect:/sign-in.htm";
		}

		return "not-found";
	}

}
