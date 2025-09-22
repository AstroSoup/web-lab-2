package ru.astrosoup.DTOs;

import lombok.Data;

import java.time.LocalDate;
@Data
public class AreaCheckResponse {
    private int x;
    private double y;
    private int r;
    private boolean hit;
    private LocalDate date = LocalDate.now();
}
