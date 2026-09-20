package com.travelstay.web;

import com.travelstay.dao.RoomDAO;
import com.travelstay.model.Room;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/rooms")
public class RoomsServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int hotelId = Integer.parseInt(req.getParameter("hotelId"));
        try {
            List<Room> rooms = roomDAO.findByHotel(hotelId);
            req.setAttribute("rooms", rooms);
            req.setAttribute("hotelId", hotelId);
            req.setAttribute("hotelName", req.getParameter("hotelName"));
            // Prefill from the original search, if the visitor came from a hotel search.
            req.setAttribute("checkIn", req.getParameter("checkIn"));
            req.setAttribute("checkOut", req.getParameter("checkOut"));
            req.setAttribute("guests", req.getParameter("guests"));
            req.getRequestDispatcher("/WEB-INF/views/rooms.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
        }
    }
}
