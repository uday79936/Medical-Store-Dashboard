<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Medical Store Dashboard</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:"Segoe UI",Arial,sans-serif;
}

body{
background:#f4f7fb;
color:#333;
}

header{
background:#0d6efd;
color:white;
padding:20px;
text-align:center;
box-shadow:0 3px 8px rgba(0,0,0,.2);
}

nav{
background:#0b5ed7;
padding:15px;
text-align:center;
}

nav a{
color:white;
text-decoration:none;
margin:0 18px;
font-weight:bold;
transition:.3s;
}

nav a:hover{
color:#ffd43b;
}

.container{
max-width:1200px;
margin:auto;
padding:30px;
}

.cards{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
gap:20px;
margin-bottom:30px;
}

.card{
background:white;
padding:25px;
border-radius:12px;
box-shadow:0 5px 12px rgba(0,0,0,.1);
text-align:center;
transition:.3s;
}

.card:hover{
transform:translateY(-6px);
}

.card h3{
margin-bottom:10px;
color:#666;
}

.card h2{
color:#0d6efd;
}

.chart-box{
background:white;
padding:20px;
border-radius:12px;
box-shadow:0 5px 12px rgba(0,0,0,.1);
margin-bottom:35px;
height:420px;
}

table{
width:100%;
border-collapse:collapse;
background:white;
border-radius:10px;
overflow:hidden;
box-shadow:0 5px 12px rgba(0,0,0,.1);
}

table th{
background:#0d6efd;
color:white;
padding:14px;
}

table td{
padding:12px;
text-align:center;
border-bottom:1px solid #ddd;
}

table tr:nth-child(even){
background:#f8f9fa;
}

table tr:hover{
background:#eef5ff;
}

.low-stock{
background:#ffe5e5 !important;
color:#c1121f;
font-weight:bold;
}

.success{
background:#d4edda;
color:#155724;
padding:15px;
margin-bottom:20px;
border-radius:6px;
}

.error{
background:#f8d7da;
color:#721c24;
padding:15px;
margin-bottom:20px;
border-radius:6px;
}

.empty{
text-align:center;
padding:25px;
color:gray;
font-size:18px;
}

footer{
margin-top:40px;
background:#0d6efd;
color:white;
text-align:center;
padding:18px;
}

</style>

</head>

<body>

<header>

<h1>💊 Medical Store Dashboard</h1>

</header>

<nav>

<a href="dashboard">Dashboard</a>
<a href="addProduct.jsp">Add Product</a>
<a href="viewProducts.jsp">Inventory</a>
<a href="orders.jsp">Orders</a>
<a href="logout.jsp">Logout</a>

</nav>

<div class="container">

<c:if test="${not empty successMessage}">
<div class="success">
${successMessage}
</div>
</c:if>

<c:if test="${not empty errorMessage}">
<div class="error">
${errorMessage}
</div>
</c:if>

<c:set var="lowStock" value="0"/>

<c:forEach items="${products}" var="p">

<c:if test="${p.stock < 10}">
<c:set var="lowStock" value="${lowStock+1}"/>
</c:if>

</c:forEach>

<div class="cards">

<div class="card">
<h3>Total Products</h3>
<h2>${fn:length(products)}</h2>
</div>

<div class="card">
<h3>Total Stock</h3>
<h2>${totalStock}</h2>
</div>

<div class="card">
<h3>Inventory Value</h3>
<h2>$${totalValue}</h2>
</div>

<div class="card">
<h3>Low Stock</h3>
<h2>${lowStock}</h2>
</div>

</div>

<div class="chart-box">

<h2 style="text-align:center;margin-bottom:20px;">
Stock Overview
</h2>

<c:choose>

<c:when test="${not empty products}">
<canvas id="stockChart"></canvas>
</c:when>

<c:otherwise>
<div class="empty">
No products available.
</div>
</c:otherwise>

</c:choose>

</div>

<h2 style="margin-bottom:15px;">
Product Inventory
</h2>

<c:choose>

<c:when test="${not empty products}">

<table>

<thead>

<tr>
<th>Product Code</th>
<th>Product Name</th>
<th>Stock</th>
<th>Price ($)</th>
</tr>

</thead>

<tbody>

<c:forEach items="${products}" var="p">

<tr class="${p.stock < 10 ? 'low-stock' : ''}">

<td>${p.code}</td>

<td>${p.name}</td>

<td>${p.stock}</td>

<td>${p.price}</td>

</tr>

</c:forEach>

</tbody>

</table>

</c:when>

<c:otherwise>

<div class="empty">

No products found.

</div>

</c:otherwise>

</c:choose>

</div>

<footer>

© 2026 Medical Store Management System

</footer>

<c:if test="${not empty products}">

<script>

const labels=[
<c:forEach items="${products}" var="p" varStatus="s">
"${p.name}"<c:if test="${!s.last}">,</c:if>
</c:forEach>
];

const stock=[
<c:forEach items="${products}" var="p" varStatus="s">
${p.stock}<c:if test="${!s.last}">,</c:if>
</c:forEach>
];

new Chart(document.getElementById("stockChart"),{

type:"bar",

data:{

labels:labels,

datasets:[{

label:"Available Stock",

data:stock,

backgroundColor:[
"#0d6efd",
"#198754",
"#ffc107",
"#dc3545",
"#6610f2",
"#20c997",
"#fd7e14",
"#6f42c1"
],

borderRadius:8

}]

},

options:{

responsive:true,

maintainAspectRatio:false,

plugins:{

legend:{
display:true
}

},

scales:{

y:{
beginAtZero:true
}

}

}

});

</script>

</c:if>

</body>
</html>
