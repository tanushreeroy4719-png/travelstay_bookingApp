<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bookings - TravelStay</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
    <div class="brand">TravelStay</div>
    <div>
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</header>
<div class="container">
    <h2>My Bookings</h2>
    <c:if test="${not empty sessionScope.message}">
        <p class="message">${sessionScope.message}</p>
        <c:remove var="message" scope="session"/>
    </c:if>

    <h3>Hotel bookings</h3>
    <c:if test="${empty hotelBookings}">
        <div class="panel"><p>No hotel bookings yet.</p></div>
    </c:if>
    <c:forEach var="b" items="${hotelBookings}">
        <div class="card">
            <p><strong>#${b.bookingId()} ${b.hotelName()}</strong> &mdash; ${b.roomType()}</p>
            <p>${b.checkIn()} to ${b.checkOut()} &nbsp;|&nbsp; ${b.guests()} guests &nbsp;|&nbsp; ₹<fmt:formatNumber value="${b.totalAmount()}" pattern="#,##0"/></p>
            <p class="status-${b.status()}">${b.status()}</p>
            <div style="display:flex; gap:8px;">
                <c:if test="${b.status() == 'CONFIRMED'}">
                    <a class="btn small outline" href="${pageContext.request.contextPath}/receipt?bookingId=${b.bookingId()}">View receipt</a>
                    <form method="post" action="${pageContext.request.contextPath}/cancelBooking">
                        <input type="hidden" name="type" value="hotel">
                        <input type="hidden" name="id" value="${b.bookingId()}">
                        <button type="submit" class="btn small danger">Cancel</button>
                    </form>
                </c:if>
            </div>
        </div>
    </c:forEach>

    <h3>Restaurant reservations</h3>
    <c:if test="${empty restBookings}">
        <div class="panel"><p>No restaurant reservations yet.</p></div>
    </c:if>
    <c:forEach var="b" items="${restBookings}">
        <div class="card">
            <p><strong>#${b.reservationId()} ${b.restaurantName()}</strong> &mdash; Table ${b.tableNumber()}</p>
            <p>${b.date()} at ${b.time()} &nbsp;|&nbsp; ${b.guests()} guests</p>
            <p class="status-${b.status()}">${b.status()}</p>
            <c:if test="${b.status() == 'CONFIRMED'}">
                <form method="post" action="${pageContext.request.contextPath}/cancelBooking">
                    <input type="hidden" name="type" value="restaurant">
                    <input type="hidden" name="id" value="${b.reservationId()}">
                    <button type="submit" class="btn small danger">Cancel</button>
                </form>
            </c:if>
        </div>
    </c:forEach>

    <p><a href="${pageContext.request.contextPath}/home">&larr; Back</a></p>
</div>
</body>
</html>
