package com.example.medstore.model;

import java.util.Objects;

public class Product {

    private String code;
    private String name;
    private int stock;
    private double price;

    // Default Constructor
    public Product() {
    }

    // Parameterized Constructor
    public Product(String code, String name, int stock, double price) {
        this.code = code;
        this.name = name;
        this.stock = stock;
        this.price = price;
    }

    // Getters and Setters
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        if (stock >= 0) {
            this.stock = stock;
        } else {
            throw new IllegalArgumentException("Stock cannot be negative.");
        }
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        if (price >= 0) {
            this.price = price;
        } else {
            throw new IllegalArgumentException("Price cannot be negative.");
        }
    }

    // toString Method
    @Override
    public String toString() {
        return "Product{" +
                "code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", stock=" + stock +
                ", price=" + price +
                '}';
    }

    // equals Method
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Product)) return false;
        Product product = (Product) o;
        return Objects.equals(code, product.code);
    }

    // hashCode Method
    @Override
    public int hashCode() {
        return Objects.hash(code);
    }
}
