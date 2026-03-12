<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.blog.model.User" %>

<%-- Session check — redirect to login if not logged in --%>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect("login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home — BlogSpace</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/index.css">
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar">
        <div class="nav-brand">Blog<span>Space</span></div>
        <div class="nav-right">
            <span class="nav-welcome">
                Welcome, <strong><%= loggedInUser.getUsername() %></strong>
            </span>
            <a href="logout" class="btn-logout">Sign Out</a>
        </div>
    </nav>

    <!-- Hero Section -->
    <main class="main-content">
        <div class="hero">
            <h1 class="hero-title">
                Hello, <em><%= loggedInUser.getUsername() %></em> 👋
            </h1>
            <p class="hero-subtitle">
                What story will you tell today?
            </p>
            <a href="create-post" class="btn-write">
                + Write New Post
            </a>
        </div>

        <!-- Blog Posts Section -->
        <section class="posts-section">
            <h2 class="section-title">Latest Posts</h2>

            <%-- Posts will be loaded here later --%>
            <div class="empty-state">
                <div class="empty-icon">✍️</div>
                <p>No posts yet. Be the first to write!</p>
                <a href="create-post" class="btn-write-small">
                    Write your first post →
                </a>
            </div>

        </section>
    </main>

<script src="js/index.js"></script>
</body>
</html>