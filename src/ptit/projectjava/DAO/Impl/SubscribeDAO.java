package ptit.projectjava.DAO.Impl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ptit.projectjava.DAO.ISubscribeDAO;
import ptit.projectjava.entity.Subscribe;

@Repository
public class SubscribeDAO implements ISubscribeDAO {

	@Autowired
	SessionFactory sessionFactory;
	
	@Override
	@Transactional
	public Integer onClickSubscribe(Subscribe subscribe) {
		Session session = sessionFactory.getCurrentSession();
		try {
			Subscribe sub = isSubscribed(subscribe.getUser_to().getId(), subscribe.getUser_from().getId());
			System.out.println(sub);
			// do not subscribe yet
			if(sub == null) {
				session.save(subscribe);
				// save
				return 1;
			}else {
				session.delete(sub);
				// delete
				return 0;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		
		return 0;
	}
	
	// Check if user subscribed other
	@Override
	@Transactional
	public Subscribe isSubscribed(Integer toUserId, Integer fromUserId) {
		System.out.println(toUserId);
		System.out.println(fromUserId);
		Session session = sessionFactory.getCurrentSession();
		try {
			String hql = "From Subscribe s where s.user_from.id=:fromUserId and s.user_to.id=:toUserId";
			Query query = session.createQuery(hql).setParameter("fromUserId", fromUserId).setParameter("toUserId", toUserId);
			List<Subscribe> subs = query.list();
			System.out.println(subs);
			return subs.size() > 0 ? subs.get(0) : null;
		} catch (Exception e) {
			e.printStackTrace();
			session = sessionFactory.openSession();
		}
		return null;
	}
	
	
}
