package com.travelstay.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/**
 * Shows the order summary + payment method screen for a room the guest wants to book.
 * No booking or payment row is created yet — that happens in CompletePaymentServlet,
 * after the guest picks a payment method and confirms.
 */
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int roomId = Integer.parseInt(req.getParameter("roomId"));
            int hotelId = Integer.parseInt(req.getParameter("hotelId"));
            String hotelName = req.getParameter("hotelName");
            String roomType = req.getParameter("roomType");
            double pricePerNight = Double.parseDouble(req.getParameter("pricePerNight"));
            LocalDate checkIn = LocalDate.parse(req.getParameter("checkIn"));
            LocalDate checkOut = LocalDate.parse(req.getParameter("checkOut"));
            int guests = Integer.parseInt(req.getParameter("guests"));

            if (!checkOut.isAfter(checkIn)) {
                req.getSession().setAttribute("message", "Check-out must be after check-in.");
                resp.sendRedirect(req.getContextPath() + "/rooms?hotelId=" + hotelId + "&hotelName=" + hotelName);
                return;
            }

            long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
            double baseAmount = nights * pricePerNight;
            double tax = Math.round(baseAmount * 0.12 * 100.0) / 100.0;
            double grandTotal = Math.round((baseAmount + tax) * 100.0) / 100.0;

            req.setAttribute("roomId", roomId);
            req.setAttribute("hotelId", hotelId);
            req.setAttribute("hotelName", hotelName);
            req.setAttribute("roomType", roomType);
            req.setAttribute("pricePerNight", pricePerNight);
            req.setAttribute("checkIn", checkIn);
            req.setAttribute("checkOut", checkOut);
            req.setAttribute("guests", guests);
            req.setAttribute("nights", nights);
            req.setAttribute("baseAmount", baseAmount);
            req.setAttribute("tax", tax);
            req.setAttribute("grandTotal", grandTotal);
            req.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(req, resp);
        } catch (RuntimeException e) {
            req.getSession().setAttribute("message", "Could not proceed to checkout: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}
