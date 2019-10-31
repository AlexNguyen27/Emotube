package ptit.projectjava.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import ptit.projectjava.DAO.ICommonDAO;
import ptit.projectjava.DAO.IVideoDAO;
import ptit.projectjava.entity.Category;
import ptit.projectjava.entity.User;
import ptit.projectjava.entity.Video;

@Controller
@RequestMapping("/admin/")
public class AdminCategoryController {

	@Autowired
	ICategoryDAO categoryDAO;

	@Autowired
	IVideoDAO videoDAO;

	@Autowired
	ICommonDAO commonDAO;

	@Autowired
	IAdminDAO adminDAO;

	// Get Category List
	@RequestMapping("category-list")
	public String getDemo(Model model, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);
		// Check if use is login if not redirect to sign-in
		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			// Just admin allow to view categories
			if (userLogin.getRole().equals("admin")) {
				model.addAttribute("categories", categoryDAO.getCategoryList());
				model.addAttribute("category", new Category());
				model.addAttribute("admin", adminDAO.getUser(userLogin.getId()));

				return "admin/category/category-list";
			}
		} else {
			return "redirect:/sign-in.htm";
		}

		// if user try to view categories list
		return "not-found";
	}

	// Add New Category
	@RequestMapping(value = "category-list", method = RequestMethod.POST)
	public String addCategory(ModelMap model, @ModelAttribute("category") @Validated Category category,
			BindingResult errors) {
		if (category.getName().trim().length() == 0) {
			errors.rejectValue("name", "category", "*This field can not be blank!");
		} else {
			Category cate = categoryDAO.getCategorybyName(category.getName());
			if (cate != null) {
				// Category name should be unique
				errors.rejectValue("name", "category", "*This category name already exists!");
			}
		}
		if (!errors.hasErrors()) {
			categoryDAO.addCategory(category);
		} else {
			model.addAttribute("openModal", "yes");
		}

		List<Category> categories = categoryDAO.getCategoryList();
		model.addAttribute("categories", categories);
		return "admin/category/category-list";
	}

	// Get Category for Update
	@RequestMapping(value = "category/update-category/{id}", method = RequestMethod.GET)
	public String updated(Model model, @PathVariable("id") Integer id, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);
		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("admin")) {
				Category category = categoryDAO.getCategoryById(id);
				model.addAttribute("category", category);
				return "admin/category/update-category";
			}
		} else {
			return "redirect:/sign-in.htm";
		}

		return "not-found";
	}

	// Update Category
	@RequestMapping(value = "category/update-category/{id}", method = RequestMethod.POST)
	public String update(Model model, @ModelAttribute("category") @Validated Category category, BindingResult errors,
			@PathVariable("id") Integer id) {
		if (category.getName().trim().length() == 0) {
			errors.rejectValue("name", "category", "*This field can not be blank!");
		} else {
			Category cate = categoryDAO.isCategoryNameExist(category.getName(), category.getId());
			if (cate != null) {
				errors.rejectValue("name", "category", "*This category name already exists!");
			}
		}
		if (!errors.hasErrors()) {
			category.setId(id);
			categoryDAO.updateCategory(category);
			return "redirect:/admin/category-list.htm";
		}
		category.setName("");
		return "admin/category/update-category";
	}

	// Delete Category
	@RequestMapping(value = "category/delete-category/{id}", method = RequestMethod.GET)
	public String delete(@PathVariable Integer id, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);
		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("admin")) {
				categoryDAO.deleteCategory(id);
				return "redirect:/admin/category-list.htm";
			}
		} else {
			return "redirect:/sign-in.htm";
		}

		return "not-found";
	}

	// View Category
	@RequestMapping(value = "category/view-category/{id}", method = RequestMethod.GET)
	public String view(ModelMap model, @PathVariable Integer id, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);
		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("admin")) {
				Category category = categoryDAO.getCategoryById(id);
				model.addAttribute("category", category);

				List<Video> videos = videoDAO.getVideoListByCategoryId(id);
				model.addAttribute("videos", videos);

				return "admin/category/view-category";
			}
		} else {
			return "redirect:/sign-in.htm";
		}

		return "not-found";

	}
}
