package ptit.projectjava.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HelpController {
	@RequestMapping("user/help")
	public String helpUser(ModelMap model) {
		return "user/help";
	}
	
	@RequestMapping("admin/help")
	public String helpAdmin(ModelMap model) {
		return "admin/help";
	}
}
