<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TravelStay — Find your next stay</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
    <div class="brand">TravelStay</div>
    <div>
        Hi, ${sessionScope.user.fullName}
        <a href="${pageContext.request.contextPath}/bookings">My Bookings</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</header>

<div class="hero">
    <h1>Find your next stay</h1>
    <p>Search hotels and restaurants across India — best prices, verified reviews.</p>
</div>

<div class="search-wrap">
    <c:if test="${not empty error}">
        <p class="error" style="background:white;padding:10px;border-radius:6px;">${error}</p>
    </c:if>

    <div class="search-tabs">
        <button type="button" class="active" onclick="showTab('hotel')" id="tab-hotel">🏨 Hotels</button>
        <button type="button" onclick="showTab('restaurant')" id="tab-restaurant">🍽️ Restaurants</button>
    </div>

    <div class="search-box">
        <!-- Hotel search -->
        <form class="search-panel active" id="panel-hotel" method="get" action="${pageContext.request.contextPath}/hotels" autocomplete="off">
            <div class="field destination" style="position:relative;">
                <label>Enter destination</label>
                <input type="text" name="city" id="cityInput" placeholder="Where are you going?" required
                       onfocus="document.getElementById('trending').classList.add('show')"
                       onblur="setTimeout(function(){document.getElementById('trending').classList.remove('show')},150)">
                <div class="trending" id="trending">
                    <div class="trending-title">Trending destinations</div>
                    <c:forEach var="d" items="${cities}">
                        <div class="trending-item" onmousedown="pickCity('${d}')">
                            <span class="pin">📍</span>
                            <span><span class="city">${d}</span><br><span class="state">India</span></span>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="field">
                <label>Check-in</label>
                <input type="date" name="checkIn">
            </div>
            <div class="field">
                <label>Check-out</label>
                <input type="date" name="checkOut">
            </div>
            <div class="field">
                <label>Guests</label>
                <input type="number" name="guests" min="1" value="2">
            </div>
            <button type="submit" class="search-btn">Search</button>
        </form>

        <!-- Restaurant search -->
        <form class="search-panel" id="panel-restaurant" method="get" action="${pageContext.request.contextPath}/restaurants" autocomplete="off">
            <div class="field destination">
                <label>Enter city</label>
                <input type="text" name="city" placeholder="e.g. Mumbai" required>
            </div>
            <div class="field">
                <label>Date</label>
                <input type="date" name="date">
            </div>
            <div class="field">
                <label>Guests</label>
                <input type="number" name="guests" min="1" value="2">
            </div>
            <button type="submit" class="search-btn">Search</button>
        </form>
    </div>
</div>

<div class="container" style="margin-top:10px;">
    <div class="panel" style="display:flex; gap:20px; flex-wrap:wrap; text-align:center;">
        <div style="flex:1; min-width:200px;">
            <div style="font-size:28px;">🌍</div>
            <h3 style="margin:6px 0 4px;">2+ million properties worldwide</h3>
            <p style="color:var(--muted); margin:0; font-size:14px;">Hotels, guest houses, apartments, and more...</p>
        </div>
        <div style="flex:1; min-width:200px;">
            <div style="font-size:28px;">💳</div>
            <h3 style="margin:6px 0 4px;">Pay your way</h3>
            <p style="color:var(--muted); margin:0; font-size:14px;">UPI, cards, or net banking — your choice at checkout.</p>
        </div>
        <div style="flex:1; min-width:200px;">
            <div style="font-size:28px;">🛎️</div>
            <h3 style="margin:6px 0 4px;">Trusted 24/7 customer service</h3>
            <p style="color:var(--muted); margin:0; font-size:14px;">We're always here to help.</p>
        </div>
    </div>
</div>

<script>
function showTab(which) {
    document.getElementById('tab-hotel').classList.toggle('active', which==='hotel');
    document.getElementById('tab-restaurant').classList.toggle('active', which==='restaurant');
    document.getElementById('panel-hotel').classList.toggle('active', which==='hotel');
    document.getElementById('panel-restaurant').classList.toggle('active', which==='restaurant');
}
function pickCity(name) {
    document.getElementById('cityInput').value = name;
}
</script>
</body>
</html>
