package ptit.projectjava.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="comment_dislikes")
public class CommentDislike {
	@Id
	@GeneratedValue
	private Integer id;

	@ManyToOne
	@JoinColumn(name="comment_id")
	private Comment commentDislike;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Comment getCommentDislike() {
		return commentDislike;
	}

	public void setCommentDislike(Comment commentDislike) {
		this.commentDislike = commentDislike;
	}
	
	// comment_id
	// user_id
}
