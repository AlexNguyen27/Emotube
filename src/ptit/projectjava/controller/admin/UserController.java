package ptit.projectjava.controller.admin;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
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
import ptit.projectjava.DAO.IUserDAO;
import ptit.projectjava.DAO.IVideoDAO;
import ptit.projectjava.entity.User;
import ptit.projectjava.entity.Video;

@Controller
@RequestMapping("/admin/")
public class UserController {

	@Autowired
	IAdminDAO adminDAO;

	@Autowired
	IUserDAO userDAO;

	@Autowired
	IVideoDAO videoDAO;

	@Autowired
	ICategoryDAO categoryDAO;

	@Autowired
	ServletContext context;

	@Autowired
	ICommonDAO commonDAO;

	// Home of Admin - User List
	@RequestMapping("user-list")
	public String home(ModelMap model, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);

		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("admin")) {
				List<User> users = adminDAO.getUserList();
				model.addAttribute("users", users);
				model.addAttribute("admin", userLogin);
				model.addAttribute("user", new User());
				return "admin/user/user-list";
			}

		} else {
			return "redirect:/sign-in.htm";
		}

		return "not-found";
	}

	// Add New User - Admin
	@RequestMapping(value = "user-list", method = RequestMethod.POST)
	public String addNewUser(ModelMap model, @RequestParam("profile") MultipartFile profile,
			@ModelAttribute("user") @Validated User user, BindingResult errors, HttpServletRequest request) {
		if (user.getUser_name().trim().length() == 0) {
			errors.rejectValue("user_name", "user", "*Username is required!");
		} else {
			// Check if user exists
			if (userDAO.isUserExist(user.getUser_name())) {
				model.addAttribute("openModal", "yes");
				// model.addAttribute("closeModal", "no");
				errors.rejectValue("user_name", "user", "*This Username already exists");
			}
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
		// Profile image type File
		if (profile.isEmpty()) {
			errors.rejectValue("profile_image", "user", "*Profile image is required!");
		} else {
			try {
				String photoPath = context.getRealPath("/files/" + profile.getOriginalFilename());
				profile.transferTo(new File(photoPath));

				// System.out.println(photoPath);
				String profile_image = profile.getOriginalFilename();
				user.setProfile_image(profile_image);
			} catch (Exception e) {
				errors.rejectValue("profile_image", "user", "*Can not save file!");
			}
		}

		if (!errors.hasErrors()) {
			userDAO.addNewUser(user, user.getRole());
			List<User> users = adminDAO.getUserList();
			model.addAttribute("users", users);
			model.addAttribute("user", new User());
			return "admin/user/user-list";
		} else {
			model.addAttribute("openModal", "yes");
		}

		List<User> users = adminDAO.getUserList();
		model.addAttribute("users", users);
		// user information for header
		HttpSession httpSession = request.getSession(true);
		User userLogin = (User) httpSession.getAttribute("user");
		model.addAttribute("admin", userLogin);
		return "admin/user/user-list";
	}

	// Delete User - checked
	@RequestMapping(value = "user/delete-user/{id}", method = RequestMethod.GET)
	public String deleteUser(ModelMap model, @PathVariable Integer id, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);

		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("admin")) {
				adminDAO.deleteUser(id);
				List<User> users = adminDAO.getUserList();
				model.addAttribute("userId", id);
				model.addAttribute("users", users);
				return "redirect:/admin/user-list.htm";
			}

		} else {
			return "redirect:sign-in.htm";
		}

		return "not-found";
	}

	// Update User - checked
	@RequestMapping(value = "user/update-user/{id}", method = RequestMethod.GET)
	public String getUserId(ModelMap model, @PathVariable Integer id, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);

		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("admin")) {
				User user = adminDAO.getUser(id);
				model.addAttribute("user", user);
				return "admin/user/update-user";
			}
		} else {
			return "redirect:sign-in.htm";
		}
		return "not-found";

	}

	// Update User - POST
	@RequestMapping(value = "user/update-user/{id}", method = RequestMethod.POST)
	public String getUserId(ModelMap model, @RequestParam("profile") MultipartFile profile,
			@ModelAttribute("user") @Validated User user, BindingResult errors, @PathVariable Integer id) {
		user.setId(id);
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

		if (profile.isEmpty()) {
			errors.rejectValue("profile_image", "user", "*Profile image is required!");
		} else {
			try {
				String photoPath = context.getRealPath("/files/" + profile.getOriginalFilename());
				profile.transferTo(new File(photoPath));
				System.out.println(photoPath);

				String profile_image = profile.getOriginalFilename();
				// String filePath = profile.get
				System.out.println(profile_image);
				user.setProfile_image(profile_image);
			} catch (Exception e) {
				System.out.println(e);
				errors.rejectValue("profile_image", "user", "*Can not save file!");
			}
		}

		if (!errors.hasErrors()) {
			adminDAO.updateUser(user);
			return "redirect:/admin/user-list.htm";
		} else {
			return "admin/user/update-user";
		}
	}

	// View User vs User's Videos - GET
	@RequestMapping(value = "user/view-user/{id}", method = RequestMethod.GET)
	public String viewUser(ModelMap model, @PathVariable Integer id, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);

		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			if (userLogin.getRole().equals("admin")) {
				model.addAttribute("user", adminDAO.getUser(id));
				model.addAttribute("admin", adminDAO.getUser(userLogin.getId()));
				model.addAttribute("videos", videoDAO.getVideoListByUserId(id));
				model.addAttribute("categories", categoryDAO.getCategoryList());
				model.addAttribute("video", new Video());
				return "admin/user/view-user";
			}
		} else {
			return "redirect:sign-in.htm";
		}
		return "not-found";

	}

	private String getYoutubeVideoCode(String input) {
		String[] arr = input.split("v=");
		return arr[1];
	}

	// Add Video User - POST
	@RequestMapping(value = "user/view-user/{id}", method = RequestMethod.POST)
	public String addVideo(ModelMap model, @PathVariable Integer id, @ModelAttribute("video") @Validated Video video,
			BindingResult errors) {
		if (video.getTitle().trim().length() == 0) {
			errors.rejectValue("title", "video", "*Title is required!");
		}
		if (video.getDescription().trim().length() == 0) {
			errors.rejectValue("description", "video", "*Description is required!");
		}
		if (video.getVideo_url().trim().length() == 0) {
			errors.rejectValue("video_url", "video", "*Video url is required!");
		}
		if (!errors.hasErrors()) {
			try {
				Document doc = Jsoup.connect(
						"https://www.youtube.com/results?search_query=" + getYoutubeVideoCode(video.getVideo_url()))
						.get();

				Elements newsHeadlines = doc.select("ol.item-section li:first-child");

				String image_url = newsHeadlines.select(".video-thumb img").attr("src").toString();
				String duration = newsHeadlines.select(".video-time").text();
				String video_code = getYoutubeVideoCode(video.getVideo_url());

				video.setVideo_url(video_code);
				video.setImage_url(image_url);
				video.setDuration(duration);
				video.setUpload_date(new Date());
				video.setUser(adminDAO.getUser(id));
				video.setViews(0);
				videoDAO.addNewVideo(video);
				return "redirect:/admin/user/view-user/{id}.htm";
			} catch (Exception e) {
				errors.rejectValue("video_url", "video", "*Video URL is incorrect!");
				model.addAttribute("openModal", "yes");
			}
		} else {
			model.addAttribute("openModal", "yes");
		}

		model.addAttribute("user", adminDAO.getUser(id));
		model.addAttribute("videos", videoDAO.getVideoListByUserId(id));
		model.addAttribute("categories", categoryDAO.getCategoryList());

		return "admin/user/view-user";
	}

}
