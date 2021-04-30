package com.days.linker.entity;

public class Elevator {
    private String Connector;
    private int Pixelw;
    private int Pixelh;
    private double corx;
    private double cory;
    private int floor;
    private int dataType;

    public Elevator(String connector, int pixelw, int pixelh, double corx, double cory, int floor, int dataType) {
        Connector = connector;
        Pixelw = pixelw;
        Pixelh = pixelh;
        this.corx = corx;
        this.cory = cory;
        this.floor = floor;
        this.dataType = dataType;
    }

    public String getConnector() {
        return Connector;
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

    public int getDataType() {
        return dataType;
    }
}
