<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.blog.model.User" %>
<%@ page import="com.blog.model.Post" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        response.sendRedirect("login");
        return;
    }
    User currentUser = (User) userSession.getAttribute("user");
    Post post = (Post) request.getAttribute("post");
    if (post == null) {
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Post — BlogSpace</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editpost.css">
</head>
<body>

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="nav-brand">Blog<span>Space</span></a>
        <div class="nav-right">
            <span class="nav-user">Hi, <%= currentUser.getUsername() %></span>
            <a href="${pageContext.request.contextPath}/logout" class="nav-logout">Sign Out</a>
        </div>
    </nav>

    <main class="main-container">

        <div class="page-header">
            <a href="${pageContext.request.contextPath}/home" class="back-link">← Back to feed</a>
            <h1 class="page-title">Edit Post</h1>
            <p class="page-subtitle">Update your story</p>
        </div>

        <% if (error != null && !error.isEmpty()) { %>
            <div class="error-banner" id="errorBanner">
                <span class="error-icon">✕</span>
                <%= error %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/editpost" method="post" class="post-form" id="editForm">

            <input type="hidden" name="id" value="<%= post.getId() %>">

            <div class="form-group">
                <label for="title" class="form-label">Title</label>
                <input
                    type="text"
                    id="title"
                    name="title"
                    class="form-input"
                    value="<%= post.getTitle() %>"
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
                    rows="16"
                ><%= post.getContent() %></textarea>
            </div>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/home" class="btn-cancel">Cancel</a>
                <button type="submit" class="btn-save" id="submitBtn">
                    <span class="btn-text">Save Changes</span>
                    <span class="btn-loading" style="display:none;">Saving...</span>
                </button>
            </div>

        </form>

    </main>

    <script src="${pageContext.request.contextPath}/js/editpost.js"></script>
</body>
</html>
