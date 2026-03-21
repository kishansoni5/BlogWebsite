package com.blog.servlet;

import java.io.IOException;

import com.blog.dao.PostDAO;
import com.blog.model.Post;
import com.blog.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.annotation.WebServlet;;

@WebServlet("/deletepost")
public class DeletePostServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("/home");
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
            User loggedInUser = (User) session.getAttribute("user");
            if (post == null || loggedInUser.getId() != post.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            if (postDAO.deletePost(id)) {
                response.sendRedirect("home");
            } else {
                request.setAttribute("error", "Delete failed.");
                request.setAttribute("post", post);
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }

}
