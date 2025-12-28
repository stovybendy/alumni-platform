package com.alumni.model;

import org.bson.codecs.pojo.annotations.BsonId;
import org.bson.types.ObjectId;
import java.util.Date;
import java.util.List;

public class MediaItem {
    @BsonId
    private ObjectId id;
    private String type; // "photo" or "video"
    private String url; // Image URL or Youtube Video ID
    private String description;
    private Date timestamp;
    
    // For Photo tagging (simple approximation)
    // Format: "x,y,radius,userId"
    private List<String> tags; 

    public MediaItem() {}

    public ObjectId getId() { return id; }
    public void setId(ObjectId id) { this.id = id; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getTimestamp() { return timestamp; }
    public void setTimestamp(Date timestamp) { this.timestamp = timestamp; }

    public List<String> getTags() { return tags; }
    public void setTags(List<String> tags) { this.tags = tags; }
}
