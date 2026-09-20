package com.travelstay.web;

import com.travelstay.model.User;
import com.travelstay.service.BookingService;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cancelBooking")
public class CancelBookingServlet extends HttpServlet {

    private final BookingService bookingService = new BookingService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = (User) req.getSession().getAttribute("user");
        String type = req.getParameter("type");
        int id = Integer.parseInt(req.getParameter("id"));
        try {
            boolean ok = "hotel".equals(type)
                    ? bookingService.cancelHotelBooking(id, user.userId())
                    : bookingService.cancelRestaurantBooking(id, user.userId());
            req.getSession().setAttribute("message", ok ? "Cancelled." : "Could not cancel (not found or not yours).");
        } catch (SQLException e) {
            req.getSession().setAttribute("message", "Database error: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/bookings");
    }
}
