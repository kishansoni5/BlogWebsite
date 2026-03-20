package com.blog.servlet;

import java.io.IOException;
import java.sql.SQLException;

import com.blog.dao.PostDAO;
import com.blog.model.Post;
import com.blog.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/editpost")
public class EditPostServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        try {
            String idParam = request.getParameter("id");
            int id = Integer.parseInt(idParam);
            PostDAO postDAO = new PostDAO();
            Post post = postDAO.getPostById(id);
            User loggedInUser = (User) session.getAttribute("user");
            if (loggedInUser.getId() == post.getUserId()) {
                request.setAttribute("post", post);
                request.getRequestDispatcher("editpost.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } catch (SQLException e) {
            response.sendRedirect("home");
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
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            int id = Integer.parseInt(idParam);
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            PostDAO postDAO = new PostDAO();
            Post post = postDAO.getPostById(id);
            User loggedInUser = (User) session.getAttribute("user");
            if (post == null || loggedInUser.getId() != post.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            if (title == null || title.trim().isEmpty() ||
                    content == null || content.trim().isEmpty()) {
                request.setAttribute("error", "All fields are required.");
                request.setAttribute("post", post);
                request.getRequestDispatcher("editpost.jsp").forward(request, response);
                return;
            }
            post.setTitle(title);
            post.setContent(content);
            if (postDAO.updatePost(post)) {
                response.sendRedirect("home");
            } else {
                request.setAttribute("error", "Update failed.");
                request.setAttribute("post", post);
                request.getRequestDispatcher("editpost.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }

}
