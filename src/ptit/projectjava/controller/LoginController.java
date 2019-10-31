package ptit.projectjava.controller;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import ptit.projectjava.DAO.ICommonDAO;
import ptit.projectjava.DAO.IUserDAO;
import ptit.projectjava.entity.User;

@Controller
public class LoginController {

	@Autowired
	IUserDAO userDAO;

	@Autowired
	ServletContext context;

	@Autowired
	ICommonDAO commonDAO;

	@RequestMapping("test")
	public String test() {
		return "user/testhome";
	}
	@RequestMapping("sub-header")
	public String testHeader() {
		return "sub-header";
	}
	
	@RequestMapping("sub-footer")
	public String testFooter() {
		return "sub-footer";
	}
	
	// Sign in form
	@RequestMapping(value = "/sign-in", method = RequestMethod.GET)
	public String signIn(ModelMap model) {
		model.addAttribute("user", new User());
		return "register/sign-in";
	}
	
	// Log out form
	@RequestMapping(value="/log-out", method=RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);
		httpSession.removeAttribute("user_name");
		httpSession.removeAttribute("password");
		httpSession.removeAttribute("user");
		//httpSession.invalidate();
		return "redirect:/sign-in.htm";
	}

	// Login form
	@RequestMapping(value = "/sign-in", method = RequestMethod.POST)
	public String login(@ModelAttribute("user") @Validated User user, BindingResult errors, ModelMap model,
			HttpServletRequest request, HttpServletResponse res)
			throws ServletException {
		if (user.getUser_name().trim().length() == 0) {
			errors.rejectValue("user_name", "user", "*Username is required!");
		}
		if (user.getPassword().trim().length() == 0) {
			errors.rejectValue("password", "user", "*Password is required!");
		}
		// Log out old User whenever user log-in 
		String s = logout(request);
		HttpSession httpSession = request.getSession(true);
		if (!errors.hasErrors()) {
			// Not login yet
			if (!commonDAO.isLogin(httpSession)) {
				User u = userDAO.validateUser(user.getUser_name(), user.getPassword());
				if (u == null) {
					model.addAttribute("wrongInput", "*The username or password you entered is incorrect!");
				} else {
					// Set user session
					httpSession.setAttribute("user", u);
					httpSession.setAttribute("user_name", u.getUser_name());
					httpSession.setAttribute("password", u.getPassword());
					
					System.out.println(httpSession.getAttribute("user_name"));
					System.out.println(httpSession.getAttribute("password"));
					System.out.println(httpSession.getAttribute("user").toString());
					
					// Dont need this one	
					//redirectAttributes.addFlashAttribute("loginUser", user);
					if (u.getRole().equals("admin")) {
						return "redirect:/admin/user-list.htm";
					}
					return "redirect:/user/home.htm";
				}
			}else {
				return "not-found";
			}

		}
		return "register/sign-in";
	}

	// Sign up form
	@RequestMapping(value = "/sign-up", method = RequestMethod.GET)
	public String signUp(ModelMap model) {
		model.addAttribute("user", new User());
		return "register/sign-up";
	}

	// Add new user to database
	@RequestMapping(value = "/sign-up", method = RequestMethod.POST)
	public String signup(ModelMap model, @RequestParam("profile") MultipartFile profile,
			@ModelAttribute("user") @Validated User user, BindingResult errors) {
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
				errors.rejectValue("profile_image", "user", "*Can not save file!");
			}
		}

		if (!errors.hasErrors()) {
			if (userDAO.isUserExist(user.getUser_name())) {
				errors.rejectValue("user_name", "user", "*This Username already exists");
			} else {
				userDAO.addNewUser(user, "user");
				return "register/sign-in";
			}
		}
		return "register/sign-up";
	}

}
