<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Medical Store Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f9fafb;
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .card {
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            padding: 16px;
            border-radius: 8px;
            margin-bottom: 16px;
            background: #fff;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px 12px;
            border-bottom: 1px solid #eee;
            text-align: left;
        }
        th {
            background-color: #f1f1f1;
        }
        .kpi {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            justify-content: space-between;
        }
        .kpi .card {
            flex: 1;
            text-align: center;
        }
        .kpi h3 {
            margin-bottom: 8px;
            color: #555;
        }
        .kpi p {
            font-size: 1.2em;
            font-weight: bold;
            color: #0077b6;
        }
    </style>
</head>
<body>
    <h1>Medical Store Dashboard</h1>

    <div class="kpi">
        <div class="card">
            <h3>Total Stock</h3>
            <p>${totalStock}</p>
        </div>
        <div class="card">
            <h3>Total Inventory Value</h3>
            <p>$${totalValue}</p>
        </div>
        <div class="card">
            <h3>Products</h3>
            <p><c:out value="${fn:length(products)}" /></p>
        </div>
    </div>

    <div class="card">
        <h2>Product List</h2>
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
</body>
</html>
