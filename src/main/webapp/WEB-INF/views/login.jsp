<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - TravelStay</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body style="background: linear-gradient(135deg, var(--navy) 0%, var(--blue) 100%); min-height:100vh;">
<div class="container narrow" style="padding-top:60px;">
    <div class="panel">
        <h1 style="text-align:center;">🧳 TravelStay</h1>
        <h2 style="text-align:center; margin-top:0;">Login</h2>
        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
        <form method="post" action="${pageContext.request.contextPath}/login">
            <label>Email</label>
            <input type="email" name="email" required>
            <label>Password</label>
            <input type="password" name="password" required>
            <button type="submit" class="btn full" style="margin-top:16px;">Login</button>
        </form>
        <p style="text-align:center; margin-top:16px;">Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a></p>
    </div>
</div>
</body>
</html>
