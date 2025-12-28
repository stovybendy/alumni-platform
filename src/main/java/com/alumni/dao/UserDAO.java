package com.alumni.dao;

import com.alumni.model.User;
import com.alumni.util.DatabaseManager;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Filters;
import org.bson.types.ObjectId;
import at.favre.lib.crypto.bcrypt.BCrypt;

import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private final MongoCollection<User> userCollection;

    public UserDAO() {
        this.userCollection = DatabaseManager.getDatabase().getCollection("users", User.class);
    }

    public void registerUser(User user) {
        String hashedPassword = BCrypt.withDefaults().hashToString(12, user.getPassword().toCharArray());
        user.setPassword(hashedPassword);
        userCollection.insertOne(user);
    }

    public User loginUser(String username, String password) {
        User user = userCollection.find(Filters.eq("username", username)).first();
        if (user != null) {
            BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), user.getPassword());
            if (result.verified) {
                return user;
            }
        }
        return null;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        userCollection.find().into(users);
        return users;
    }

    public User getUserById(String id) {
        try {
            return userCollection.find(Filters.eq("_id", new ObjectId(id))).first();
        } catch (IllegalArgumentException e) {
            return null;
        }
    }

    public void updateUser(User user) {
        userCollection.replaceOne(Filters.eq("_id", user.getId()), user);
    }

    public void deleteUser(String id) {
        userCollection.deleteOne(Filters.eq("_id", new ObjectId(id)));
    }
    
    public void makeAdmin(String id) {
        User user = getUserById(id);
        if (user != null) {
            user.setRole("admin");
            updateUser(user);
        }
    }
}
