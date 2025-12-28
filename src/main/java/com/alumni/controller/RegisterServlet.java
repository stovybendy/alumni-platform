package com.alumni.controller;

import com.alumni.dao.UserDAO;
import com.alumni.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String city = req.getParameter("city");
        String currentJob = req.getParameter("currentJob");
        String currentSchool = req.getParameter("currentSchool");
        String gender = req.getParameter("gender");
        String[] hobbies = req.getParameterValues("hobbies");

        // Basic validation (can be improved)
        if (username == null || password == null || email == null) {
            req.setAttribute("error", "Zorunlu alanlar eksik.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setCity(city);
        user.setCurrentJob(currentJob);
        user.setCurrentSchool(currentSchool);
        user.setGender(gender);
        user.setRole("user"); // Default role
        
        if (hobbies != null) {
            user.setHobbies(Arrays.asList(hobbies));
        }

        try {
            userDAO.registerUser(user);
            resp.sendRedirect(req.getContextPath() + "/login.jsp?registered=true");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Registration failed: " + e.getMessage());
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}
