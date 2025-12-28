package com.alumni.model;

import org.bson.codecs.pojo.annotations.BsonId;
import org.bson.types.ObjectId;
import java.util.Date;

public class ForumPost {
    @BsonId
    private ObjectId id;
    private ObjectId userId;
    private String authorName;
    private String content;
    private Date timestamp;

    public ForumPost() {}

    public ObjectId getId() { return id; }
    public void setId(ObjectId id) { this.id = id; }

    public ObjectId getUserId() { return userId; }
    public void setUserId(ObjectId userId) { this.userId = userId; }

    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Date getTimestamp() { return timestamp; }
    public void setTimestamp(Date timestamp) { this.timestamp = timestamp; }
}
