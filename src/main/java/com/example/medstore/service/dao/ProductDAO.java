package com.example.medstore.dao;

import com.example.medstore.model.Product;
import com.example.medstore.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // Fetch all products
    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        String query = "SELECT * FROM products";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Product product = new Product(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getInt("quantity"),
                        rs.getDouble("price")
                );

                products.add(product);
            }

        } catch (SQLException e) {
            System.err.println("Error fetching products:");
            e.printStackTrace();
        }

        return products;
    }

    // Fetch product by ID
    public Product getProductById(String id) {

        String query = "SELECT * FROM products WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, id);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return new Product(
                            rs.getString("id"),
                            rs.getString("name"),
                            rs.getInt("quantity"),
                            rs.getDouble("price")
                    );
                }
            }

        } catch (SQLException e) {
            System.err.println("Error fetching product by ID:");
            e.printStackTrace();
        }

        return null;
    }

    // Add new product
    public boolean addProduct(Product product) {

        String query = "INSERT INTO products(id, name, quantity, price) VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, product.getCode());
            ps.setString(2, product.getName());
            ps.setInt(3, product.getStock());
            ps.setDouble(4, product.getPrice());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error adding product:");
            e.printStackTrace();
        }

        return false;
    }

    // Update product
    public boolean updateProduct(Product product) {

        String query = "UPDATE products SET name=?, quantity=?, price=? WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, product.getName());
            ps.setInt(2, product.getStock());
            ps.setDouble(3, product.getPrice());
            ps.setString(4, product.getCode());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error updating product:");
            e.printStackTrace();
        }

        return false;
    }

    // Delete product
    public boolean deleteProduct(String id) {

        String query = "DELETE FROM products WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, id);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting product:");
            e.printStackTrace();
        }

        return false;
    }
}
