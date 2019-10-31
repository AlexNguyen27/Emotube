package ptit.projectjava.DAO;

import java.util.List;

import ptit.projectjava.entity.Dislike;
import ptit.projectjava.entity.Like;

public interface ILikevsDislikeDAO {
	// Like video
	public Integer[] onClickLike(Like like);
	public Dislike userDislikedVideo(Integer userId, Integer videoId);
	public List<Like> getLikeList(Integer videoId);

	// Dislike video
	public Integer[] onClickDislike(Dislike dislike);
	public Like userLikedVideo(Integer userId, Integer videoId);
	public List<Dislike> getDislikeList(Integer videoId);
}
