package com.travelstay.web;

import com.travelstay.dao.RestaurantDAO;
import com.travelstay.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/restaurants")
public class RestaurantSearchServlet extends HttpServlet {

    private final RestaurantDAO restaurantDAO = new RestaurantDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String city = req.getParameter("city");
        if (city == null) city = "";
        try {
            List<Restaurant> restaurants = restaurantDAO.findByCity(city);
            req.setAttribute("restaurants", restaurants);
            req.setAttribute("city", city);
            req.getRequestDispatcher("/WEB-INF/views/restaurants.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
        }
    }
}
