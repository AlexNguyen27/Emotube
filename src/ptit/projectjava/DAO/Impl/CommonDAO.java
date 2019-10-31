package ptit.projectjava.DAO.Impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import ptit.projectjava.DAO.ICommonDAO;

@Repository
public class CommonDAO implements ICommonDAO {

	@Override
	public void copyFile(String source, String dest) throws IOException {
		InputStream is = null;
		OutputStream os = null;
		try {
			is = new FileInputStream(new File(source));
			os = new FileOutputStream(new File(dest));
			byte[] buffer = new byte[1024];
			int length;
			while((length = is.read(buffer)) >0 ) {
				os.write(buffer, 0 ,length);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			is.close();
			os.close();
		}
		
	}

	@Override
	@Transactional
	public boolean isLogin(HttpSession session) {
		if(session.getAttribute("user_name") != null && session.getAttribute("password") != null) {
			return true;
		}
		return false;
	}

}
