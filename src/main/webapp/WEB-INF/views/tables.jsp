<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tables - TravelStay</title>
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
    <h2>Tables at ${restaurantName}</h2>
    <c:if test="${not empty sessionScope.message}">
        <p class="message">${sessionScope.message}</p>
        <c:remove var="message" scope="session"/>
    </c:if>
    <c:if test="${empty tables}">
        <div class="panel"><p>No tables found for this restaurant.</p></div>
    </c:if>
    <c:forEach var="t" items="${tables}">
        <div class="card room-card">
            <div class="room-info">
                <h3>Table ${t.tableNumber()}</h3>
                <p style="color:var(--muted);">Seats up to ${t.seats()} guests</p>
            </div>
            <form class="room-form" method="post" action="${pageContext.request.contextPath}/reserveTable">
                <input type="hidden" name="tableId" value="${t.tableId()}">
                <input type="hidden" name="restaurantId" value="${restaurantId}">
                <label>Date</label>
                <input type="date" name="date" required>
                <label>Time</label>
                <input type="time" name="time" required>
                <label>Guests</label>
                <input type="number" name="guests" min="1" value="1" required>
                <button type="submit" class="btn full" style="margin-top:12px;">Reserve this table</button>
            </form>
        </div>
    </c:forEach>
    <p><a href="${pageContext.request.contextPath}/home">&larr; Back to search</a></p>
</div>
</body>
</html>
