package ptit.projectjava.DAO;

import ptit.projectjava.entity.Subscribe;

public interface ISubscribeDAO {

	public Integer onClickSubscribe(Subscribe subscribe);

	public Subscribe isSubscribed(Integer toUserId, Integer fromUserId);
}
