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
            InputStream input = DBConnection.class
                    .getClassLoader()
                    .getResourceAsStream("db.properties");
            Properties prop = new Properties();
            prop.load(input);
            URL = prop.getProperty("db.url");
            USERNAME = prop.getProperty("db.username");
            PASSWORD = prop.getProperty("db.password");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        Connection con = null;
        try {
            con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}