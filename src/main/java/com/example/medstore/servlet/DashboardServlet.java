package com.example.medstore.servlet;

import com.example.medstore.model.Product;
import com.example.medstore.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    private final Logger logger = Logger.getLogger(DashboardServlet.class.getName());
    private ProductService productService;

    @Override
    public void init() {
        productService = new ProductService();
        logger.info("DashboardServlet initialized successfully.");
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp) throws ServletException, IOException {

        try {

            List<Product> products = productService.getProducts();

            int totalStock = productService.calculateTotalStock(products);
            double totalValue = productService.calculateTotalValue(products);

            req.setAttribute("products", products);
            req.setAttribute("totalStock", totalStock);
            req.setAttribute("totalValue", totalValue);

            req.getRequestDispatcher("/index.jsp").forward(req, resp);

        } catch (Exception e) {

            logger.severe("Dashboard error: " + e.getMessage());
            throw new ServletException("Unable to load dashboard", e);
        }
    }
}
