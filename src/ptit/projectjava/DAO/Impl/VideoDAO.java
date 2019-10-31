package ptit.projectjava.DAO.Impl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ptit.projectjava.DAO.IVideoDAO;
import ptit.projectjava.entity.Category;
import ptit.projectjava.entity.Video;

@Repository
public class VideoDAO implements IVideoDAO {

	@Autowired
	SessionFactory sessionFactory;

	@Override
	@Transactional
	public List<Video> getVideoListByCategoryId(Integer categoryID) {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "FROM Video v where v.category.id =:id";
			Query query = session.createQuery(hql).setParameter("id", categoryID);
			List<Video> videos = query.list();
			return videos.size() > 0 ? videos : new ArrayList<>();
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return new ArrayList<>(); // {}
	}

	@Override
	@Transactional
	public List<Video> getVideoListByUserId(Integer userID) {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "FROM Video v where v.user.id =:id";
			Query query = session.createQuery(hql).setParameter("id", userID);
			List<Video> videos = query.list();
			return videos.size() > 0 ? videos : new ArrayList<>();
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return new ArrayList<>(); // {}
	}

	@Override
	@Transactional
	public void addNewVideo(Video video) {
		Session session = sessionFactory.getCurrentSession();
		try {
			session.save(video);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
	}

	@Override
	@Transactional
	public void deleteVideo(Integer id) {
		Session session = sessionFactory.getCurrentSession();
		try {
			Video video = getVideoById(id);
			session.delete(video);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
	}

	@Override
	@Transactional
	public void updateVideo(Video video) {
		Session session = sessionFactory.getCurrentSession();
		try {
			session.update(video);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
	}

	@Override
	@Transactional
	public Video getVideoById(Integer id) {
		Session session = sessionFactory.getCurrentSession();
		try {
			Video video = (Video) session.get(Video.class, id);
			return video;
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return new Video();// {}
	}
	
	@Override
	@Transactional
	public void updateViewVideo(Integer id, Integer number) {
		Session session = sessionFactory.getCurrentSession();
		try {
			Video video = (Video) session.get(Video.class, id);
			video.setViews(video.getViews() + number);
			session.update(video);
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
	}

	@Override
	@Transactional
	public List<Video> getVideoList() {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "FROM Video";
			Query query = session.createQuery(hql);
			List<Video> videos = query.list();
			return videos;
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return new ArrayList<Video>();
	}

	@Override
	@Transactional
	public List<Video> getPublicVideoList() {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "FROM Video v WHERE v.privacy=0";
			Query query = session.createQuery(hql);
			List<Video> videos = query.list();
			return videos;
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return new ArrayList<Video>();
	}

	@Override
	@Transactional
	public List<Video> getPublicVideoListByCategoryId(Integer categoriID) {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "FROM Video v where v.category.id =:id and v.privacy=0";
			Query query = session.createQuery(hql).setParameter("id", categoriID);
			List<Video> videos = query.list();
			return videos.size() > 0 ? videos : new ArrayList<>();
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return new ArrayList<>(); // {}
	}

}
