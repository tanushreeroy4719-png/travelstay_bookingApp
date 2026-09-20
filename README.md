# TravelStay 🧳

A full-stack hotel & restaurant booking web app built with **Java Servlets + JSP**, styled after Booking.com — search hotels by city, compare star ratings and prices, book a room, pay with UPI / Card / Net Banking (demo checkout), and get an instant printable receipt.

![Java](https://img.shields.io/badge/Java-25-orange)
![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10-blue)
![Tomcat](https://img.shields.io/badge/Tomcat-11-yellow)
![MySQL](https://img.shields.io/badge/MySQL-8%2B-lightblue)
![Maven](https://img.shields.io/badge/Build-Maven-red)
![License](https://img.shields.io/badge/License-MIT-green)

---

## ✨ Features

- 🔐 **Auth** — register/login with PBKDF2-hashed passwords, session-based access control
- 🔎 **Hotel search** — Booking.com-style hero search bar with a live "trending destinations" dropdown
- 🏨 **Hotel listings** — star ratings, guest score badges, starting price per night, hotel photos
- 🛏️ **Room booking** — pick dates & guests, see nightly rate and room capacity
- 💳 **Checkout & payment** — order summary with tax breakdown, choose UPI / Credit-Debit Card / Net Banking (mock payment, no real gateway)
- 🧾 **Receipts** — auto-generated booking receipt with a Print/Save-as-PDF button
- 🍽️ **Restaurant reservations** — search restaurants by city, reserve a table
- 📋 **My Bookings** — view and cancel upcoming hotel/restaurant bookings
- 🔒 Transaction-safe booking (row-locking prevents double-booking the same room/table)

## 🛠️ Tech stack

| Layer | Technology |
|---|---|
| Language | Java 25 |
| Web | Jakarta Servlet 6.0, JSP, JSTL 3.0 |
| Server | Apache Tomcat 11 |
| Database | MySQL 8+ (JDBC, plain SQL — no ORM) |
| Build | Maven (WAR packaging) |
| Frontend | Hand-rolled CSS (no framework), vanilla JS |

## 📁 Project structure

```
src/main/java/com/travelstay/
  model/    → data records (Hotel, Room, HotelReceipt, ...)
  dao/      → JDBC queries
  service/  → booking transactions (double-booking protection)
  util/     → password hashing (PBKDF2WithHmacSHA256)
  config/   → DB connection settings
  web/      → Servlets (search, checkout, payment, receipts, auth)
src/main/webapp/
  WEB-INF/views/  → JSP pages
  css/style.css   → styling
database/travelstay.sql  → schema + seed data (10 Indian cities, hotels, rooms, restaurants)
```

## 🚀 Getting started

### Prerequisites
- JDK 25 (or update `maven.compiler.release` in `pom.xml` to match your JDK)
- Apache Tomcat 11
- MySQL 8+ (e.g. via XAMPP)
- NetBeans (or any IDE with Maven + Tomcat support)

### 1. Set up the database
```sql
-- run this file in phpMyAdmin / MySQL CLI
database/travelstay.sql
```
This creates the `travelstay` database, all tables, and seed data for 10 Indian cities.

### 2. Configure the connection (if needed)
`src/main/java/com/travelstay/config/Database.java` defaults to `root` / no password on `localhost:3306` — update it if your MySQL setup differs.

### 3. Build & run
- Open the project folder (the one containing `pom.xml`) in NetBeans as a Maven project
- Register Tomcat 11 under **Tools → Servers**
- Right-click the project → **Clean and Build**, then **Run**
- Browser opens at `http://localhost:8080/travelstay/login`

### 4. Try it out
Register a new account, or use the seeded demo account:

| Email | Password |
|---|---|
| `customer@travelstay.com` | `customer123` |

Search a city (Ahmedabad, Mumbai, Delhi, Bengaluru, Jaipur, Goa, Hyderabad, Chennai, Kolkata, Pune), pick a hotel and room, and walk through checkout to see the receipt.

## ⚠️ Notes

- Payments are **simulated** — no real card/UPI/bank details are sent anywhere or stored. This is a student/demo project, not a production payment integration.
- Hotel/restaurant photos are placeholder images loaded from picsum.photos at runtime.

## 📄 License

MIT — see [LICENSE](LICENSE). Free to use, modify, and distribute.
