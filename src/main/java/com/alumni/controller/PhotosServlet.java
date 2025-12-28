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

@WebServlet(urlPatterns = {"/photos", "/photo"})
public class PhotosServlet extends HttpServlet {
    private final MediaDAO mediaDAO = new MediaDAO();
    private final MediaCommentDAO commentDAO = new MediaCommentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        
        if (path.equals("/photos")) {
            List<MediaItem> photos = mediaDAO.getMediaByType("photo");
            req.setAttribute("photos", photos);
            req.getRequestDispatcher("/photos.jsp").forward(req, resp);
        } else if (path.equals("/photo")) {
            String id = req.getParameter("id");
            if (id == null) { resp.sendRedirect("photos"); return; }
            
            MediaItem photo = mediaDAO.getMediaById(id);
            List<ProfileComment> comments = commentDAO.getCommentsForMedia(id);
            req.setAttribute("photo", photo);
            req.setAttribute("comments", comments);
            req.getRequestDispatcher("/photo.jsp").forward(req, resp);
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
        
        if ("add_photo".equals(action)) {
            String url = req.getParameter("url");
            String desc = req.getParameter("description");
            MediaItem item = new MediaItem();
            item.setType("photo");
            item.setUrl(url);
            item.setDescription(desc);
            item.setTimestamp(new Date());
            mediaDAO.addMedia(item);
            resp.sendRedirect("photos");
        } else if ("add_comment".equals(action)) {
            String mediaId = req.getParameter("mediaId");
            String content = req.getParameter("content");
            
            ProfileComment comment = new ProfileComment();
            comment.setTargetUserId(new ObjectId(mediaId));
            comment.setAuthorName(user.getUsername());
            comment.setContent(content);
            comment.setTimestamp(new Date());
            
            commentDAO.addComment(comment);
            resp.sendRedirect("photo?id=" + mediaId);
        }
    }
}
