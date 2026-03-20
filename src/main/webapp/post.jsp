<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.blog.model.User" %>
<%@ page import="com.blog.model.Post" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= post.getTitle() %> — The Blog</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/post.css">
</head>
<body>

    <nav class="navbar">
        <a href="home" class="nav-brand">The Blog</a>
        <div class="nav-right">
            <span class="nav-user">Hi, <%= currentUser.getUsername() %></span>
            <a href="createpost" class="btn-write">Write a Post</a>
            <a href="logout" class="nav-logout">Logout</a>
        </div>
    </nav>

    <main class="main-container">

        <a href="home" class="back-link">← Back to feed</a>

        <article class="post-article">

            <header class="post-header">
                <div class="post-meta">
                    <span class="post-author"><%= post.getAuthorName() %></span>
                    <span class="post-dot">·</span>
                    <span class="post-date"><%= new SimpleDateFormat("dd MMM yyyy").format(post.getCreatedAt()) %></span>
                </div>
                <h1 class="post-title"><%= post.getTitle() %></h1>
            </header>

            <div class="post-divider"></div>

            <div class="post-content">
                <%
                    // Preserve line breaks from the textarea
                    String content = post.getContent();
                    String formatted = content
                        .replace("&", "&amp;")
                        .replace("<", "&lt;")
                        .replace(">", "&gt;")
                        .replace("\r\n", "<br>")
                        .replace("\n", "<br>");
                    out.print(formatted);
                %>
            </div>

        </article>

    </main>

    <script src="js/post.js"></script>
</body>
</html>
