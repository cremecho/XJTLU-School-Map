package com.days.linker.entity;

public class Printer {
    private String Room;
    private int Pixelw;
    private int Pixelh;
    private int floor;
    private String feature;

    public Printer(String room, int pixelw, int pixelh, int floor, String feature) {
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

    public String getFeature() {
        return feature;
    }

    public void setRoom(String room) {
        Room = room;
    }

    public void setPixelw(int pixelw) {
        Pixelw = pixelw;
    }

    public void setPixelh(int pixelh) {
        Pixelh = pixelh;
    }

    public void setFloor(int floor) {
        this.floor = floor;
    }

    public void setFeature(String feature) {
        this.feature = feature;
    }
}
