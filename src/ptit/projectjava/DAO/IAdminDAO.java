package ptit.projectjava.DAO;

import java.util.List;

import ptit.projectjava.entity.User;

public interface IAdminDAO {
	public List<User> getUserList();
	public void deleteUser(Integer id); 
	public User getUser(Integer id);
	public void updateUser(User user);

}
