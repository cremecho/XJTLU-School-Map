package com.days.linker.entity;

public class Drinking {
    private String Room;
    private int Pixelw;
    private int Pixelh;
    private int floor;
    private int feature;

    public Drinking(String room, int pixelw, int pixelh, int floor, int feature) {
        Room = room;
        Pixelw = pixelw;
        Pixelh = pixelh;
        this.floor = floor;
        this.feature = feature;
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

    public int getFloor() {
        return floor;
    }

    public int getFeature() {
        return feature;
    }
}
