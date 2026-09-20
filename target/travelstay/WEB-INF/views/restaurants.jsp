<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Restaurants - TravelStay</title>
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
    <div class="page-title"><h2>Restaurants in ${city}</h2></div>
    <c:if test="${empty restaurants}">
        <div class="panel"><p>No restaurants found.</p></div>
    </c:if>
    <c:forEach var="r" items="${restaurants}">
        <div class="hotel-card">
            <div class="photo">
                <img src="https://picsum.photos/seed/travelstay-resto-${r.restaurantId()}/440/320" alt="${r.name()}">
            </div>
            <div class="info">
                <h3>${r.name()}</h3>
                <p class="address">🍴 ${r.cuisine()} cuisine &nbsp;|&nbsp; 📍 ${r.address()}</p>
            </div>
            <div class="side">
                <span class="score-badge">${r.rating()}</span>
                <c:url var="tablesUrl" value="/tables">
                    <c:param name="restaurantId" value="${r.restaurantId()}"/>
                    <c:param name="restaurantName" value="${r.name()}"/>
                </c:url>
                <a class="btn gold" style="margin-top:10px;" href="${tablesUrl}">View tables &rarr;</a>
            </div>
        </div>
    </c:forEach>
    <p><a href="${pageContext.request.contextPath}/home">&larr; Back</a></p>
</div>
</body>
</html>
