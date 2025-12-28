package com.alumni.dao;

import com.alumni.model.ProfileComment; 
import com.alumni.util.DatabaseManager;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Sorts;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.List;

public class MediaCommentDAO {
    private final MongoCollection<ProfileComment> commentCollection;

    public MediaCommentDAO() {
        this.commentCollection = DatabaseManager.getDatabase().getCollection("media_comments", ProfileComment.class);
    }

    public void addComment(ProfileComment comment) {
        commentCollection.insertOne(comment);
    }

    public List<ProfileComment> getCommentsForMedia(String targetId) {
        List<ProfileComment> comments = new ArrayList<>();
        commentCollection.find(Filters.eq("targetUserId", new ObjectId(targetId)))
                .sort(Sorts.descending("timestamp"))
                .into(comments);
        return comments;
    }
}
