package com.days.linker.entity;

public class Path {
    private String Path;
    private int Pixelw;
    private int Pixelh;
    private double corx;
    private double cory;
    private int floor;

    public Path(String path, int pixelw, int pixelh, double corx, double cory, int floor) {
        Path = path;
        Pixelw = pixelw;
        Pixelh = pixelh;
        this.corx = corx;
        this.cory = cory;
        this.floor = floor;
    }

    public String getPath() {
        return Path;
    }

    public int getPixelw() {
        return Pixelw;
    }

    public int getPixelh() {
        return Pixelh;
    }

    public double getCorx() {
        return corx;
    }

    public double getCory() {
        return cory;
    }

    public int getFloor() {
        return floor;
    }
}
