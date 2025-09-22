package ru.astrosoup.services;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ru.astrosoup.DTOs.AreaCheckResponse;
import ru.astrosoup.exceptions.InvalidDataException;
import ru.astrosoup.models.SessionHistory;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(urlPatterns = {"/areaCheck"})
public class AreaCheckServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(AreaCheckServlet.class.getName());

    private boolean checkHit(int x, double y, int r) {

        if (x <= 0 && y >= 0 && (x*x + y*y <= r*r)) return true;

        if (x <= 0 && y<= 0 && x >= -(double)r / 2 && y >= -r ) return true;

        if (x >= 0 && y >= 0 && y <= -2 * x + r) return true;

        return false;
    }
    private boolean validate(int x, double y, int r) {
        return Arrays.asList(1, 2, 3, 4, 5).contains(r) &&
                Arrays.asList(-3, -2, -1, 0, 1, 2, 3, 4, 5).contains(x) &&
                y > -5 && y < 3;
    }

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            int x = Integer.parseInt(req.getParameter("x"));
            double y = Double.parseDouble(req.getParameter("y"));
            int r = Integer.parseInt(req.getParameter("r"));
            if (!validate(x, y, r)) {
                throw new InvalidDataException("One of the parameters is invalid");
            }
            boolean hit = checkHit(x, y, r);

            AreaCheckResponse response = new AreaCheckResponse();
            response.setX(x);
            response.setY(y);
            response.setR(r);
            response.setHit(hit);
            logger.info("AreaCheckServlet: response: " + response.toString());
            List<AreaCheckResponse> responses = SessionHistory.getSessionHistory(req.getSession());
            responses.add(response);
            req.setAttribute("result", response);
            req.setAttribute("history", responses);
            req.getRequestDispatcher("/result.jsp").forward(req, resp);
        } catch (NumberFormatException | InvalidDataException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "One of the arguments is invalid");
        } catch (NullPointerException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "One of the arguments is empty");
        }
    }
}
