package com.example.medstore.service;

import java.util.*;
import com.example.medstore.dao.ProductDAO;
import com.example.medstore.model.Product;

public class ProductService {

    ProductDAO dao=new ProductDAO();

    public List<Product> getProducts(){

        return dao.getAllProducts();
    }

    public int calculateTotalStock(List<Product> list){

        int total=0;

        for(Product p:list){
            total+=p.getStock();
        }

        return total;
    }

    public double calculateTotalValue(List<Product> list){

        double total=0;

        for(Product p:list){
            total+=p.getStock()*p.getPrice();
        }

        return total;
    }
}
