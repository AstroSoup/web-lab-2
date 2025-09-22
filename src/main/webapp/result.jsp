<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="ru.astrosoup.DTOs.AreaCheckResponse" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Результат проверки</title>
    <style>

        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
        }

        main {
            flex: 1;
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
        function drawGraph(x, y, r, hit) {
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

            if (x !== null && y !== null) {
                const px = centerX + x * scale;
                const py = centerY - y * scale;
                ctx.beginPath();
                ctx.arc(px, py, 4, 0, 2 * Math.PI);
                ctx.fillStyle = hit ? "green" : "red";
                ctx.fill();
            }
        }
    </script>

</head>
<body>
<header>
    <h2 id="header-left">Лабораторная работа №2</h2>
    <h2 id="header-center">Веб-программирование</h2>
    <h2 id="header-right">Горин Семён Дмитриевич P3208</h2>
</header>
<main>
    <h2>Результат текущей проверки</h2>
    <%
        AreaCheckResponse result = (AreaCheckResponse) request.getAttribute("result");
        if (result != null) {
    %>
    <table>
        <tr><th>X</th><th>Y</th><th>R</th><th>Результат</th><th>Дата</th></tr>
        <tr>
            <td><%= result.getX() %></td>
            <td><%= result.getY() %></td>
            <td><%= result.getR() %></td>
            <td><%= result.isHit() ? "Есть пробитие" : "Броня не пробита" %></td>
            <td><%= result.getDate()%></td>
        </tr>
    </table>

    <canvas id="graph" width="400" height="400"></canvas>
    <script>
        drawGraph(<%= result.getX() %>, <%= result.getY() %>, <%= result.getR() %>, <%= result.isHit() %>);
    </script>
    <% } %>

    <h3>История проверок</h3>
    <%
        java.util.List<AreaCheckResponse> history =
                (java.util.List<AreaCheckResponse>) request.getAttribute("history");
        if (history != null && !history.isEmpty()) {
    %>
    <table>
        <tr><th>X</th><th>Y</th><th>R</th><th>Попадание</th><th>Дата</th></tr>
        <% for (AreaCheckResponse res : history) { %>
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

    <a href="index.jsp">Назад</a>
</main>
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
