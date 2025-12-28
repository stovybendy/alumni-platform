package com.alumni.controller;

import com.alumni.dao.ForumDAO;
import com.alumni.model.ForumPost;
import com.alumni.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/forum")
public class ForumServlet extends HttpServlet {
    private final ForumDAO forumDAO = new ForumDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        int pageSize = 5;
        
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
            }
        }

        List<ForumPost> posts = forumDAO.getPosts(page, pageSize);

        long totalPosts = forumDAO.getTotalPosts();
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

        req.setAttribute("posts", posts);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        
        req.getRequestDispatcher("/forum.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if ("delete".equals(req.getParameter("action"))) {
            if ("admin".equals(user.getRole())) {
                String id = req.getParameter("id");
                 forumDAO.deletePost(id);
            }
            resp.sendRedirect("forum");
            return;
        }

        String content = req.getParameter("content");

        if (content != null && !content.trim().isEmpty()) {
            ForumPost post = new ForumPost();
            post.setUserId(user.getId());
            post.setAuthorName(user.getUsername()); // Or First Name + Last Name
            post.setContent(content);
            post.setTimestamp(new Date());
            
            forumDAO.createPost(post);
        }

        resp.sendRedirect("forum");
    }
}
