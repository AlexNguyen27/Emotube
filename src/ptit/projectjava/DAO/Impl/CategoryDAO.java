package ptit.projectjava.DAO.Impl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ptit.projectjava.DAO.ICategoryDAO;
import ptit.projectjava.entity.Category;
import ptit.projectjava.entity.User;

@Repository
public class CategoryDAO implements ICategoryDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	@Transactional
	public List<Category> getCategoryList() {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "from Category";
			Query query = session.createQuery("from Category");
			List<Category> categories = query.list();
			return categories;
		} catch (Exception e) {
			session= sessionFactory.openSession();
		}
		return new ArrayList<>();
	}

	@Override
	@Transactional
	public Category getCategoryById(Integer id) {
		Session session = sessionFactory.getCurrentSession();
		try {
			Category category = (Category) session.get(Category.class, id);
			return category;
		} catch (Exception e) {
			e.printStackTrace();
			session= sessionFactory.openSession();
		}
		return new Category();//{}
	}
	
	@Override
	@Transactional
	public Category getCategorybyName(String name) {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "FROM Category c WHERE c.name=:name ";
			Query query = session.createQuery(hql).setParameter("name", name);
			List<Category> categories = query.list();
			return categories.size() > 0 ? categories.get(0) : null;
		} catch (Exception e) {
			e.printStackTrace();
			session= sessionFactory.openSession();
		}
		return new Category();//{}
	}

	@Override
	@Transactional
	public void addCategory(Category category) {
		Session session= sessionFactory.getCurrentSession();
		try {
			session.save(category);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
	}

	@Override
	@Transactional
	public void updateCategory(Category category) {
		Session session= sessionFactory.getCurrentSession();
		try {
			session.update(category);

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
	}

	@Override
	@Transactional
	public void deleteCategory(Integer Id) {
		Session session= sessionFactory.getCurrentSession();
		
		try {
			Category category = getCategoryById(Id);
			session.delete(category);

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
	}

	@Override
	@Transactional
	public Category isCategoryNameExist(String name, Integer id) {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "FROM Category c WHERE c.id<>:id and c.name=:name ";
			Query query = session.createQuery(hql).setParameter("id", id).setParameter("name", name);
			List<Category> categories = query.list();
			System.out.println(categories.size());
			System.out.println(categories);
			return categories.size() > 0 ? categories.get(0) : null;
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return null;//{}
	}

	
}
