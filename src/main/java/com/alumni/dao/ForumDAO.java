package com.alumni.dao;

import com.alumni.model.ForumPost;
import com.alumni.util.DatabaseManager;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Sorts;

import java.util.ArrayList;
import java.util.List;

public class ForumDAO {
    private final MongoCollection<ForumPost> postCollection;

    public ForumDAO() {
        this.postCollection = DatabaseManager.getDatabase().getCollection("forum_posts", ForumPost.class);
    }

    public void createPost(ForumPost post) {
        postCollection.insertOne(post);
    }

    public List<ForumPost> getPosts(int page, int pageSize) {
        List<ForumPost> posts = new ArrayList<>();
        postCollection.find()
                .sort(Sorts.descending("timestamp"))
                .skip((page - 1) * pageSize)
                .limit(pageSize)
                .into(posts);
        return posts;
    }

    public long getTotalPosts() {
        return postCollection.countDocuments();
    }

    public void deletePost(String id) {
        postCollection.deleteOne(com.mongodb.client.model.Filters.eq("_id", new org.bson.types.ObjectId(id)));
    }
}
