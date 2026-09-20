<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout - TravelStay</title>
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
    <h2>Confirm &amp; Pay</h2>
    <div class="checkout-grid">

        <div class="summary panel">
            <h3 style="margin-top:0;">Order summary</h3>
            <p style="font-weight:700; margin-bottom:0;">${hotelName}</p>
            <p style="color:var(--muted); margin-top:2px;">${roomType}</p>
            <div class="summary-line"><span>Check-in</span><span>${checkIn}</span></div>
            <div class="summary-line"><span>Check-out</span><span>${checkOut}</span></div>
            <div class="summary-line"><span>Guests</span><span>${guests}</span></div>
            <div class="summary-line"><span>${nights} night(s) × ₹<fmt:formatNumber value="${pricePerNight}" pattern="#,##0"/></span><span>₹<fmt:formatNumber value="${baseAmount}" pattern="#,##0"/></span></div>
            <div class="summary-line"><span>Taxes &amp; fees (12%)</span><span>₹<fmt:formatNumber value="${tax}" pattern="#,##0"/></span></div>
            <div class="summary-line total"><span>Total</span><span>₹<fmt:formatNumber value="${grandTotal}" pattern="#,##0"/></span></div>
        </div>

        <div class="payment panel">
            <h3 style="margin-top:0;">Choose payment method</h3>
            <div class="method-tabs">
                <div class="method-tab active" id="tab-upi" onclick="selectMethod('upi')">📱 UPI</div>
                <div class="method-tab" id="tab-card" onclick="selectMethod('card')">💳 Credit / Debit Card</div>
                <div class="method-tab" id="tab-netbanking" onclick="selectMethod('netbanking')">🏦 Net Banking</div>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/completePayment" id="payForm">
                <input type="hidden" name="roomId" value="${roomId}">
                <input type="hidden" name="hotelId" value="${hotelId}">
                <input type="hidden" name="hotelName" value="${hotelName}">
                <input type="hidden" name="checkIn" value="${checkIn}">
                <input type="hidden" name="checkOut" value="${checkOut}">
                <input type="hidden" name="guests" value="${guests}">
                <input type="hidden" name="grandTotal" value="${grandTotal}">
                <input type="hidden" name="paymentMethod" id="paymentMethod" value="UPI">

                <div class="method-panel active" id="panel-upi">
                    <label>UPI ID</label>
                    <input type="text" placeholder="yourname@upi" pattern="[a-zA-Z0-9.\-_]{2,}@[a-zA-Z]{2,}" title="e.g. yourname@okhdfcbank">
                    <p style="font-size:12px; color:var(--muted);">You'll get a payment request on your UPI app. This is a demo — no real payment is processed.</p>
                </div>

                <div class="method-panel" id="panel-card">
                    <label>Card number</label>
                    <input type="text" inputmode="numeric" maxlength="19" placeholder="1234 5678 9012 3456">
                    <div class="card-row">
                        <div>
                            <label>Expiry</label>
                            <input type="text" placeholder="MM/YY" maxlength="5">
                        </div>
                        <div>
                            <label>CVV</label>
                            <input type="text" inputmode="numeric" maxlength="3" placeholder="***">
                        </div>
                    </div>
                    <label>Name on card</label>
                    <input type="text" placeholder="As printed on card">
                </div>

                <div class="method-panel" id="panel-netbanking">
                    <label>Select your bank</label>
                    <select>
                        <option>State Bank of India</option>
                        <option>HDFC Bank</option>
                        <option>ICICI Bank</option>
                        <option>Axis Bank</option>
                        <option>Punjab National Bank</option>
                        <option>Kotak Mahindra Bank</option>
                    </select>
                    <p style="font-size:12px; color:var(--muted);">You'll be redirected to your bank's login page. This is a demo — no real payment is processed.</p>
                </div>

                <p class="secure-note">🔒 This is a demo checkout for the TravelStay project — no real card, UPI, or bank details are transmitted or stored.</p>
                <button type="submit" class="btn gold full" style="margin-top:10px; font-size:16px; padding:14px;">
                    Pay ₹<fmt:formatNumber value="${grandTotal}" pattern="#,##0"/> &amp; Confirm Booking
                </button>
            </form>
        </div>
    </div>
</div>

<script>
function selectMethod(method) {
    ['upi','card','netbanking'].forEach(function(m) {
        document.getElementById('tab-' + m).classList.toggle('active', m === method);
        document.getElementById('panel-' + m).classList.toggle('active', m === method);
    });
    document.getElementById('paymentMethod').value =
        method === 'upi' ? 'UPI' : (method === 'card' ? 'Card' : 'Net Banking');
}
</script>
</body>
</html>
