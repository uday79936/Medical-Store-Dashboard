<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Medical Store Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #e3f2fd, #fce4ec);
            margin: 0;
            padding: 0;
        }

        header {
            background: linear-gradient(90deg, #0077b6, #00b4d8);
            color: white;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        }

        nav {
            background: #023e8a;
            padding: 12px;
            text-align: center;
        }

        nav a {
            color: white;
            margin: 0 18px;
            text-decoration: none;
            font-weight: bold;
            font-size: 15px;
        }

        nav a:hover {
            text-decoration: underline;
        }

        h1 {
            margin: 0;
            font-size: 2em;
        }

        .container {
            padding: 30px;
            max-width: 1200px;
            margin: auto;
        }

        .kpi {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: space-between;
        }

        .card {
            flex: 1;
            min-width: 250px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            text-align: center;
            padding: 20px;
            transition: .3s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card h3 {
            margin-bottom: 10px;
            color: #444;
        }

        .card p {
            font-size: 1.8em;
            font-weight: bold;
            color: #0077b6;
        }

        .chart-container {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin: 30px 0;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            margin-top: 12px;
        }

        th, td {
            padding: 12px 16px;
            text-align: left;
        }

        th {
            background-color: #00b4d8;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background: #e0f7fa;
        }

        footer {
            text-align: center;
            padding: 15px;
            background: #0077b6;
            color: white;
            margin-top: 40px;
        }
    </style>
</head>

<body>

<header>
    <h1>💊 Medical Store Dashboard</h1>
</header>

<nav>
    <a href="addProduct.jsp">Add Product</a>
    <a href="viewProducts.jsp">Manage Inventory</a>
    <a href="orders.jsp">Orders</a>
    <a href="logout.jsp">Logout</a>
</nav>

<div class="container">

    <!-- KPI Cards -->
    <div class="kpi">
        <div class="card" style="background: linear-gradient(135deg, #a8edea, #fed6e3);">
            <h3>Total Stock</h3>
            <p>${totalStock}</p>
        </div>

        <div class="card" style="background: linear-gradient(135deg, #f6d365, #fda085);">
            <h3>Total Inventory Value</h3>
            <p>$${totalValue}</p>
        </div>

        <div class="card" style="background: linear-gradient(135deg, #a1c4fd, #c2e9fb);">
            <h3>Total Products</h3>
            <p>${fn:length(products)}</p>
        </div>

        <div class="card" style="background: linear-gradient(135deg, #d4fc79, #96e6a1);">
            <h3>Low Stock Alerts</h3>
            <p>
                <c:set var="low" value="0"/>
                <c:forEach var="p" items="${products}">
                    <c:if test="${p.stock < 10}">
                        <c:set var="low" value="${low + 1}"/>
                    </c:if>
                </c:forEach>
                ${low}
            </p>
        </div>
    </div>

    <!-- Chart -->
    <div class="chart-container">
        <h2 style="text-align:center;">Stock Overview</h2>

        <c:if test="${not empty products}">
            <canvas id="stockChart"></canvas>
        </c:if>

        <c:if test="${empty products}">
            <p style="color:gray;text-align:center;">No products to display</p>
        </c:if>
    </div>

    <!-- Table -->

    <h2>Product List</h2>

    <c:if test="${not empty products}">
        <table>
            <thead>
            <tr>
                <th>Code</th>
                <th>Name</th>
                <th>Stock</th>
                <th>Price</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach var="p" items="${products}">
                <tr>
                    <td>${p.code}</td>
                    <td>${p.name}</td>
                    <td>${p.stock}</td>
                    <td>$${p.price}</td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </c:if>

    <c:if test="${empty products}">
        <p style="color:gray;margin-top:10px;">No products found.</p>
    </c:if>

</div>

<footer>
    © 2025 Medical Store Dashboard
</footer>

<!-- Chart Script -->
<script>
    <c:if test="${not empty products}">
    const names = [
        <c:forEach var="p" items="${products}" varStatus="st">
            "${p.name}"<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    const stock = [
        <c:forEach var="p" items="${products}" varStatus="st">
            ${p.stock}<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    new Chart(document.getElementById("stockChart"), {
        type: 'bar',
        data: {
            labels: names,
            datasets: [{
                label: 'Stock',
                data: stock,
                backgroundColor: '#00b4d8',
                borderRadius: 6
            }]
        },
        options: { responsive: true }
    });
    </c:if>
</script>

</body>
</html>
