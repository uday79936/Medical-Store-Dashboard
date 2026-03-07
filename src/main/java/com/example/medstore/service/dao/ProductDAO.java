package com.example.medstore.dao;

import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<String> getAllProducts() {

        List<String> products = new ArrayList<>();

        products.add("Paracetamol");
        products.add("Crocin");
        products.add("Aspirin");
        products.add("Vitamin C");

        return products;
    }

}