package com.days.linker.entity;

public class Classroom {
    private String Room;
    private int Pixelw;
    private int Pixelh;
    private double corx;
    private double cory;
    private int floor;

    public Classroom(String Room, int Pixelw, int Pixelh, double corx, double cory, int floor) {
        this.Room = Room;
        this.Pixelw = Pixelw;
        this.Pixelh = Pixelh;
        this.corx = corx;
        this.cory = cory;
        this.floor = floor;
    }

    public String getRoom() {
        return Room;
    }

    public int getPixelw() {
        return Pixelw;
    }

    public int getPixelh() {
        return Pixelh;
    }

    public double getcorx() {
        return corx;
    }

    public double getcory() {
        return cory;
    }

    public int getfloor() {
        return floor;
    }
}
