<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.blog.model.User" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        response.sendRedirect("login");
        return;
    }
    User currentUser = (User) userSession.getAttribute("user");
    String error = (String) request.getAttribute("error");
    String prevTitle = request.getParameter("title") != null ? request.getParameter("title") : "";
    String prevContent = request.getParameter("content") != null ? request.getParameter("content") : "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Write a Post — Blog</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/create-post.css">
</head>
<body>

    <nav class="navbar">
        <a href="/" class="nav-brand">The Blog</a>
        <div class="nav-right">
            <span class="nav-user">Hi, <%= currentUser.getUsername() %></span>
            <a href="logout" class="nav-logout">Logout</a>
        </div>
    </nav>

    <main class="main-container">

        <div class="page-header">
            <h1 class="page-title">Write a Post</h1>
            <p class="page-subtitle">Share your thoughts with the world</p>
        </div>

        <% if (error != null && !error.isEmpty()) { %>
            <div class="error-banner" id="errorBanner">
                <span class="error-icon">✕</span>
                <%= error %>
            </div>
        <% } %>

        <form action="create-post" method="post" class="post-form" id="postForm">

            <div class="form-group">
                <label for="title" class="form-label">Title</label>
                <input
                    type="text"
                    id="title"
                    name="title"
                    class="form-input"
                    placeholder="Give your post a title..."
                    value="<%= prevTitle %>"
                    maxlength="255"
                    autocomplete="off"
                />
                <span class="char-count" id="titleCount">0 / 255</span>
            </div>

            <div class="form-group">
                <label for="content" class="form-label">Content</label>
                <textarea
                    id="content"
                    name="content"
                    class="form-textarea"
                    placeholder="Write your post here..."
                    rows="16"
                ><%= prevContent %></textarea>
            </div>

            <div class="form-actions">
                <a href="/" class="btn-cancel">Cancel</a>
                <button type="submit" class="btn-publish" id="submitBtn">
                    <span class="btn-text">Publish Post</span>
                    <span class="btn-loading" style="display:none;">Publishing...</span>
                </button>
            </div>

        </form>

    </main>

    <script src="js/create-post.js"></script>
</body>
</html>
