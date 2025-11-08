package com.example.medstore.model;


public class Product {
private String code;
private String name;
private int stock;
private double price;


public Product(String code, String name, int stock, double price) {
this.code = code;
this.name = name;
this.stock = stock;
this.price = price;
}


public String getCode() { return code; }
public String getName() { return name; }
public int getStock() { return stock; }
public double getPrice() { return price; }


public void setStock(int stock) { this.stock = stock; }
}