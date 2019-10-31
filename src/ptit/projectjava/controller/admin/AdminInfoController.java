package ptit.projectjava.controller.admin;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import ptit.projectjava.DAO.IAdminDAO;
import ptit.projectjava.DAO.ICategoryDAO;
import ptit.projectjava.DAO.ICommonDAO;
import ptit.projectjava.DAO.IVideoDAO;
import ptit.projectjava.entity.User;
import ptit.projectjava.entity.Video;

@Controller
@RequestMapping("/admin/")
public class AdminInfoController {
	@Autowired
	IVideoDAO videoDAO;

	@Autowired
	ICategoryDAO categoryDAO;

	@Autowired
	IAdminDAO adminDAO;

	@Autowired
	ICommonDAO commonDAO;

	@Autowired
	ServletContext context;

	// Change password admin password GET
	@RequestMapping(value = "change-password/{userId}", method = RequestMethod.GET)
	public String changePassword(ModelMap model, @PathVariable Integer userId, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);

		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			// Current user is admin
			if (userLogin.getRole().equals("admin") && userLogin.getId().equals(userId)) {
				model.addAttribute("user", adminDAO.getUser(userId));
				model.addAttribute("newPasswordError", "none");
				model.addAttribute("currentPasswordError", "none");
				model.addAttribute("confirmPasswordError", "none");
				return "admin/your-channel/change-password";
			}

		} else {
			return "redirect:/sign-in.htm";
		}

		return "not-found";
	}

	// Change password POST
	@RequestMapping(value = "change-password/{userId}", method = RequestMethod.POST)
	public String changePW(ModelMap model, @PathVariable Integer userId,
			@RequestParam("current-password") String currentPassword, @RequestParam("new-password") String newPassword,
			@RequestParam("confirm-password") String confirmPassword, HttpServletRequest request) {
		boolean hasError = false;

		currentPassword = currentPassword.trim();
		newPassword = newPassword.trim();
		confirmPassword = confirmPassword.trim();

		User user = adminDAO.getUser(userId);
		if (currentPassword.length() == 0) {
			model.addAttribute("currentPasswordError", "*Current password is required!");
			hasError = true;
		} else if (!user.getPassword().equals(currentPassword)) {
			model.addAttribute("currentPasswordError", "*Current password is incorrect!");
			hasError = true;
		}
		if (!hasError) {
			if (newPassword.length() == 0) {
				model.addAttribute("newPasswordError", "*New password is required!");
				hasError = true;
			}
			if (confirmPassword.length() == 0) {
				model.addAttribute("confirmPasswordError", "*Confirm password is required!");
				hasError = true;
			}
			if (!confirmPassword.equals(newPassword)) {
				model.addAttribute("confirmPasswordError", "*Confirm password is incorrect!");
				hasError = true;
			}
			// if dont have error
			if (!hasError) {
				user.setPassword(newPassword);
				adminDAO.updateUser(user);
				return "redirect:/admin/admin-info.htm";
			}
		}

		model.addAttribute("currentPassword", currentPassword);
		model.addAttribute("newPassword", newPassword);
		model.addAttribute("confirmPassword", confirmPassword);
		return "admin/your-channel/change-password";
	}

	@RequestMapping(value = "admin-info", method = RequestMethod.GET)
	public String getAdminInfo(ModelMap model, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);

		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("admin")) {
				model.addAttribute("admin", adminDAO.getUser(userLogin.getId()));
				List<Video> videos = videoDAO.getVideoListByUserId(userLogin.getId());
				model.addAttribute("videos", videos);
				return "admin/your-channel/admin-info";
			}

		} else {
			return "redirect:/sign-in.htm";
		}

		return "not-found";
	}

	// Update admin info GET
	@RequestMapping(value = "update-info/{id}", method = RequestMethod.GET)
	public String getUserInfo(HttpServletRequest request, ModelMap model) {
		HttpSession httpSession = request.getSession(true);
		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("admin")) {
				model.addAttribute("user", adminDAO.getUser(userLogin.getId()));
				return "user/your-channel/update-info";
			}
		} else {
			return "redirect:/sign-in.htm";
		}
		return "not-found";

	}

	// Update admin info POST
	@RequestMapping(value = "update-info/{id}", method = RequestMethod.POST)
	public String getUserId(ModelMap model, @RequestParam("profile") MultipartFile profile,
			@ModelAttribute("user") @Validated User user, BindingResult errors, @PathVariable Integer id) {

		if (user.getUser_name().trim().length() == 0) {
			errors.rejectValue("user_name", "user", "*Username is required!");
		}
		if (user.getFirst_name().trim().length() == 0) {
			errors.rejectValue("first_name", "user", "*First name is required!");
		}
		if (user.getLast_name().trim().length() == 0) {
			errors.rejectValue("last_name", "user", "*Last name is required!");
		}
		if (user.getEmail().trim().length() == 0) {
			errors.rejectValue("email", "user", "*Email is required!");
		}
		if (user.getPassword().trim().length() == 0) {
			errors.rejectValue("password", "user", "*Password is required!");
		}

		if (profile.isEmpty()) {
			errors.rejectValue("profile_image", "user", "*Profile image is required!");
		} else {
			try {
				String photoPath = context.getRealPath("/files/" + profile.getOriginalFilename());
				profile.transferTo(new File(photoPath));

				String profile_image = profile.getOriginalFilename();
				user.setProfile_image(profile_image);
			} catch (Exception e) {
				System.out.println(e);
				errors.rejectValue("profile_image", "user", "*Can not save image!");

			}
		}

		if (!errors.hasErrors()) {
			user.setId(id);
			adminDAO.updateUser(user);
			return "redirect:/admin/admin-info.htm";
		} else {
			return "user/your-channel/update-info";
		}
	}
}
