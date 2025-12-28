package com.alumni.controller;

import com.alumni.dao.UserDAO;
import com.alumni.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/user-management")
public class UserManagementServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        if (!"admin".equals(currentUser.getRole())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Yetkisiz işlem.");
            return;
        }

        String action = req.getParameter("action");
        String targetId = req.getParameter("id");

        if (targetId != null && !targetId.isEmpty()) {
            if ("delete".equals(action)) {
                if (!currentUser.getId().toString().equals(targetId)) {
                    userDAO.deleteUser(targetId);
                }
            } else if ("make_admin".equals(action)) {
                userDAO.makeAdmin(targetId);
            }
        }

        String referer = req.getHeader("Referer");
        String redirectUrl = (referer != null && !referer.isEmpty()) ? referer : "people";
        
        if (redirectUrl.contains("?")) {
            redirectUrl = redirectUrl.substring(0, redirectUrl.indexOf("?"));
        }
        
        redirectUrl += "?msg=" + action + "_success";
        
        resp.sendRedirect(redirectUrl);
    }
}
