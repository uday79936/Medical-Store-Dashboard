<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>Medical Store Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<style>
body { font-family: Arial, sans-serif; margin: 20px; }
.card { box-shadow: 0 2px 6px rgba(0,0,0,0.1); padding: 12px; border-radius: 8px; margin-bottom: 12px; }
table { width: 100%; border-collapse: collapse; }
th, td { padding: 8px 10px; border-bottom: 1px solid #eee; text-align: left; }
.kpi { display:flex; gap:12px; }
.kpi .card { flex:1; }
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
<p><c:out value="${fn:length(products)}"/></p>
</div>
</div>


<div class="card">
<h2>Product List</h2>
<table>
<thead>
<tr><th>Code</th><th>Name</th><th>Stock</th><th>Price</th></tr>
</thead>
<tbody>
<c:forEach var="p" items="${products}">
<tr>
<td><c:out value="${p.code}"/></td>
<td><c:out value="${p.name}"/></td>
<td><c:out value="${p.stock}"/></td>
<td>$<c:out value="${p.price}"/></td>
</tr>
</c:forEach>
</tbody>
</table>
</div>


</body>
</html>