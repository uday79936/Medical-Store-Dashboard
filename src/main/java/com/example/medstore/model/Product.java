package com.example.medstore.service;

import com.example.medstore.model.Product;
import java.util.ArrayList;
import java.util.List;

public class ProductService {

    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        products.add(new Product("P001", "Paracetamol", 50, 2.50));
        products.add(new Product("P002", "Vitamin C", 200, 1.80));
        products.add(new Product("P003", "Ibuprofen", 100, 3.20));

        return products;
    }
}
