package com.travelstay.dao;

import com.travelstay.config.Database;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LocationDAO {
    /** Cities that have at least one hotel, for the "trending destinations" list on the homepage. */
    public List<String> findCitiesWithHotels() throws SQLException {
        String sql = "SELECT DISTINCT l.city FROM locations l JOIN hotels h ON h.location_id = l.location_id ORDER BY l.city";
        List<String> result = new ArrayList<>();
        try (Connection c = Database.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) result.add(rs.getString(1));
        }
        return result;
    }
}
