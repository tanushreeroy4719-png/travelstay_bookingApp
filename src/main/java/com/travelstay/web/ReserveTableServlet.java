package com.travelstay.web;

import com.travelstay.model.User;
import com.travelstay.service.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet("/reserveTable")
public class ReserveTableServlet extends HttpServlet {

    private final BookingService bookingService = new BookingService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        int tableId = Integer.parseInt(req.getParameter("tableId"));
        int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
        LocalDate date = LocalDate.parse(req.getParameter("date"));
        LocalTime time = LocalTime.parse(req.getParameter("time"));
        int guests = Integer.parseInt(req.getParameter("guests"));

        try {
            int reservationId = bookingService.reserveTable(
                    user.userId(), tableId, date, Time.valueOf(time.withSecond(0)), guests);
            req.getSession().setAttribute("message", "Reservation confirmed! ID #" + reservationId);
            resp.sendRedirect(req.getContextPath() + "/bookings");
        } catch (IllegalArgumentException | IllegalStateException e) {
            req.getSession().setAttribute("message", "Could not reserve: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/tables?restaurantId=" + restaurantId);
        } catch (SQLException e) {
            req.getSession().setAttribute("message", "Database error: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}
