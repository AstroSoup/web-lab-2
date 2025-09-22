<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Лабораторная работа</title>
    <style>

        .r-container {
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 12px;
            margin: 8px 0;
        }

        #r-options {
            display: flex;
            flex-direction: row;
            gap: 15px;
        }

        #r-options label {
            font-size: 14px;
            cursor: pointer;
        }

        footer {
            margin-top: 30px;
            padding: 20px;
            background: #ecf6fc;
            border-top: 2px solid #3498db;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #contacts {
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 20px;
        }

        #links a img {
            margin: 5px;
            transition: transform 0.2s;
        }

        #links a img:hover {
            transform: scale(1.1);
        }

        #tsukasa {
            height: 80px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }


        body {
            font-family: "Segoe UI", Arial, sans-serif;
            margin: 30px;
            background: #f5f7fa;
            color: #333;
        }

        header {
            margin-bottom: 25px;
            padding: 15px;
            background: #3498db;
            color: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        form {
            margin-bottom: 20px;
            padding: 15px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        label {
            display: block;
            margin: 10px 0;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: "Trebuchet MS", sans-serif;
            background: #ffffff;
            color: #000;
            text-align: center;
        }

        header {
            padding: 15px;
            background: linear-gradient(to right, red, yellow, green, blue);
            color: white;
            font-size: 18px;
            font-weight: bold;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h2, header p {
            margin: 0;
            padding: 0 10px;
        }

        form {
            margin: 20px auto;
            padding: 15px;
            display: inline-block;
            text-align: left;
            background: rgba(255,255,255,0.4);
            border-radius: 10px;
        }

        label {
            display: block;
            margin: 8px 0;
            font-size: 14px;
        }

        input[type="text"] {
            padding: 4px;
            border: 1px solid #777;
            border-radius: 4px;
            width: 120px;
        }

        button {
            margin-top: 10px;
            padding: 6px 12px;
            background: #00aabb;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.3s;
        }
        button:hover {
            background: #008899;
        }

        canvas {
            margin: 20px auto;
            display: block;
            border: 2px solid black;
            border-radius: 8px;
            background: #ffffff;
        }

        table {
            border-collapse: collapse;
            width: 90%;
            margin: 20px auto;
            font-size: 14px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        th {
            background: #00aabb;
            color: white;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background: rgba(255,255,255,0.6);
        }

        footer {
            margin-top: 30px;
            padding: 20px;
            background: linear-gradient(to right, red, orange, yellow, green, blue, indigo, violet);
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
        }

        #contacts {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
        }

        #links a img {
            margin: 5px;
            transition: transform 0.2s;
        }
        #links a img:hover {
            transform: scale(1.15);
        }

        #tsukasa {
            height: 270px;
            border-radius: 8px;
        }

    </style>
    <script>
        function validateForm() {
            const x = document.forms["coordsForm"]["x"].value;
            const y = document.forms["coordsForm"]["y"].value;
            const r = document.forms["coordsForm"]["r"].value;

            if (![-3,-2,-1,0,1,2,3,4,5].includes(parseInt(x))) {
                alert("X должен быть целым числом от -3 до 5");
                return false;
            }
            if (y === "" || isNaN(y) || y <= -5 || y >= 3) {
                alert("Y должен быть числом от -5 до 3");
                return false;
            }
            if (![1,2,3,4,5].includes(parseInt(r))) {
                alert("R должен быть целым числом от 1 до 5");
                return false;
            }
            return true;
        }

        function handleCanvasClick(event) {
            const r = document.forms["coordsForm"]["r"].value;
            if (!r) {
                alert("Сначала выберите радиус R");
                return;
            }
            const canvas = document.getElementById("graph");
            const rect = canvas.getBoundingClientRect();
            const x = event.clientX - rect.left;
            const y = event.clientY - rect.top;

            const centerX = canvas.width / 2;
            const centerY = canvas.height / 2;
            const scale = 40;

            const realX = (x - centerX) / scale <= -3 ? -3 : Math.round((x - centerX) / scale);
            const realY = -((y - centerY) / scale).toFixed(2);
            const form = document.forms["coordsForm"];
            form["x"].value = realX;
            form["y"].value = realY;
            if (validateForm()) {
                form.submit();
            }
        }

        function drawGraph() {
            const canvas = document.getElementById("graph");
            const ctx = canvas.getContext("2d");
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            const centerX = canvas.width / 2;
            const centerY = canvas.height / 2;
            const scale = 40;

            ctx.beginPath();
            ctx.moveTo(0, centerY);
            ctx.lineTo(canvas.width, centerY);
            ctx.moveTo(centerX, 0);
            ctx.lineTo(centerX, canvas.height);
            ctx.strokeStyle = "#2c3e50";
            ctx.lineWidth = 1.5;
            ctx.stroke();

            ctx.fillStyle = "#2c3e50";
            ctx.font = "12px Arial";

            for (let i = -5; i <= 5; i++) {
                if (i === 0) continue;

                const xPos = centerX + i * scale;
                ctx.beginPath();
                ctx.moveTo(xPos, centerY - 5);
                ctx.lineTo(xPos, centerY + 5);
                ctx.stroke();
                ctx.fillText(i.toString(), xPos - 5, centerY + 15);

                const yPos = centerY - i * scale;
                ctx.beginPath();
                ctx.moveTo(centerX - 5, yPos);
                ctx.lineTo(centerX + 5, yPos);
                ctx.stroke();
                ctx.fillText(i.toString(), centerX + 8, yPos + 4);
            }

            ctx.fillStyle = "rgba(52,152,219,0.4)";
            const r = document.forms["coordsForm"]["r"].value;
            if (r) {
                const R = r * scale;

                ctx.beginPath();
                ctx.moveTo(centerX, centerY);
                ctx.arc(centerX, centerY, R, Math.PI, 3 * Math.PI/2, false);
                ctx.closePath();
                ctx.fill();

                ctx.fillRect(centerX - R/2, centerY, R/2, R);

                ctx.beginPath();
                ctx.moveTo(centerX, centerY);
                ctx.lineTo(centerX + R/2, centerY);
                ctx.lineTo(centerX, centerY - R);
                ctx.closePath();
                ctx.fill();
            }
        }
    </script>
</head>
<body onload="drawGraph()">
<header>
    <h2 id="header-left">Лабораторная работа №2</h2>
    <h2 id="header-center">Веб-программирование</h2>
    <h2 id="header-right">Горин Семён Дмитриевич P3208</h2>
</header>

<form name="coordsForm" method="get" action="lab" onsubmit="return validateForm()">
    <label>X:
        <select name="x">
            <option value="-3">-3</option>
            <option value="-2">-2</option>
            <option value="-1">-1</option>
            <option value="0">0</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
        </select>
    </label>
    <label>Y:
        <input type="text" name="y" placeholder="от -5 до 3">
    </label>
    <div class="r-container">
        <span class="r-label">R:</span>
        <div id="r-options" onchange="drawGraph()">
            <label><input type="radio" name="r" value="1"> 1</label>
            <label><input type="radio" name="r" value="2"> 2</label>
            <label><input type="radio" name="r" value="3"> 3</label>
            <label><input type="radio" name="r" value="4"> 4</label>
            <label><input type="radio" name="r" value="5"> 5</label>
        </div>
    </div>

    <button type="submit">Проверить</button>
</form>

<canvas id="graph" width="400" height="400" onclick="handleCanvasClick(event)"></canvas>

<h3>История проверок</h3>
<%
    java.util.List<ru.astrosoup.DTOs.AreaCheckResponse> history =
            (java.util.List<ru.astrosoup.DTOs.AreaCheckResponse>) session.getAttribute("history");
    if (history != null && !history.isEmpty()) {
%>
<table>
    <tr>
        <th>X</th><th>Y</th><th>R</th><th>Попадание</th><th>Дата</th>
    </tr>
    <% for (ru.astrosoup.DTOs.AreaCheckResponse res : history) { %>
    <tr>
        <td><%= res.getX() %></td>
        <td><%= res.getY() %></td>
        <td><%= res.getR() %></td>
        <td><%= res.isHit() ? "Есть пробитие" : "Броня не пробита" %></td>
        <td><%= res.getDate()%></td>
    </tr>
    <% } %>
</table>
<% } else { %>
<p>Пока нет результатов.</p>
<% } %>

<footer>
    <div id="contacts">
        <div id="links">
            <a href="https://t.me/astro_soup">
                <img src="https://img.shields.io/badge/Telegram-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white">
            </a>
            <a href="https://vk.com/astro_soup">
                <img src="https://img.shields.io/badge/вконтакте-%232E87FB.svg?&style=for-the-badge&logo=vk&logoColor=white">
            </a>
            <a href="https://discord.com/users/697719405748158465">
                <img src="https://img.shields.io/badge/Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white">
            </a>
            <a href="mailto:astro_soup@niuitmo.ru">
                <img src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white">
            </a>
        </div>
        <img src="resources/tsukasa-phone.gif" id="tsukasa">
    </div>
</footer>

</body>
</html>
