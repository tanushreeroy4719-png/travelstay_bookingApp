<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hotels in ${city} - TravelStay</title>
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
    <div class="page-title">
        <h2>Hotels in ${city}</h2>
        <span class="result-count">${hotels.size()} propert${hotels.size() == 1 ? 'y' : 'ies'} found</span>
    </div>

    <c:if test="${empty hotels}">
        <div class="panel">
            <p>No hotels found for "${city}". Try Ahmedabad, Mumbai, Delhi, Bengaluru, Jaipur, Goa, Hyderabad, Chennai, Kolkata, or Pune.</p>
            <a class="btn" href="${pageContext.request.contextPath}/home">&larr; Back to search</a>
        </div>
    </c:if>

    <c:forEach var="h" items="${hotels}">
        <c:url var="roomsUrl" value="/rooms">
            <c:param name="hotelId" value="${h.hotelId()}"/>
            <c:param name="hotelName" value="${h.name()}"/>
            <c:param name="checkIn" value="${checkIn}"/>
            <c:param name="checkOut" value="${checkOut}"/>
            <c:param name="guests" value="${guests}"/>
        </c:url>
        <div class="hotel-card">
            <div class="photo">
                <img src="https://picsum.photos/seed/travelstay-hotel-${h.hotelId()}/440/320" alt="${h.name()}">
            </div>
            <div class="info">
                <h3><a href="${roomsUrl}">${h.name()}</a></h3>
                <div class="stars">
                    <c:forEach begin="1" end="${h.starCount()}">★</c:forEach>
                    <c:forEach begin="${h.starCount()+1}" end="5">☆</c:forEach>
                </div>
                <p class="address">📍 ${h.address()}, ${h.city()}</p>
                <p class="desc">${h.description()}</p>
            </div>
            <div class="side">
                <div>
                    <span class="score-badge">${h.rating()}</span>
                    <div class="score-label">${h.ratingLabel()}</div>
                    <div class="score-sub">based on guest ratings</div>
                </div>
                <div class="price-block">
                    <div class="price-from">Starting from</div>
                    <div class="price-amount">₹<fmt:formatNumber value="${h.minPrice()}" pattern="#,##0"/></div>
                    <div class="price-note">per night, taxes extra</div>
                    <a class="btn gold" style="margin-top:8px; display:inline-block;" href="${roomsUrl}">
                       See availability &rarr;
                    </a>
                </div>
            </div>
        </div>
    </c:forEach>

    <c:if test="${not empty hotels}">
        <p><a href="${pageContext.request.contextPath}/home">&larr; New search</a></p>
    </c:if>
</div>
</body>
</html>
