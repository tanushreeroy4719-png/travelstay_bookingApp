package com.travelstay.dao;

import com.travelstay.config.Database;
import java.sql.*;

public class PaymentDAO {

    /** Records a (mock) successful payment against a hotel or restaurant booking and returns its ID. */
    public int insertPayment(int userId, String bookingType, int referenceId, double amount, String method)
            throws SQLException {
        String sql = "INSERT INTO payments(user_id, booking_type, reference_id, amount, payment_method, payment_status) " +
                     "VALUES (?,?,?,?,?,'SUCCESS')";
        try (Connection c = Database.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setString(2, bookingType);
            ps.setInt(3, referenceId);
            ps.setDouble(4, amount);
            ps.setString(5, method);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                rs.next();
                return rs.getInt(1);
            }
        }
    }
}
