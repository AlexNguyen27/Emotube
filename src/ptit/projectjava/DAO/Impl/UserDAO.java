package ptit.projectjava.DAO.Impl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ptit.projectjava.DAO.IUserDAO;
import ptit.projectjava.entity.User;

@Repository
public class UserDAO implements IUserDAO {
	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	@Transactional
	public User validateUser(String username, String password) {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "FROM User u where u.user_name='" + username + "' and u.password='" + password + "'";

			Query query = session.createQuery(hql);
			List<User> users = query.list();
			System.out.println(users.get(0));
			return users.size() > 0 ? users.get(0) : null;
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
			return null;
		}
	}

	@Override
	@Transactional
	public void addNewUser(User user, String role) {
		Session session = sessionFactory.getCurrentSession();
		user.setRole(role);
		try {
			session.save(user);
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
	}

	@Override
	public boolean isUser(String role) {
		if(role=="user")
			return true;
		return false;
	}

	@Override
	@Transactional
	public boolean isUserExist(String username) {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "FROM User u WHERE u.user_name=:username";
			Query query = session.createQuery(hql).setParameter("username", username);
			List<User> users = query.list();
			System.out.println(users.size());
			return users.size() > 0 ? true : false;
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return false;
	}


	

}
