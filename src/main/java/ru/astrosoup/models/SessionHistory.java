package ru.astrosoup.models;

import jakarta.servlet.http.HttpSession;
import ru.astrosoup.DTOs.AreaCheckResponse;

import java.util.ArrayList;
import java.util.List;

public class SessionHistory {
    public static List<AreaCheckResponse> getSessionHistory(HttpSession session) {
        List<AreaCheckResponse> history = (List<AreaCheckResponse>) session.getAttribute("history");
        if (history == null) {
            history = new ArrayList<>();
            session.setAttribute("history", history);
        }
        return history;
    }
}
