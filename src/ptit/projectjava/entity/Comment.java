package ptit.projectjava.entity;

import java.util.Collection;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="comments")
public class Comment {
	@Id
	@GeneratedValue
	private Integer id;
	
	@Temporal(TemporalType.DATE)
	@DateTimeFormat(pattern = "dd/mm/yyyy")
	private Date date;
	
	private String comment;

	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="video_id")
	private Video video;
	
	@OneToMany(mappedBy = "commentLike", fetch = FetchType.EAGER)
	private Collection<CommentLike> commentLikes;
	
	@OneToMany(mappedBy = "commentDislike", fetch = FetchType.EAGER)
	private Collection<CommentDislike> commentDislikes;
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Video getVideo() {
		return video;
	}

	public void setVideo(Video video) {
		this.video = video;
	}

	public Collection<CommentLike> getCommentLikes() {
		return commentLikes;
	}

	public void setCommentLikes(Collection<CommentLike> commentLikes) {
		this.commentLikes = commentLikes;
	}

	public Collection<CommentDislike> getCommentDislikes() {
		return commentDislikes;
	}

	public void setCommentDislikes(Collection<CommentDislike> commentDislikes) {
		this.commentDislikes = commentDislikes;
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	// video_id
	// user_id
}
