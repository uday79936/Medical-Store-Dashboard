package com.example.medstore.servlet;

import com.example.medstore.model.Product;
import com.example.medstore.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
            // UTF-8 support
            req.setCharacterEncoding("UTF-8");

            // Get all products
            List<Product> products = productService.getAllProducts();

            // Avoid NullPointerException
            if (products == null) {
                products = java.util.Collections.emptyList();
            }

            // KPI calculations
            int totalStock = products.stream().mapToInt(Product::getStock).sum();
            double totalValue = products.stream()
                    .mapToDouble(p -> p.getStock() * p.getPrice())
                    .sum();

            // Attributes set for JSP
            req.setAttribute("products", products);
            req.setAttribute("totalStock", totalStock);
            req.setAttribute("totalValue", totalValue);

            // Forward to JSP dashboard
            req.getRequestDispatcher("/index.jsp").forward(req, resp);

        } catch (Exception e) {
            logger.severe("Dashboard error: " + e.getMessage());
            throw new ServletException("Unable to load dashboard.", e);
        }
    }
}
