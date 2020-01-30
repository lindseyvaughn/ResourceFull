package com.codingdojo.resourcefull.models;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

import com.google.gson.annotations.Expose;

@Entity
@Table(name="community")
public class Community {
	
//----------------------------------------------------------------
//	Attributes
//----------------------------------------------------------------
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	//to be input from user
	@Expose
	@Size (min=1, message="Must select name from the list")
	private String name;
	
	@Expose
	private String location;
	
	private int residents; 
	
	private int pets;
	

	private double lat;
	
	private double longitude;
	
	@ElementCollection
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@OrderBy("food_filled_at desc")
	private List<Date> food_filledAt;
	
	@ElementCollection
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@OrderBy("water_filled_at desc")
	private List<Date> water_filledAt;
	
	@ElementCollection
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@OrderBy("hygienekits_filled_at desc")
	private List<Date> hygienekits_filledAt;
	
	private String liaisoncontactname;
	
	private String liaisoncontactnumber; 
	
	@Column(updatable=false)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdAt;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updatedAt;
	
	
//----------------------------------------------------------------
//	Relationships
//----------------------------------------------------------------
	@OneToMany(mappedBy="community", fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	@OrderBy("createdAt desc")
	private List<Message> messages;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="creator_id")
	private User creator;
//----------------------------------------------------------------
//	Constructors
//----------------------------------------------------------------
	public Community() {
		
	}

	public Community(Long id, int residents, int pets, int water, int hygienekits,
			String liaisoncontactname, String liaisoncontactnumber, Date createdAt, Date updatedAt, String location, String name) {
		super();
		this.id = id;
		this.name = name;
		this.residents = residents;
		this.pets = pets;
		this.location = location;
		this.setLiaisoncontactname(liaisoncontactname);
		this.setLiaisoncontactnumber(liaisoncontactnumber);
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}
//----------------------------------------------------------------
//	Getters and Setters
//----------------------------------------------------------------
	
	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public int getResidents() {
		return residents;
	}
	public void setResidents(int residents) {
		this.residents = residents;
	}
	public int getPets() {
		return pets;
	}
	public void setPets(int pets) {
		this.pets = pets;
	}
	public int getWater() {
		return (residents * 4)+(pets * 3);
	}
	public int getHygienekits() {
		return (residents*5);
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getFood() {
		return (residents * 21);
	}
	public String getLiaisoncontactname() {
		return liaisoncontactname;
	}
	public void setLiaisoncontactname(String liaisoncontactname) {
		this.liaisoncontactname = liaisoncontactname;
	}
	public String getLiaisoncontactnumber() {
		return liaisoncontactnumber;
	}
	public void setLiaisoncontactnumber(String liaisoncontactnumber) {
		this.liaisoncontactnumber = liaisoncontactnumber;
	}

	public List<Date> getFood_filledAt() {
		return food_filledAt;
	}

	public void setFood_filledAt(List<Date> food_filledAt) {
		this.food_filledAt = food_filledAt;
	}

	public List<Date> getWater_filledAt() {
		return water_filledAt;
	}

	public void setWater_filledAt(List<Date> water_filledAt) {
		this.water_filledAt = water_filledAt;
	}

	public List<Date> getHygienekits_filledAt() {
		return hygienekits_filledAt;
	}

	public void setHygienekits_filledAt(List<Date> hygienekits_filledAt) {
		this.hygienekits_filledAt = hygienekits_filledAt;
	}

	public List<Message> getMessages() {
		return messages;
	}

	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}

	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}
	
}
