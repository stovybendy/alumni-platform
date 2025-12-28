package com.alumni.controller;

import com.alumni.dao.MediaCommentDAO;
import com.alumni.dao.MediaDAO;
import com.alumni.model.MediaItem;
import com.alumni.model.ProfileComment;
import com.alumni.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.bson.types.ObjectId;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = {"/videos", "/video"})
public class VideosServlet extends HttpServlet {
    private final MediaDAO mediaDAO = new MediaDAO();
    private final MediaCommentDAO commentDAO = new MediaCommentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        
        if (path.equals("/videos")) {
            List<MediaItem> videos = mediaDAO.getMediaByType("video");
            req.setAttribute("videos", videos);
            req.getRequestDispatcher("/videos.jsp").forward(req, resp);
        } else if (path.equals("/video")) {
            String id = req.getParameter("id");
            if (id == null) { resp.sendRedirect("videos"); return; }
            
            MediaItem video = mediaDAO.getMediaById(id);
            List<ProfileComment> comments = commentDAO.getCommentsForMedia(id);
            req.setAttribute("video", video);
            req.setAttribute("comments", comments);
            req.getRequestDispatcher("/video.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        
        String action = req.getParameter("action");
        
        if ("add_video".equals(action)) {
            String url = req.getParameter("url"); 
            String desc = req.getParameter("description");
            MediaItem item = new MediaItem();
            item.setType("video");
            
            String videoId = extractVideoId(url);
            item.setUrl(videoId);
            
            item.setDescription(desc);
            item.setTimestamp(new Date());
            mediaDAO.addMedia(item);
            resp.sendRedirect("videos");
        } else if ("add_comment".equals(action)) {
            String mediaId = req.getParameter("mediaId");
            String content = req.getParameter("content");
            
            ProfileComment comment = new ProfileComment();
            comment.setTargetUserId(new ObjectId(mediaId));
            comment.setAuthorName(user.getUsername());
            comment.setContent(content);
            comment.setTimestamp(new Date());
            
            commentDAO.addComment(comment);
            resp.sendRedirect("video?id=" + mediaId);
        }
    }
}
