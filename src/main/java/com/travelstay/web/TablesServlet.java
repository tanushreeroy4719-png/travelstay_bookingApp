package com.travelstay.web;

import com.travelstay.dao.TableDAO;
import com.travelstay.model.RestaurantTable;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/tables")
public class TablesServlet extends HttpServlet {

    private final TableDAO tableDAO = new TableDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
        try {
            List<RestaurantTable> tables = tableDAO.findByRestaurant(restaurantId);
            req.setAttribute("tables", tables);
            req.setAttribute("restaurantId", restaurantId);
            req.setAttribute("restaurantName", req.getParameter("restaurantName"));
            req.getRequestDispatcher("/WEB-INF/views/tables.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
        }
    }
}
