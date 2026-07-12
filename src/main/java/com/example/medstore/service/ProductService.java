package com.example.medstore.service;

import java.util.List;

import com.example.medstore.dao.ProductDAO;
import com.example.medstore.model.Product;

public class ProductService {

    private final ProductDAO productDAO;

    // Constructor
    public ProductService() {
        this.productDAO = new ProductDAO();
    }

    // Get all products
    public List<Product> getProducts() {
        return productDAO.getAllProducts();
    }

    // Get product by ID
    public Product getProductById(String id) {
        return productDAO.getProductById(id);
    }

    // Add product
    public boolean addProduct(Product product) {
        return productDAO.addProduct(product);
    }

    // Update product
    public boolean updateProduct(Product product) {
        return productDAO.updateProduct(product);
    }

    // Delete product
    public boolean deleteProduct(String id) {
        return productDAO.deleteProduct(id);
    }

    // Calculate total stock
    public int calculateTotalStock(List<Product> products) {

        int totalStock = 0;

        if (products != null) {
            for (Product product : products) {
                totalStock += product.getStock();
            }
        }

        return totalStock;
    }

    // Calculate total inventory value
    public double calculateTotalValue(List<Product> products) {

        double totalValue = 0.0;

        if (products != null) {
            for (Product product : products) {
                totalValue += product.getStock() * product.getPrice();
            }
        }

        return totalValue;
    }

    // Get total stock directly from database
    public int getTotalStock() {
        return calculateTotalStock(getProducts());
    }

    // Get total inventory value directly from database
    public double getTotalInventoryValue() {
        return calculateTotalValue(getProducts());
    }
}
