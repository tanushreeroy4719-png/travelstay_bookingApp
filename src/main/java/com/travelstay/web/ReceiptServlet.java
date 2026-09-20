package com.travelstay.web;

import com.travelstay.dao.BookingDAO;
import com.travelstay.model.HotelReceipt;
import com.travelstay.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/receipt")
public class ReceiptServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        try {
            int bookingId = Integer.parseInt(req.getParameter("bookingId"));
            HotelReceipt receipt = bookingDAO.findHotelReceipt(bookingId, user.userId());
            if (receipt == null) {
                req.getSession().setAttribute("message", "Receipt not found.");
                resp.sendRedirect(req.getContextPath() + "/bookings");
                return;
            }
            req.setAttribute("receipt", receipt);
            req.getRequestDispatcher("/WEB-INF/views/receipt.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
        }
    }
}
