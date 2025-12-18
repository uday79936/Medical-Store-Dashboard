package com.example.medstore.model;

public class Product {

    private String code;
    private String name;
    private int stock;
    private double price;

    public Product() {}

    public Product(String code, String name, int stock, double price) {
        this.code = code;
        this.name = name;
        this.stock = stock;
        this.price = price;
    }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}
