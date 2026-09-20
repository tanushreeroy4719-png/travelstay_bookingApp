package com.travelstay.web;

import com.travelstay.dao.HotelDAO;
import com.travelstay.model.HotelCard;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/hotels")
public class HotelSearchServlet extends HttpServlet {

    private final HotelDAO hotelDAO = new HotelDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String city = req.getParameter("city");
        if (city == null) city = "";
        try {
            List<HotelCard> hotels = hotelDAO.findByCityWithPricing(city);
            req.setAttribute("hotels", hotels);
            req.setAttribute("city", city);
            // Carry the search context through so it can be prefilled on later steps.
            req.setAttribute("checkIn", req.getParameter("checkIn"));
            req.setAttribute("checkOut", req.getParameter("checkOut"));
            req.setAttribute("guests", req.getParameter("guests"));
            req.getRequestDispatcher("/WEB-INF/views/hotels.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
        }
    }
}
