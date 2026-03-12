<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — BlogSpace</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
</head>
<body>

<div class="page-wrapper">

    <!-- Left Panel -->
    <div class="left-panel">
        <div>
            <div class="brand">Blog<span>Space</span></div>
            <div class="tagline">Your voice, your story</div>
        </div>
        <div class="left-quote">
            Words have power. Share yours with the world.
        </div>
        <div class="left-footer">
            Welcome back to your creative space.
        </div>
    </div>

    <!-- Right Panel -->
    <div class="right-panel">
        <h2 class="form-title">Welcome Back</h2>
        <p class="form-subtitle">Sign in to continue writing</p>

        <%-- Show error message if exists --%>
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="error-box">⚠ <%= error %></div>
        <% } %>

        <%-- Show success message if redirected from register --%>
        <% String success = request.getParameter("success"); %>
        <% if ("registered".equals(success)) { %>
            <div class="success-box">✓ Account created! Please sign in.</div>
        <% } %>

        <form action="login" method="post">
            <div class="field">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email"
                       placeholder="you@example.com" required>
            </div>

            <div class="field">
                <label for="password">Password</label>
                <input type="password" id="password" name="password"
                       placeholder="Your password" required>
            </div>

            <button type="submit" class="btn-login">Sign In →</button>
        </form>

        <p class="divider">
            Don't have an account? <a href="register">Create one</a>
        </p>
    </div>

</div>

<script src="js/login.js"></script>
</body>
</html>