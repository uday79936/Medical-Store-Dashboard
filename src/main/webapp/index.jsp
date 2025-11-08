<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Medical Store Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Include Chart.js for analytics -->
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

        h1 {
            margin: 0;
            font-size: 2em;
            letter-spacing: 1px;
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
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.2);
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
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            padding: 20px;
            margin: 30px 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
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
            background-color: #e0f7fa;
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

<div class="container">

    <!-- KPI Section -->
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
            <h3>Products</h3>
            <p><c:out value="${fn:length(products)}" /></p>
        </div>
        <div class="card" style="background: linear-gradient(135deg, #d4fc79, #96e6a1);">
            <h3>Low Stock Alerts</h3>
            <p>
                <c:set var="lowStockCount" value="0"/>
                <c:forEach var="p" items="${products}">
                    <c:if test="${p.stock lt 10}">
                        <c:set var="lowStockCount" value="${lowStockCount + 1}"/>
                    </c:if>
                </c:forEach>
                ${lowStockCount}
            </p>
        </div>
    </div>

    <!-- Chart Section -->
    <div class="chart-container">
        <h2 style="text-align:center;">Stock Overview</h2>
        <canvas id="stockChart"></canvas>
    </div>

    <!-- Product Table -->
    <div>
        <h2 style="margin-top:20px;">Product List</h2>
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
                        <td><c:out value="${p.code}" /></td>
                        <td><c:out value="${p.name}" /></td>
                        <td><c:out value="${p.stock}" /></td>
                        <td>$<c:out value="${p.price}" /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<footer>
    © 2025 Medical Store Dashboard | Powered by JSP & JSTL
</footer>

<!-- Dynamic Chart -->
<script>
    const ctx = document.getElementById('stockChart').getContext('2d');
    const productNames = [
        <c:forEach var="p" items="${products}">
            "${p.name}",
        </c:forEach>
    ];
    const productStock = [
        <c:forEach var="p" items="${products}">
            ${p.stock},
        </c:forEach>
    ];

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: productNames,
            datasets: [{
                label: 'Stock Quantity',
                data: productStock,
                backgroundColor: [
                    '#0077b6', '#00b4d8', '#48cae4', '#90e0ef', '#caf0f8'
                ],
                borderRadius: 8
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false },
                title: {
                    display: true,
                    text: 'Product Stock Levels'
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: { stepSize: 5 }
                }
            }
        }
    });
</script>

</body>
</html>
