package ptit.projectjava.controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import ptit.projectjava.DAO.IAdminDAO;
import ptit.projectjava.DAO.ICommonDAO;
import ptit.projectjava.DAO.ISubscribeDAO;
import ptit.projectjava.entity.Subscribe;
import ptit.projectjava.entity.User;

@Controller
@RequestMapping("/user/")
public class UserSubscribeController {

	@Autowired
	ISubscribeDAO subscribeDAO;
	
	@Autowired
	ICommonDAO commonDAO;
	

	@Autowired
	IAdminDAO adminDAO;
	
	@RequestMapping("subscribe/{toUserId}")
	public String onClickSubscribe(ModelMap model, @PathVariable("toUserId") Integer toUserId, HttpServletRequest request) {
		HttpSession httpSession = request.getSession(true);
		
		String result = "";
		if (commonDAO.isLogin(httpSession)) {
			User userLogin = (User) httpSession.getAttribute("user");
			
			Subscribe subscribe = new Subscribe();
			subscribe.setUser_from(userLogin);
			subscribe.setUser_to(adminDAO.getUser(toUserId));
			
			Integer isSubscribe = subscribeDAO.onClickSubscribe(subscribe);
			if(isSubscribe.equals(1)) {
				result = "SUBSCRIBED";
			}
			if(isSubscribe.equals(0)) {
				result = "SUBSCRIBE";
			}
			return "redirect:/user/test-subscribe/" + result + ".htm"; 
		}else {
			return "redirect:/sign-in.htm";
		}

	}
	
	@RequestMapping("test-subscribe/{result}")
	public String test(ModelMap model, @PathVariable("result") String subscribe) {
		model.addAttribute("subscribe", subscribe);
		
		return "user/video/subscribe";
	}
	
}
