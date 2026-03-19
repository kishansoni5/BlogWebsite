package com.blog.servlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import com.blog.dao.PostDAO;
import com.blog.model.Post;
import com.blog.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/createpost")
public class CreatePostServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("user") != null) {
            request.getRequestDispatcher("createpost.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        if (title == null || title.trim().isEmpty() ||
                content == null || content.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("createpost.jsp").forward(request, response);
            return;
        }
        Post post = new Post();
        User loggedInUser = (User) session.getAttribute("user");
        post.setUserId(loggedInUser.getId());
        post.setTitle(title);
        post.setContent(content);
        post.setStatus("published");

        PostDAO postDAO = new PostDAO();
        try {
            boolean success = postDAO.savePost(post);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                request.setAttribute("error", "Failed to create post. Please try again.");
                request.getRequestDispatcher("createpost.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error. Please try again.");
            request.getRequestDispatcher("createpost.jsp").forward(request, response);
        }
    }

}
