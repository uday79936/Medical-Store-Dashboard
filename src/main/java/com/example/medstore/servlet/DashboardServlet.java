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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final Logger LOGGER =
            Logger.getLogger(DashboardServlet.class.getName());

    private static final String DASHBOARD_PAGE = "/index.jsp";

    private ProductService productService;

    @Override
    public void init() throws ServletException {

        super.init();

        try {
            productService = new ProductService();
            LOGGER.info("DashboardServlet initialized successfully.");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to initialize ProductService.", e);
            throw new ServletException("Initialization failed.", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // Fetch products
            List<Product> products = productService.getProducts();

            // Calculate dashboard statistics
            int totalStock = productService.calculateTotalStock(products);
            double totalValue = productService.calculateTotalValue(products);

            // Set request attributes
            request.setAttribute("products", products);
            request.setAttribute("totalStock", totalStock);
            request.setAttribute("totalValue", totalValue);

            // Forward to JSP
            request.getRequestDispatcher(DASHBOARD_PAGE)
                   .forward(request, response);

        } catch (Exception e) {

            LOGGER.log(Level.SEVERE,
                    "Error while loading dashboard.", e);

            request.setAttribute(
                    "errorMessage",
                    "Unable to load dashboard. Please try again later."
            );

            request.getRequestDispatcher(DASHBOARD_PAGE)
                   .forward(request, response);
        }
    }

    @Override
    public void destroy() {

        LOGGER.info("DashboardServlet destroyed.");

        super.destroy();
    }
}
