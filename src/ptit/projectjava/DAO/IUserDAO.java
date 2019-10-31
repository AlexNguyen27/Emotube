package ptit.projectjava.DAO;

import ptit.projectjava.entity.User;

public interface IUserDAO {
	public User validateUser(String username, String password);
	public void addNewUser(User user, String role);
	public boolean isUser(String role);
	public boolean isUserExist(String username);
}
