package com.example.medstore.servlet;


import com.example.medstore.model.Product;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {


@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
// In a real app, fetch from DB. Here we create sample data.
List<Product> products = new ArrayList<>();
products.add(new Product("P001", "Paracetamol 500mg", 120, 1.50));
products.add(new Product("P002", "Amoxicillin 250mg", 60, 3.75));
products.add(new Product("P003", "Cough Syrup 100ml", 40, 4.50));
products.add(new Product("P004", "Vitamin C 500mg", 200, 0.95));


// Basic KPI calculations
int totalStock = products.stream().mapToInt(Product::getStock).sum();
double totalValue = products.stream().mapToDouble(p -> p.getStock() * p.getPrice()).sum();


req.setAttribute("products", products);
req.setAttribute("totalStock", totalStock);
req.setAttribute("totalValue", totalValue);


req.getRequestDispatcher("/index.jsp").forward(req, resp);
}
}