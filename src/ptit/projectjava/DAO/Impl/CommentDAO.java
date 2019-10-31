package ptit.projectjava.DAO.Impl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ptit.projectjava.DAO.ICommentDAO;
import ptit.projectjava.entity.Category;
import ptit.projectjava.entity.Comment;

@Repository
public class CommentDAO implements ICommentDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	@Transactional
	public void addComment(Comment comment) {
		Session session = sessionFactory.getCurrentSession();
		try {
			session.save(comment);
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
	}

	@Override
	@Transactional
	public List<Comment> getCommentByVideoId(Integer id) {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "FROM Comment c WHERE c.video.id=:id";
			Query query = session.createQuery(hql).setParameter("id", id);
			List<Comment> comments = query.list();
			return comments;
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return null;
	}

	@Override
	@Transactional
	public Comment getCommentById(Integer id) {
		Session session = sessionFactory.getCurrentSession();
		try {
			Comment comment = (Comment) session.get(Comment.class, id);
			return comment;
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return new Comment();// {}
	}

	@Override
	@Transactional
	public void deleteComment(Integer id) {
		Session session = sessionFactory.getCurrentSession();
		try {
			Comment comment = getCommentById(id);
			session.delete(comment);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session = sessionFactory.openSession();
		}

	}

}
