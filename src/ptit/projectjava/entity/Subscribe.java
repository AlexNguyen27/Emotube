package ptit.projectjava.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="subscribe")
public class Subscribe {
	@Id
	@GeneratedValue
	private Integer id;

	@ManyToOne
	@JoinColumn(name="from_user")
	private User user_from;
	
	@ManyToOne
	@JoinColumn(name="to_user")
	private User user_to;

	public User getUser_from() {
		return user_from;
	}

	public void setUser_from(User user_from) {
		this.user_from = user_from;
	}

	public User getUser_to() {
		return user_to;
	}

	public void setUser_to(User user_to) {
		this.user_to = user_to;
	}
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	//from_user
	// to_user
}
