package ptit.projectjava.controller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
@RequestMapping("/user/")
public class UserCategoryController {

	@Autowired
	ICategoryDAO categoryDAO;

	@Autowired
	IVideoDAO videoDAO;

	@Autowired
	IAdminDAO adminDAO;

	@Autowired
	ICommonDAO commonDAO;

	// View video list
	@RequestMapping(value = "category/view-video/{id}", method = RequestMethod.GET)
	public String viewVideoList(ModelMap model, @PathVariable("id") Integer id, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);

		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("user")) {
				List<Video> videos = videoDAO.getPublicVideoListByCategoryId(id);
				model.addAttribute("videos", videos);

				List<Category> categories = categoryDAO.getCategoryList();
				model.addAttribute("categories", categories);

				Category category = categoryDAO.getCategoryById(id);
				model.addAttribute("categoryName", category.getName());
				model.addAttribute("user", adminDAO.getUser(userLogin.getId()));
				return "user/category/view-category-videos";
			}
		} else {
			return "redirect:/sign-in.htm";
		}
		return "not-found";
	}

}
