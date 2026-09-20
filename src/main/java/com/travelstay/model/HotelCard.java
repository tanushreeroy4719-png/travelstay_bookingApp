package com.travelstay.model;

public record HotelCard(int hotelId, String name, String city, String address, double rating,
                         int starCount, String description, double minPrice) {

    /** Booking.com-style verdict text derived from the rating. */
    public String ratingLabel() {
        if (rating >= 4.5) return "Excellent";
        if (rating >= 4.0) return "Very Good";
        if (rating >= 3.5) return "Good";
        return "Fair";
    }
}
