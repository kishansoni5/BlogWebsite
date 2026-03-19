package com.blog.servlet;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.blog.dao.UserDAO;
import com.blog.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        if (email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);
        if (user == null) {
            request.setAttribute("error", "Email not registered!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        } else {
            if (BCrypt.checkpw(password, user.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                request.setAttribute("error", "Invalid password!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }

    }
}
