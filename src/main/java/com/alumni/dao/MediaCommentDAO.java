package com.alumni.dao;

import com.alumni.model.ProfileComment; 
// Reusing ProfileComment class structure since fields are identical (targetId, author, content, time)
// In a real app I'd rename it to 'Comment' but strict separation is fine too. 
// Actually, let's just make a new simple class inside logic or reuse. 
// To avoid confusion, I'll use ProfileComment but map it to 'media_comments'.
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
