package com.example.medstore.servlet;

import com.example.medstore.model.Product;
import com.example.medstore.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    private final Logger logger = Logger.getLogger(DashboardServlet.class.getName());
    private ProductService productService;

    @Override
    public void init() {
        // Service layer instance (later replaced by DB)
        productService = new ProductService();
        logger.info("DashboardServlet initialized successfully.");
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp) throws ServletException, IOException {

        try {
            req.setCharacterEncoding("UTF-8");

            List<Product> products = productService.getAllProducts();

            if (products == null) {
                products = java.util.Collections.emptyList();
            }

            int totalStock = products.stream().mapToInt(Product::getStock).sum();
            double totalValue = products.stream()
                    .mapToDouble(p -> p.getStock() * p.getPrice())
                    .sum();

            req.setAttribute("products", products);
            req.setAttribute("totalStock", totalStock);
            req.setAttribute("totalValue", totalValue);

            req.getRequestDispatcher("/index.jsp").forward(req, resp);

        } catch (Exception e) {
            logger.severe("Dashboard error: " + e.getMessage());
            throw new ServletException("Unable to load dashboard.", e);
        }
    }
}
