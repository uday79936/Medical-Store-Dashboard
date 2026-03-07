package com.example.medstore.service;

import java.util.List;
import com.example.medstore.dao.ProductDAO;
import com.example.medstore.model.Product;

public class ProductService {

    private ProductDAO dao = new ProductDAO();

    // Get all products
    public List<Product> getProducts() {
        return dao.getAllProducts();
    }

    // Calculate total stock
    public int calculateTotalStock(List<Product> products) {

        int total = 0;

        for (Product p : products) {
            total += p.getStock();
        }

        return total;
    }

    // Calculate total inventory value
    public double calculateTotalValue(List<Product> products) {

        double total = 0;

        for (Product p : products) {
            total += p.getStock() * p.getPrice();
        }

        return total;
    }
}