package com.example.medstore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBConnection {

    // Database Configuration
    private static final String URL =
            "jdbc:mysql://localhost:3306/medical_store?useSSL=false&serverTimezone=UTC";

    private static final String USER = "root";
    private static final String PASSWORD = "password";

    // Static block to load JDBC Driver only once
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL JDBC Driver Loaded Successfully.");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Unable to load MySQL JDBC Driver.", e);
        }
    }

    // Private constructor to prevent object creation
    private DBConnection() {
        throw new UnsupportedOperationException(
                "Utility class cannot be instantiated."
        );
    }

    // Get database connection
    public static Connection getConnection() {

        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            throw new RuntimeException(
                    "Failed to establish database connection.",
                    e
            );
        }
    }

    // Close Connection
    public static void closeConnection(Connection connection) {

        if (connection != null) {

            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing connection:");
                e.printStackTrace();
            }
        }
    }
}
