package ptit.projectjava.DAO.Impl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ptit.projectjava.DAO.IAdminDAO;
import ptit.projectjava.entity.User;

@Repository
public class AdminDAO implements IAdminDAO {

	@Autowired
	SessionFactory sessionFactory;

	@Override
	@Transactional
	public User getUser(Integer id) {
		Session session = sessionFactory.getCurrentSession();
		try {
			User user = (User) session.get(User.class, id);
			return user;
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return new User();
	}

	@Override
	@Transactional
	public List<User> getUserList() {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "from User";
			Query query = session.createQuery(hql);
			List<User> users = query.list();
			return users;
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return new ArrayList<>();

	}

	@Override
	@Transactional
	public void deleteUser(Integer id) {
		Session session = sessionFactory.getCurrentSession();
		try {
			User user = getUser(id);
			session.delete(user);
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}

	}

	@Override
	@Transactional
	public void updateUser(User user) {
		Session session = sessionFactory.getCurrentSession();
		try {
			session.update(user);
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		
	}

}
