package com.travelstay.web;

import com.travelstay.dao.PaymentDAO;
import com.travelstay.model.User;
import com.travelstay.service.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;

/**
 * Runs after the guest confirms payment on the checkout page. This is a MOCK payment step —
 * no real money moves and no external payment gateway is contacted. It simply records which
 * method the guest chose, then creates the booking and a payment row in the same flow.
 */
@WebServlet("/completePayment")
public class CompletePaymentServlet extends HttpServlet {

    private final BookingService bookingService = new BookingService();
    private final PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        int hotelId = Integer.parseInt(req.getParameter("hotelId"));
        String hotelName = req.getParameter("hotelName");

        try {
            int roomId = Integer.parseInt(req.getParameter("roomId"));
            LocalDate checkIn = LocalDate.parse(req.getParameter("checkIn"));
            LocalDate checkOut = LocalDate.parse(req.getParameter("checkOut"));
            int guests = Integer.parseInt(req.getParameter("guests"));
            double grandTotal = Double.parseDouble(req.getParameter("grandTotal"));
            String paymentMethod = req.getParameter("paymentMethod");
            if (paymentMethod == null || paymentMethod.isBlank()) {
                paymentMethod = "UPI";
            }

            int bookingId = bookingService.bookRoom(user.userId(), roomId, checkIn, checkOut, guests, grandTotal);
            paymentDAO.insertPayment(user.userId(), "HOTEL", bookingId, grandTotal, paymentMethod);

            resp.sendRedirect(req.getContextPath() + "/receipt?bookingId=" + bookingId);
        } catch (IllegalArgumentException | IllegalStateException e) {
            req.getSession().setAttribute("message", "Payment could not be completed: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/rooms?hotelId=" + hotelId + "&hotelName=" + hotelName);
        } catch (SQLException e) {
            req.getSession().setAttribute("message", "Database error: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}
