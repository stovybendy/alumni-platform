package com.alumni.model;

import org.bson.codecs.pojo.annotations.BsonId;
import org.bson.codecs.pojo.annotations.BsonProperty;
import org.bson.types.ObjectId;
import java.util.List;

public class User {
    @BsonId
    private ObjectId id;
    private String username;
    private String password;
    private String role; // admin veya user
    
    private String firstName;
    private String lastName;
    private String email;
    private String city;
    private String currentJob;
    private String currentSchool;
    private String gender;
    private List<String> hobbies;
    
    // Socials
    private String facebookId;
    private String twitterHandle;
    private String webAddress;
    
    private String profilePhotoUrl;

    public User() {}

    public ObjectId getId() { return id; }
    public void setId(ObjectId id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getCurrentJob() { return currentJob; }
    public void setCurrentJob(String currentJob) { this.currentJob = currentJob; }

    public String getCurrentSchool() { return currentSchool; }
    public void setCurrentSchool(String currentSchool) { this.currentSchool = currentSchool; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public List<String> getHobbies() { return hobbies; }
    public void setHobbies(List<String> hobbies) { this.hobbies = hobbies; }

    public String getFacebookId() { return facebookId; }
    public void setFacebookId(String facebookId) { this.facebookId = facebookId; }

    public String getTwitterHandle() { return twitterHandle; }
    public void setTwitterHandle(String twitterHandle) { this.twitterHandle = twitterHandle; }

    public String getWebAddress() { return webAddress; }
    public void setWebAddress(String webAddress) { this.webAddress = webAddress; }

    public String getProfilePhotoUrl() { return profilePhotoUrl; }
    public void setProfilePhotoUrl(String profilePhotoUrl) { this.profilePhotoUrl = profilePhotoUrl; }
}
