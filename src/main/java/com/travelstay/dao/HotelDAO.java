package com.travelstay.dao;

import com.travelstay.config.Database;
import com.travelstay.model.Hotel;
import com.travelstay.model.HotelCard;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HotelDAO {
    public List<Hotel> findByCity(String city) throws SQLException {
        String sql = "SELECT h.hotel_id,h.hotel_name,l.city,h.address,h.rating,h.description " +
                     "FROM hotels h JOIN locations l ON h.location_id=l.location_id " +
                     "WHERE l.city LIKE ? ORDER BY h.rating DESC";
        List<Hotel> result = new ArrayList<>();
        try (Connection c=Database.getConnection(); PreparedStatement ps=c.prepareStatement(sql)) {
            ps.setString(1, "%" + city + "%");
            try(ResultSet rs=ps.executeQuery()) {
                while(rs.next()) result.add(new Hotel(rs.getInt(1),rs.getString(2),rs.getString(3),
                        rs.getString(4),rs.getDouble(5),rs.getString(6)));
            }
        }
        return result;
    }

    /** Same search, but joined against rooms to also return each hotel's cheapest nightly rate. */
    public List<HotelCard> findByCityWithPricing(String city) throws SQLException {
        String sql = "SELECT h.hotel_id, h.hotel_name, l.city, h.address, h.rating, h.description, " +
                     "MIN(r.price_per_night) AS min_price " +
                     "FROM hotels h " +
                     "JOIN locations l ON h.location_id = l.location_id " +
                     "JOIN rooms r ON r.hotel_id = h.hotel_id " +
                     "WHERE l.city LIKE ? " +
                     "GROUP BY h.hotel_id, h.hotel_name, l.city, h.address, h.rating, h.description " +
                     "ORDER BY h.rating DESC";
        List<HotelCard> result = new ArrayList<>();
        try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, "%" + city + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    double rating = rs.getDouble(5);
                    result.add(new HotelCard(rs.getInt(1), rs.getString(2), rs.getString(3),
                            rs.getString(4), rating, (int) Math.round(rating),
                            rs.getString(6), rs.getDouble(7)));
                }
            }
        }
        return result;
    }
}
