package ptit.projectjava.DAO;

import java.util.List;

import ptit.projectjava.entity.Video;

public interface IVideoDAO {
	public List<Video> getPublicVideoListByCategoryId(Integer categoriID);

	public List<Video> getVideoListByCategoryId(Integer categoriID);

	public List<Video> getVideoListByUserId(Integer userID);

	public List<Video> getPublicVideoList();

	public List<Video> getVideoList();

	public void addNewVideo(Video video);

	public void deleteVideo(Integer id);

	public void updateVideo(Video video);

	public Video getVideoById(Integer id);

	public void updateViewVideo(Integer id, Integer number);

}
