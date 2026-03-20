<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.blog.model.User" %>
<%@ page import="com.blog.model.Post" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect("login");
        return;
    }
    List<Post> posts = (List<Post>) request.getAttribute("posts");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home — BlogSpace</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/home.css">
</head>
<body>

    <nav class="navbar">
        <div class="nav-brand">Blog<span>Space</span></div>
        <div class="nav-right">
            <span class="nav-welcome">
                Welcome, <strong><%= loggedInUser.getUsername() %></strong>
            </span>
            <a href="createpost" class="btn-new-post">+ New Post</a>
            <a href="logout" class="btn-logout">Sign Out</a>
        </div>
    </nav>

    <main class="main-content">

        <div class="hero">
            <h1 class="hero-title">
                Hello, <em><%= loggedInUser.getUsername() %></em> 👋
            </h1>
            <p class="hero-subtitle">What story will you tell today?</p>
            <a href="createpost" class="btn-write">+ Write New Post</a>
        </div>

        <section class="posts-section">
            <h2 class="section-title">Latest Posts</h2>

            <% if (error != null && !error.isEmpty()) { %>
                <div class="error-banner" id="errorBanner"><%= error %></div>
            <% } %>

            <% if (posts == null || posts.isEmpty()) { %>
                <div class="empty-state">
                    <div class="empty-icon">✍️</div>
                    <p>No posts yet. Be the first to write!</p>
                    <a href="createpost" class="btn-write-small">Write your first post →</a>
                </div>

            <% } else { %>
                <div class="posts-feed">
                    <% for (Post post : posts) { %>
                        <article class="post-card">
                            <a href="post?id=<%= post.getId() %>" class="post-card-link">
                                <div class="post-card-meta">
                                    <span class="post-card-author"><%= post.getAuthorName() %></span>
                                    <span class="post-card-dot">·</span>
                                    <span class="post-card-date"><%= new SimpleDateFormat("dd MMM yyyy").format(post.getCreatedAt()) %></span>
                                </div>
                                <h3 class="post-card-title"><%= post.getTitle() %></h3>
                                <p class="post-card-preview"><%
                                    String content = post.getContent();
                                    out.print(content.length() > 200 ? content.substring(0, 200) + "..." : content);
                                %></p>
                                <span class="post-card-readmore">Read more →</span>
                            </a>
                        </article>
                    <% } %>
                </div>
            <% } %>

        </section>
    </main>

    <script src="js/home.js"></script>
</body>
</html>
