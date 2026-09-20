package com.travelstay.web;

import com.travelstay.dao.BookingDAO;
import com.travelstay.model.HotelBooking;
import com.travelstay.model.RestaurantBooking;
import com.travelstay.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/bookings")
public class BookingsServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        try {
            List<HotelBooking> hotelBookings = bookingDAO.findHotelBookingsByUser(user.userId());
            List<RestaurantBooking> restBookings = bookingDAO.findRestaurantBookingsByUser(user.userId());
            req.setAttribute("hotelBookings", hotelBookings);
            req.setAttribute("restBookings", restBookings);
            req.getRequestDispatcher("/WEB-INF/views/bookings.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
        }
    }
}
