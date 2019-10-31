package ptit.projectjava.DAO;

import java.io.IOException;

import javax.servlet.http.HttpSession;

public interface ICommonDAO {
	 public void copyFile(String source, String dest) throws IOException;
	 
	 public boolean isLogin(HttpSession session);
	 
}
