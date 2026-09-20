package com.travelstay.dao;

import com.travelstay.config.Database;
import com.travelstay.model.HotelBooking;
import com.travelstay.model.HotelReceipt;
import com.travelstay.model.RestaurantBooking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    /** Full booking + payment details for the receipt page. Returns null if not found or not owned by userId. */
    public HotelReceipt findHotelReceipt(int bookingId, int userId) throws SQLException {
        String sql = "SELECT b.booking_id, u.full_name, u.email, h.hotel_name, h.address, r.room_type, " +
                     "b.check_in, b.check_out, b.guests, b.total_amount, b.status, " +
                     "p.payment_id, p.payment_method, p.payment_status, p.paid_at " +
                     "FROM hotel_bookings b " +
                     "JOIN rooms r ON b.room_id = r.room_id " +
                     "JOIN hotels h ON r.hotel_id = h.hotel_id " +
                     "JOIN users u ON b.user_id = u.user_id " +
                     "LEFT JOIN payments p ON p.booking_type = 'HOTEL' AND p.reference_id = b.booking_id " +
                     "WHERE b.booking_id = ? AND b.user_id = ?";
        try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                int paymentIdRaw = rs.getInt(12);
                Integer paymentId = rs.wasNull() ? null : paymentIdRaw;
                return new HotelReceipt(
                        rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getDate(7).toLocalDate(), rs.getDate(8).toLocalDate(),
                        rs.getInt(9), rs.getDouble(10), rs.getString(11),
                        paymentId, rs.getString(13), rs.getString(14), rs.getTimestamp(15));
            }
        }
    }

    public List<HotelBooking> findHotelBookingsByUser(int userId) throws SQLException {
        String sql = "SELECT b.booking_id, h.hotel_name, r.room_type, b.check_in, b.check_out, " +
                     "b.guests, b.total_amount, b.status " +
                     "FROM hotel_bookings b " +
                     "JOIN rooms r ON b.room_id = r.room_id " +
                     "JOIN hotels h ON r.hotel_id = h.hotel_id " +
                     "WHERE b.user_id = ? ORDER BY b.booked_at DESC";
        List<HotelBooking> result = new ArrayList<>();
        try (Connection c = Database.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    result.add(new HotelBooking(
                            rs.getInt(1), rs.getString(2), rs.getString(3),
                            rs.getDate(4).toLocalDate(), rs.getDate(5).toLocalDate(),
                            rs.getInt(6), rs.getDouble(7), rs.getString(8)));
                }
            }
        }
        return result;
    }

    public List<RestaurantBooking> findRestaurantBookingsByUser(int userId) throws SQLException {
        String sql = "SELECT rb.reservation_id, res.restaurant_name, rt.table_number, " +
                     "rb.reservation_date, rb.reservation_time, rb.guests, rb.status " +
                     "FROM restaurant_bookings rb " +
                     "JOIN restaurant_tables rt ON rb.table_id = rt.table_id " +
                     "JOIN restaurants res ON rt.restaurant_id = res.restaurant_id " +
                     "WHERE rb.user_id = ? ORDER BY rb.booked_at DESC";
        List<RestaurantBooking> result = new ArrayList<>();
        try (Connection c = Database.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    result.add(new RestaurantBooking(
                            rs.getInt(1), rs.getString(2), rs.getString(3),
                            rs.getDate(4).toLocalDate(), rs.getTime(5).toLocalTime(),
                            rs.getInt(6), rs.getString(7)));
                }
            }
        }
        return result;
    }
}
