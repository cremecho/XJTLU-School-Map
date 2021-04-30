package com.days.linker.service;

// author: marcelo-s 20 Dec 2018
// A-Star-Java-Implementation [source code]
// from: https://github.com/marcelo-s/A-Star-Java-Implementation


public class Node {

    private double g;
    private double f;
    private double h;
    private double x;
    private double y;
    private Node parent;
    private boolean reachable;

    public Node(double x, double y) {
        super();
        this.x = x;
        this.y = y;
        reachable = true;
    }

    public void calculateHeuristic(Node finalNode) {
        this.h = Math.abs(finalNode.getX() - getX()) + Math.abs(finalNode.getY() - getY());
    }

    public void setNodeData(Node currentNode, double cost) {
        double gCost = currentNode.getG() + cost;
        setParent(currentNode);
        setG(gCost);
        //modify
        calculateFinalCost();
    }

    public boolean checkBetterPath(Node currentNode, double cost) {
        double gCost = currentNode.getG() + cost;
        if (gCost < getG()) {
            return true;
        }
        return false;
    }

    private void calculateFinalCost() {
        double finalCost = getG() + getH();
        setF(finalCost);
    }

    @Override
    public boolean equals(Object arg0) {
        Node other = (Node) arg0;
        return this.getX() == other.getX() && this.getY() == other.getY();
    }

    @Override
    public String toString() {
        return "Node [x=" + x + ", y=" + y + "]";
    }

    public double getH() {
        return h;
    }

    public void setH(double h) {
        this.h = h;
    }

    public double getG() {
        return g;
    }

    public void setG(double g) {
        this.g = g;
    }

    public double getF() {
        return f;
    }

    public void setF(double f) {
        this.f = f;
    }

    public Node getParent() {
        return parent;
    }

    public void setParent(Node parent) {
        this.parent = parent;
    }


    public double getX() {
        return x;
    }

    public void setX(double x) {
        this.x = x;
    }

    public double getY() {
        return y;
    }

    public void setY(double y) {
        this.y = y;
    }

    public boolean getReachable(){return reachable;}
    public void setReachable(boolean reachable) {this.reachable = reachable;}
}