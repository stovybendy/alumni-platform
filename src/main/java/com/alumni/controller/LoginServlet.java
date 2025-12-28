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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userDAO.loginUser(username, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
        } else {
            req.setAttribute("error", "Geçersiz kullanıcı adı veya şifre.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}
