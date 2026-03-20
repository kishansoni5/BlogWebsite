package com.blog.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.blog.model.Post;
import com.blog.util.DBConnection;

public class PostDAO {
    public boolean savePost(Post post) throws SQLException {
        String sql = "INSERT INTO posts (user_id, title, content, status) VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, post.getUserId());
            ps.setString(2, post.getTitle());
            ps.setString(3, post.getContent());
            ps.setString(4, post.getStatus());

            return ps.executeUpdate() > 0;
        }
    }

    public List<Post> getAllPublishedPosts() throws SQLException {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT posts.*, users.username FROM posts JOIN users ON posts.user_id = users.id WHERE posts.status = 'published' ORDER BY posts.created_at DESC";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setUserId(rs.getInt("user_id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setStatus(rs.getString("status"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                post.setAuthorName(rs.getString("username"));
                posts.add(post);
            }
        }
        return posts;
    }

    public Post getPostById(int id) throws SQLException {
        String sql = "SELECT posts.*,users.username FROM posts JOIN users ON posts.user_id=users.id WHERE posts.id = ?";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Post post = new Post();
                    post.setId(rs.getInt("id"));
                    post.setUserId(rs.getInt("user_id"));
                    post.setTitle(rs.getString("title"));
                    post.setContent(rs.getString("content"));
                    post.setStatus(rs.getString("status"));
                    post.setCreatedAt(rs.getTimestamp("created_at"));
                    post.setAuthorName(rs.getString("username"));
                    return post;
                }
            }
        }
        return null;
    }

    public List<Post> getPostsByUser(int userid) throws SQLException {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT * FROM posts WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userid);

            try (ResultSet rs = ps.executeQuery();) {
                while (rs.next()) {
                    Post post = new Post();
                    post.setId(rs.getInt("id"));
                    post.setUserId(rs.getInt("user_id"));
                    post.setTitle(rs.getString("title"));
                    post.setContent(rs.getString("content"));
                    post.setStatus(rs.getString("status"));
                    post.setCreatedAt(rs.getTimestamp("created_at"));
                    posts.add(post);
                }
            }

        }
        return posts;
    }

    public boolean deletePost(int id) throws SQLException {
        String sql = "DELETE FROM posts WHERE id=?";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updatePost(Post post) throws SQLException {
        String sql = "UPDATE posts SET title = ?, content = ? WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, post.getTitle());
            ps.setString(2, post.getContent());
            ps.setInt(3, post.getId());
            return ps.executeUpdate() > 0;
        }
    }
}