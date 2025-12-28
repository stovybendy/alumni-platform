package com.alumni.dao;

import com.alumni.model.MediaItem;
import com.alumni.util.DatabaseManager;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Sorts;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.List;

public class MediaDAO {
    private final MongoCollection<MediaItem> mediaCollection;

    public MediaDAO() {
        this.mediaCollection = DatabaseManager.getDatabase().getCollection("media_items", MediaItem.class);
    }

    public void addMedia(MediaItem item) {
        mediaCollection.insertOne(item);
    }

    public List<MediaItem> getMediaByType(String type) {
        List<MediaItem> items = new ArrayList<>();
        mediaCollection.find(Filters.eq("type", type))
                .sort(Sorts.descending("timestamp"))
                .into(items);
        return items;
    }

    public MediaItem getMediaById(String id) {
        return mediaCollection.find(Filters.eq("_id", new ObjectId(id))).first();
    }
}
