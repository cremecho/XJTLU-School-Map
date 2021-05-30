package com.days.linker.entity;

public class ClassroomInformation {
    private String Door;
    private int Pixelw;
    private int Pixelh;
    private int floor;
    private String feature;

    public ClassroomInformation(String door, int pixelw, int pixelh, int floor, String feature) {
        Door = door;
        Pixelw = pixelw;
        Pixelh = pixelh;
        this.floor = floor;
        this.feature = feature;
    }

    public String getDoor() {
        return Door;
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
}
