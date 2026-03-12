<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — BlogSpace</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/register.css">
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
            Every great story starts with a single word.
        </div>
        <div class="left-footer">
            Join thousands of writers sharing their stories.
        </div>
    </div>

    <!-- Right Panel -->
    <div class="right-panel">
        <h2 class="form-title">Create Account</h2>
        <p class="form-subtitle">Start writing your story today</p>

        <%-- Show error message if exists --%>
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="error-box">⚠ <%= error %></div>
        <% } %>

        <form action="register" method="post">
            <div class="field">
                <label for="username">Username</label>
                <input type="text" id="username" name="username"
                       placeholder="e.g. kishansoni" required>
            </div>

            <div class="field">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email"
                       placeholder="you@example.com" required>
            </div>

            <div class="field">
                <label for="password">Password</label>
                <input type="password" id="password" name="password"
                       placeholder="Min. 6 characters" required>
            </div>

            <button type="submit" class="btn-register">Create Account →</button>
        </form>

        <p class="divider">
            Already have an account? <a href="login">Sign in</a>
        </p>
    </div>

</div>

<script src="js/register.js"></script>
</body>
</html>