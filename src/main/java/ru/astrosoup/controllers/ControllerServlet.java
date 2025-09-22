package ru.astrosoup.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.logging.Logger;

@WebServlet(urlPatterns = {"/lab"})
public class ControllerServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(ControllerServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        logger.info("Requested path: " + path);
        String x = req.getParameter("x");
        String y = req.getParameter("y");
        String r = req.getParameter("r");

        logger.info("Lab request parameters: x=" + x + " y=" + y + " r=" + r);

        if (x == null || y == null || r == null || x.isBlank() || y.isBlank() || r.isBlank()) {
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/areaCheck").forward(req, resp);
        }

    }
}
