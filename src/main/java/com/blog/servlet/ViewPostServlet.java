package com.blog.servlet;

import java.io.IOException;
import java.sql.SQLException;

import com.blog.dao.PostDAO;
import com.blog.model.Post;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/post")
public class ViewPostServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        PostDAO postDAO = new PostDAO();
        try {
            Post post = postDAO.getPostById(id);
            if (post != null) {
                request.setAttribute("post", post);
                request.getRequestDispatcher("post.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error. Please try again.");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }

}