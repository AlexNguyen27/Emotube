package ptit.projectjava.DAO;

import java.util.List;

import ptit.projectjava.entity.Comment;

public interface ICommentDAO {
	public void addComment(Comment comment);

	public List<Comment> getCommentByVideoId(Integer id);

	public Comment getCommentById(Integer id);
	
	public void deleteComment(Integer id);
}
