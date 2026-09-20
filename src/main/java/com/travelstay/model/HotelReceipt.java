package com.travelstay.model;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public record HotelReceipt(int bookingId, String guestName, String guestEmail, String hotelName,
                            String hotelAddress, String roomType, LocalDate checkIn, LocalDate checkOut,
                            int guests, double totalAmount, String status, Integer paymentId,
                            String paymentMethod, String paymentStatus, Timestamp paidAt) {

    public long nights() {
        long n = ChronoUnit.DAYS.between(checkIn, checkOut);
        return n > 0 ? n : 1;
    }

    /** The amount before tax, backed out from the stored grand total (which already includes 12% GST). */
    public double baseAmount() {
        return Math.round((totalAmount / 1.12) * 100.0) / 100.0;
    }

    public double taxAmount() {
        return Math.round((totalAmount - baseAmount()) * 100.0) / 100.0;
    }
}
