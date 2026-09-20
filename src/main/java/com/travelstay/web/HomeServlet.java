package com.travelstay.web;

import com.travelstay.dao.LocationDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private final LocationDAO locationDAO = new LocationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("cities", locationDAO.findCitiesWithHotels());
        } catch (SQLException e) {
            req.setAttribute("cities", Collections.emptyList());
        }
        req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
    }
}
