<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.blog.model.User" %>
<%@ page import="com.blog.model.Post" %>
<%@ page import="java.util.List" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        response.sendRedirect("login");
        return;
    }
    User currentUser = (User) userSession.getAttribute("user");
    List<Post> posts = (List<Post>) request.getAttribute("posts");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Blog</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/index.css">
</head>
<body>

    <nav class="navbar">
        <a href="/" class="nav-brand">The Blog</a>
        <div class="nav-right">
            <span class="nav-user">Hi, <%= currentUser.getUsername() %></span>
            <a href="create-post" class="btn-write">Write a Post</a>
            <a href="logout" class="nav-logout">Logout</a>
        </div>
    </nav>

    <main class="main-container">

        <div class="page-header">
            <h1 class="page-title">Latest Posts</h1>
            <p class="page-subtitle">Thoughts from the community</p>
        </div>

        <% if (error != null && !error.isEmpty()) { %>
            <div class="error-banner" id="errorBanner">
                <span class="error-icon">✕</span>
                <%= error %>
            </div>
        <% } %>

        <% if (posts == null || posts.isEmpty()) { %>
            <div class="empty-state">
                <div class="empty-icon">✏</div>
                <h2 class="empty-title">No posts yet</h2>
                <p class="empty-text">Be the first to share something with the world.</p>
                <a href="create-post" class="btn-empty">Write the first post</a>
            </div>

        <% } else { %>
            <div class="posts-feed">
                <% for (Post post : posts) { %>
                    <article class="post-card">
                        <a href="post?id=<%= post.getId() %>" class="post-link">
                            <div class="post-meta">
                                <span class="post-author">Post #<%= post.getUserId() %></span>
                                <span class="post-dot">·</span>
                                <span class="post-date"><%= post.getCreatedAt() %></span>
                            </div>
                            <h2 class="post-title"><%= post.getTitle() %></h2>
                            <p class="post-preview">
                                <%
                                    String content = post.getContent();
                                    String preview = content.length() > 200
                                        ? content.substring(0, 200) + "..."
                                        : content;
                                    out.print(preview);
                                %>
                            </p>
                            <span class="post-readmore">Read more →</span>
                        </a>
                    </article>
                <% } %>
            </div>
        <% } %>

    </main>

    <script src="js/index.js"></script>
</body>
</html>
