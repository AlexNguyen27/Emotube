package ptit.projectjava.DAO.Impl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ptit.projectjava.DAO.ILikevsDislikeDAO;
import ptit.projectjava.entity.Dislike;
import ptit.projectjava.entity.Like;

@Repository
public class LikevsDislikeDAO implements ILikevsDislikeDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	@Transactional // return total like
	public Integer[] onClickLike(Like like) {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "From Like l where l.video.id=:videoId and l.user.id=:userId";
			Query query = session.createQuery(hql).setParameter("videoId", like.getVideo().getId())
					.setParameter("userId", like.getUser().getId());
			List<Like> likes = query.list();
			System.out.println(likes.size() <= 0);

			Integer totalLike = getLikeList(like.getVideo().getId()).size();
			Integer totalDislike = getDislikeList(like.getVideo().getId()).size();
			if (likes.size() <= 0) {
				session.save(like);
				Dislike dislike = userDislikedVideo(like.getUser().getId(), like.getVideo().getId());
				if (dislike != null) {
					session.delete(dislike);
					totalDislike -= 1;
				}
				return new Integer[] { totalLike + 1, totalDislike };
			} else {
				session.delete(likes.get(0));
				return new Integer[] { totalLike - 1, totalDislike };
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return new Integer[] { 0, 0 };

	}

	@Override
	@Transactional
	public List<Like> getLikeList(Integer videoId) {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "FROM Like l WHERE l.video.id=:videoId";
			Query query = session.createQuery(hql).setParameter("videoId", videoId);
			List<Like> likes = query.list();
			return likes;
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return null;
	}

	@Override
	@Transactional
	public Integer[] onClickDislike(Dislike dislike) {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "From Dislike dl where dl.video.id=:videoId and dl.user.id=:userId";
			Query query = session.createQuery(hql).setParameter("videoId", dislike.getVideo().getId())
					.setParameter("userId", dislike.getUser().getId());
			List<Dislike> dislikes = query.list();
			System.out.println(dislikes.size() <= 0);

			Integer totalDislike = getDislikeList(dislike.getVideo().getId()).size();
			Integer totalLike = getLikeList(dislike.getVideo().getId()).size();

			if (dislikes.size() <= 0) {
				session.save(dislike);

				// check if user liked video
				Like like = userLikedVideo(dislike.getUser().getId(), dislike.getVideo().getId());
				// user liked video 
				if (like != null) {
					session.delete(like);
					totalLike -= 1;
				}
				return new Integer[] { totalLike, totalDislike + 1 };
			} else {
				session.delete(dislikes.get(0));
				return new Integer[] { totalLike, totalDislike - 1 };
			}
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return new Integer[] { 0, 0 };
	}

	@Override
	@Transactional
	public List<Dislike> getDislikeList(Integer videoId) {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "FROM Dislike dl WHERE dl.video.id=:videoId";
			Query query = session.createQuery(hql).setParameter("videoId", videoId);
			List<Dislike> dislikes = query.list();
			return dislikes;
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return null;
	}

	@Override
	@Transactional
	public Like userLikedVideo(Integer userId, Integer videoId) {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "From Like l where l.video.id=:videoId and l.user.id=:userId";
			Query query = session.createQuery(hql).setParameter("videoId", videoId).setParameter("userId", userId);
			List<Like> likes = query.list();

			return likes.size() > 0 ? likes.get(0) : null;

		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return null;
	}

	@Override
	@Transactional
	public Dislike userDislikedVideo(Integer userId, Integer videoId) {
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "From Dislike dl where dl.video.id=:videoId and dl.user.id=:userId";
			Query query = session.createQuery(hql).setParameter("videoId", videoId).setParameter("userId", userId);
			List<Dislike> dislikes = query.list();

			return dislikes.size() > 0 ? dislikes.get(0) : null;

		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return null;
	}
}
