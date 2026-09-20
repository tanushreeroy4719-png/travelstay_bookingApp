<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Rooms - TravelStay</title>
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
<div class="container">
    <h2>${hotelName}</h2>
    <c:if test="${not empty sessionScope.message}">
        <p class="message">${sessionScope.message}</p>
        <c:remove var="message" scope="session"/>
    </c:if>
    <c:if test="${empty rooms}">
        <div class="panel"><p>No rooms found for this hotel.</p></div>
    </c:if>
    <c:forEach var="r" items="${rooms}">
        <div class="card room-card">
            <div class="room-info">
                <h3>${r.roomType()}</h3>
                <p style="color:var(--muted); margin:2px 0 10px;">Sleeps ${r.capacity()} &nbsp;|&nbsp; ${r.totalRooms()} rooms available</p>
                <div class="room-price">₹<fmt:formatNumber value="${r.pricePerNight()}" pattern="#,##0"/> <span style="font-size:13px; font-weight:400; color:var(--muted);">/ night</span></div>
            </div>
            <form class="room-form" method="post" action="${pageContext.request.contextPath}/checkout">
                <input type="hidden" name="roomId" value="${r.roomId()}">
                <input type="hidden" name="hotelId" value="${hotelId}">
                <input type="hidden" name="hotelName" value="${hotelName}">
                <input type="hidden" name="roomType" value="${r.roomType()}">
                <input type="hidden" name="pricePerNight" value="${r.pricePerNight()}">
                <label>Check-in</label>
                <input type="date" name="checkIn" value="${checkIn}" required>
                <label>Check-out</label>
                <input type="date" name="checkOut" value="${checkOut}" required>
                <label>Guests</label>
                <input type="number" name="guests" min="1" value="${empty guests ? 1 : guests}" required>
                <button type="submit" class="btn full" style="margin-top:12px;">Reserve this room &rarr;</button>
            </form>
        </div>
    </c:forEach>
    <p><a href="${pageContext.request.contextPath}/home">&larr; Back to search</a></p>
</div>
</body>
</html>
