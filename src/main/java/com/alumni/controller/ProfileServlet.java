package com.alumni.controller;

import com.alumni.dao.ProfileCommentDAO;
import com.alumni.dao.UserDAO;
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

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();
    private final ProfileCommentDAO commentDAO = new ProfileCommentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id == null) {
            resp.sendRedirect("people");
            return;
        }

        User profileUser = userDAO.getUserById(id);
        if (profileUser == null) {
            resp.sendRedirect("people");
            return;
        }

        List<ProfileComment> comments = commentDAO.getCommentsForUser(id);

        req.setAttribute("profileUser", profileUser);
        req.setAttribute("comments", comments);
        req.getRequestDispatcher("/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        String targetUserId = req.getParameter("targetUserId");
        String content = req.getParameter("content");

        if (targetUserId != null && content != null && !content.trim().isEmpty()) {
            ProfileComment comment = new ProfileComment();
            comment.setTargetUserId(new ObjectId(targetUserId));
            comment.setAuthorName(currentUser.getUsername());
            comment.setContent(content);
            comment.setTimestamp(new Date());

            commentDAO.addComment(comment);
        }

        resp.sendRedirect("profile?id=" + targetUserId);
    }
}
