package ptit.projectjava.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SendFeedbackController {
	// Removed
	@RequestMapping("user/send-feedback")
	public String sendFeedback(ModelMap model) {
		return "user/send-feedback";
	}
}
