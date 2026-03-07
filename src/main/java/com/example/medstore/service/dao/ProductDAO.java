package com.example.medstore.dao;

import java.util.ArrayList;
import java.util.List;
import com.example.medstore.model.Product;

public class ProductDAO {

    // Method to get all products
    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        products.add(new Product("Paracetamol", 100, 2.5));
        products.add(new Product("Crocin", 80, 3.0));
        products.add(new Product("Aspirin", 60, 1.8));
        products.add(new Product("Vitamin C", 120, 2.2));

        return products;
    }
}