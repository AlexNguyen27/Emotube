package ptit.projectjava.entity;

import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="users")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private String email;
	private String first_name;
	private String last_name;
	private String password;
	private String	profile_image;
	private String user_name;
	private String role;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	private Collection<Video> videos;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	private Collection<Comment> comments;
	
	// from_user, to_user
	@OneToMany(mappedBy = "user_from", fetch = FetchType.EAGER)
	private Collection<Subscribe> subscribes_from;
	
	@OneToMany(mappedBy = "user_to", fetch = FetchType.EAGER)
	private Collection<Subscribe> subscribes_to;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	private Collection<CommentLike> commentLikes;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	private Collection<CommentDislike> commentDislikes;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	private Collection<Dislike> dislikes;
	
	@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	private Collection<Like> likes;
	
	public Collection<Comment> getComments() {
		return comments;
	}
	public void setComments(Collection<Comment> comments) {
		this.comments = comments;
	}
	public Collection<Subscribe> getSubscribes_from() {
		return subscribes_from;
	}
	public void setSubscribes_from(Collection<Subscribe> subscribes_from) {
		this.subscribes_from = subscribes_from;
	}
	public Collection<Subscribe> getSubscribes_to() {
		return subscribes_to;
	}
	public void setSubscribes_to(Collection<Subscribe> subscribes_to) {
		this.subscribes_to = subscribes_to;
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
	public Collection<Dislike> getDislikes() {
		return dislikes;
	}
	public void setDislikes(Collection<Dislike> dislikes) {
		this.dislikes = dislikes;
	}
	public Collection<Like> getLikes() {
		return likes;
	}
	public void setLikes(Collection<Like> likes) {
		this.likes = likes;
	}
	
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public Collection<Video> getVideos() {
		return videos;
	}
	public void setVideos(Collection<Video> videos) {
		this.videos = videos;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFirst_name() {
		return first_name;
	}
	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}
	public String getLast_name() {
		return last_name;
	}
	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getProfile_image() {
		return profile_image;
	}
	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	
	
}	
