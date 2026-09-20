<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Receipt #${receipt.bookingId()} - TravelStay</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
    <div class="brand">TravelStay</div>
    <div>
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/bookings">My Bookings</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</header>
<div class="container narrow">
    <div class="receipt">
        <div class="receipt-head">
            <div>
                <div class="brand">TravelStay</div>
                <p style="margin:2px 0 0; color:var(--muted); font-size:13px;">Booking Receipt</p>
            </div>
            <span class="receipt-status">✔ ${receipt.status()}</span>
        </div>

        <p style="text-align:center; color:var(--success); font-weight:800; font-size:18px; margin: 4px 0 20px;">
            🎉 Payment successful — your booking is confirmed!
        </p>

        <div class="receipt-grid">
            <div><div class="label">Booking ID</div><div class="value">#${receipt.bookingId()}</div></div>
            <div><div class="label">Payment ID</div><div class="value">${empty receipt.paymentId() ? '—' : receipt.paymentId()}</div></div>
            <div><div class="label">Guest name</div><div class="value">${receipt.guestName()}</div></div>
            <div><div class="label">Email</div><div class="value">${receipt.guestEmail()}</div></div>
            <div><div class="label">Hotel</div><div class="value">${receipt.hotelName()}</div></div>
            <div><div class="label">Room type</div><div class="value">${receipt.roomType()}</div></div>
            <div><div class="label">Check-in</div><div class="value">${receipt.checkIn()}</div></div>
            <div><div class="label">Check-out</div><div class="value">${receipt.checkOut()}</div></div>
            <div><div class="label">Guests</div><div class="value">${receipt.guests()}</div></div>
            <div><div class="label">Payment method</div><div class="value">${empty receipt.paymentMethod() ? '—' : receipt.paymentMethod()}</div></div>
        </div>
        <p style="color:var(--muted); font-size:13px;">📍 ${receipt.hotelAddress()}</p>

        <table class="receipt-table">
            <tr><td>Room charges (${receipt.nights()} night(s))</td><td>₹<fmt:formatNumber value="${receipt.baseAmount()}" pattern="#,##0.00"/></td></tr>
            <tr><td>Taxes &amp; fees (12%)</td><td>₹<fmt:formatNumber value="${receipt.taxAmount()}" pattern="#,##0.00"/></td></tr>
            <tr class="total"><td>Amount paid</td><td>₹<fmt:formatNumber value="${receipt.totalAmount()}" pattern="#,##0.00"/></td></tr>
        </table>

        <p style="color:var(--muted); font-size:12px; margin-top:18px;">
            Paid on ${receipt.paidAt()} via ${empty receipt.paymentMethod() ? 'N/A' : receipt.paymentMethod()}.
            This is a system-generated receipt for the TravelStay demo project.
        </p>

        <div class="receipt-actions no-print">
            <button class="btn" onclick="window.print()">🖨️ Print / Save as PDF</button>
            <a class="btn outline" href="${pageContext.request.contextPath}/bookings">View all bookings</a>
            <a class="btn outline" href="${pageContext.request.contextPath}/home">Book another stay</a>
        </div>
    </div>
</div>
</body>
</html>
