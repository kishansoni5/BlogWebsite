package com.blog.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.io.InputStream;
import java.util.Properties;

public class DBConnection {
    private static String URL;
    private static String USERNAME;
    private static String PASSWORD;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            InputStream input = DBConnection.class
                    .getClassLoader()
                    .getResourceAsStream("db.properties");
            if (input == null) {
                throw new RuntimeException("db.properties not found on classpath");
            }
            Properties prop = new Properties();
            prop.load(input);
            URL = prop.getProperty("db.url");
            USERNAME = prop.getProperty("db.username");
            PASSWORD = prop.getProperty("db.password");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws java.sql.SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}