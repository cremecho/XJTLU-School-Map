package com.days.linker.service;

import com.days.linker.entity.Classroom;
import com.days.linker.entity.Elevator;
import com.days.linker.entity.Path;
import com.days.linker.entity.Printer;
import com.days.linker.mapper.ClassroomMapper;
import com.days.linker.mapper.EvelMapper;
import com.days.linker.mapper.PathMapper;
import com.days.linker.mapper.PrinterMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TTL {
    @Autowired
    private ClassroomMapper classroomMapper;
    @Autowired
    private EvelMapper evelMapper;
    @Autowired
    private PathMapper pathMapper;
    @Autowired
    private PrinterMapper printerMapper;



    public List<Classroom> findAll(){
        return classroomMapper.findAll();
    }

    public List<String> tt2(){
        return classroomMapper.findClassroom();
    }

    public List<String> findClassroom(){
        List<Classroom> l= classroomMapper.findAll();
        List<String> cl = new ArrayList<>();
        for (Classroom d : l){
            if (d != null) {
                if (!d.getRoom().contains("(") && !d.getRoom().contains("Path"))
                    cl.add(d.getRoom());
            }
        }
        return cl;
    }

    public List<Classroom> findClassroomInfo(String classroom){
        List<Classroom> l= classroomMapper.findAll();
        List<Classroom> temp = new ArrayList<>();
        for(Classroom d: l){
            if (d != null) {
                if (d.getRoom().trim().toUpperCase().equals(classroom.trim().toUpperCase())) {
                    temp.add(d);
                    //break;
                }
            }
        }
        return temp;
    }

    public List<String> ptroom(){
        List<String> roomList = new ArrayList<>();
        List<Printer> pt = printerMapper.findAll();
        for(Printer p : pt){
            roomList.add(p.getRoom());
        }
        return roomList;
    }

    public List<Printer> pt(String classroom){
        List<Printer> ppt = printerMapper.findAll();
        List<Printer> rpt = new ArrayList<>();
        for(Printer p: ppt){
            if (p != null){
                if(p.getRoom().trim().toUpperCase().equals( classroom.trim().toUpperCase())){
                    rpt.add(p);
                }
            }
        }
        return rpt;
    }

    Path start = null;
    Path end = null;
    double nearestStartPath = Double.MAX_VALUE;
    double nearestEndPath = Double.MAX_VALUE;

    public List[] searchPath(String classroom1, String classroom2, int floor1, int floor2) {
        List<Elevator> ev = evelMapper.findAll();
        List<Path> path = pathMapper.findAll();

        List<Node> level1 = new ArrayList<>();
        List<Node> level2 = new ArrayList<>();
        List<Node> level3 = new ArrayList<>();
        List<Node> level4 = new ArrayList<>();
        List<Node> level5 = new ArrayList<>();
        List[] level = {level1,level2,level3,level4,level5};

        //start end init
        List<Classroom> l= classroomMapper.findAll();
        Classroom[] cl = new Classroom[2];
        for (Classroom d : l){
            if (d != null) {
                if (d.getRoom().contains("(") && d.getRoom().toUpperCase().trim().contains(classroom1.trim().toUpperCase())){
                    cl[0] = d;
                    break;}
            }
        }
        for (Classroom d : l){
            if (d != null) {
                if (d.getRoom().contains("(") && d.getRoom().trim().toUpperCase().contains(classroom2.trim().toUpperCase())){
                    cl[1] = d;
                    break;}
            }
        }
        if (cl[0] == null || cl[1] == null){throw new IllegalArgumentException("wrong classroom name");}

        //path init
        for(Path p : path){
            if(p.getFloor() == 1){
                level1.add(new Node(p.getCorx(), p.getCory()));
                initPathofLevel(1, p, cl);
            } else if (p.getFloor() == 2){
                level2.add(new Node(p.getCorx(), p.getCory()));
                initPathofLevel(2, p,  cl);
            } else if (p.getFloor() == 3){
                level3.add(new Node(p.getCorx(), p.getCory()));
                initPathofLevel(3, p,  cl);
            } else if (p.getFloor() == 4){
                level3.add(new Node(p.getCorx(), p.getCory()));
                initPathofLevel(4,  p,  cl);
            } else if (p.getFloor() == 5){
                level3.add(new Node(p.getCorx(), p.getCory()));
                initPathofLevel(5,  p,  cl);
            }
        }
        Node nstart = new Node(start.getCorx(), start.getCory());
        Node nend = new Node(end.getCorx(), end.getCory());


        //.....  main algorithm part   .....//
        if (floor1 == floor2) {
            List[] finalReturnList = new List[1];
            //System.out.println(level[floor1 -1].get(0));
            finalReturnList[0] = aStar(nstart, nend, level[floor1 - 1], cl);;
            return finalReturnList;
        } else {
            List[] finalReturnList = new List[2];
            double mindis = Double.MAX_VALUE;
            Elevator temp = new Elevator("",0,0,0,0,0,0);
            Elevator temp2 = null;
            for (Elevator e : ev){
                if (e.getFloor() == floor2) {
                    double currentDis = Math.pow(e.getCorx() - nend.getX(), 2) + Math.pow(e.getCory() - nend.getY(), 2);
                    if (currentDis < mindis) {
                        mindis = currentDis;
                        temp = e;
                    }
                }
            }
            for(Elevator e : ev){
                if (e.getFloor() == floor1 && e.getConnector().equals(temp.getConnector())){
                    temp2 = e;
                    break;
                }
            }

            Double dMin1 = Double.MAX_VALUE;
            Double dMin2 = Double.MAX_VALUE;
            Path tmpPath1 = null,tmpPath2 = null;
            for (Path p : path){
                if (p.getFloor() == floor2 && Math.pow(p.getCorx() - temp.getCorx(),2) + Math.pow(p.getCory() - temp.getCory(), 2) < dMin1){
                    tmpPath1 = p;
                    dMin1 = Math.pow(p.getCorx() - temp.getCorx(),2) + Math.pow(p.getCory() - temp.getCory(), 2);
                } else if (p.getFloor() == floor1 && Math.pow(p.getCorx() - temp2.getCorx(),2) + Math.pow(p.getCory() - temp2.getCory(), 2) < dMin2){
                    tmpPath2 = p;
                    dMin2 = Math.pow(p.getCorx() - temp2.getCorx(),2) + Math.pow(p.getCory() - temp2.getCory(), 2);
                }
            }
            Node n1 = new Node(tmpPath2.getCorx(), tmpPath2.getCory());
            Node n2 = new Node(tmpPath1.getCorx(),tmpPath1.getCory());
            List<Noderesult> part1 = aStar(nstart, n1, level[floor1 - 1], cl);
            List<Noderesult> part2 = aStar(n2, nend, level[floor2 - 1], cl);
            finalReturnList[0] = part1;
            finalReturnList[1] = part2;
            return finalReturnList;
        }
    }


    private List<Noderesult> aStar(Node nstart, Node nend, List<Node> level, Classroom[] cl){
        ArrayList<Node> open = new ArrayList<>();
        ArrayList<Node> close = new ArrayList<>();
        nstart.calculateHeuristic(nend);
        nstart.setG(0);
        nstart.setF(nstart.getG() + nstart.getH());
        open.add(nstart);
        while (!open.isEmpty()){
            //remove and return min F value node
            if (open.size() != 1){
                for(int i = 0 ; i < open.size() - 1; i++){
                    for(int j = i + 1; j < open.size(); j++){
                        if(open.get(j).getF() < open.get(i).getF()){
                            Node temp = open.get(i);
                            open.set(i, open.get(j));
                            open.set(j, temp);
                        }
                    }
                }
            }
            Node currentNode= open.remove(0);
            //add it to close list
            close.add(currentNode);
            //if the node is final node, return getPath
            if (currentNode.equals(nend)){
                return getPath(currentNode, cl[0], cl[1]);
            }
            //else find adjacent nodes of the current node
            else {
                // 1. find nearest node that not in close list
                List<Node> adj = adjacentNodes(currentNode, level);
                // 2. check whether points are already in close list
                for (Node n : adj){
                    n.calculateHeuristic(nend);
                    double cost = Math.sqrt(Math.pow(currentNode.getX() - n.getX(), 2) + Math.pow(currentNode.getY() - n.getY(), 2));
                    if (!close.contains(n)){
                        if (!open.contains(n)){
                            n.setNodeData(currentNode, cost);
                            open.add(n);
                        } else if (n.checkBetterPath(currentNode, cost)){
                            n.setNodeData(currentNode, cost);
                            open.remove(n);
                            open.add(n);
                        }
                    }
                }

            }
        }
        start = null;
        end = null;
        nearestStartPath = Double.MAX_VALUE;
        nearestEndPath = Double.MAX_VALUE;
        return new ArrayList<>();
    }


    private List<Noderesult> getPath(Node currentNode, Classroom c1, Classroom c2) {
        //Noderesult c11 = new Noderesult(c1.getcorx(), c1.getcory());
        //Noderesult c22 = new Noderesult(c2.getcorx(), c2.getcory());
        List<Noderesult> path = new ArrayList<Noderesult>();
        //path.add(c22);
        path.add( new Noderesult(Math.round(currentNode.getX() * 50),Math.round(currentNode.getY() * 50)));
        Node parent;
        while ((parent = currentNode.getParent()) != null) {
            path.add(0, new Noderesult(Math.round(parent.getX() * 50), Math.round(parent.getY() * 50)));
            currentNode = parent;
        }
        //path.add(0,c11);
        start = null;
        end = null;
        nearestStartPath = Double.MAX_VALUE;
        nearestEndPath = Double.MAX_VALUE;
        return path;
    }


    private List<Node> adjacentNodes(Node currentNode, List<Node> level){
        List<Node> adj = new ArrayList<>();
        Node[] xNodes = new Node[2];
        Node[] yNodes = new Node[2];
        double cx = currentNode.getX();
        double cy = currentNode.getY();
        double posDelta = Double.MAX_VALUE;
        double negDelta = -1000;
        // same x
        for(Node n : level){
            if (cx == n.getX() && cy != n.getY()){
                double deltaY = n.getY()- cy;
                if (Math.abs(deltaY) > 1){
                    continue;
                }
                if (deltaY > 0 && deltaY < posDelta){
                    yNodes[0] = n;
                    posDelta = deltaY;
                }  if(deltaY < 0 && deltaY > negDelta){
                    yNodes[1] = n;
                    negDelta = deltaY;
                }
            }
        }

        posDelta = Double.MAX_VALUE;
        negDelta = -1000;

        // same y
        for(Node n : level){
            if(cy == n.getY() && cx != n.getX()){
                double deltaX = n.getX() -cx;
                if (Math.abs(deltaX) > 1){
                    continue;
                }
                if (deltaX > 0 && deltaX < posDelta){
                    xNodes[0] = n;
                    posDelta = deltaX;
                }  if (deltaX < 0 && deltaX > negDelta){
                    yNodes[1] = n;
                    negDelta = deltaX;
                }
            }
        }

        if (xNodes[0] != null){adj.add(xNodes[0]);}
        if (xNodes[1] != null){adj.add(xNodes[1]);}
        if (yNodes[0] != null){adj.add(yNodes[0]);}
        if (yNodes[1] != null){adj.add(yNodes[1]);}

        return adj;
    }


    private void initPathofLevel(int level, Path p, Classroom[] cl){
        if (cl[0].getfloor() == level){
            double dis = Math.pow(cl[0].getcorx() - p.getCorx(), 2) + Math.pow(cl[0].getcory() - p.getCory(), 2);
            if (dis < nearestStartPath){
                start = p;
                nearestStartPath = dis;
            }
        }
        if (cl[1].getfloor() == level){
            double dis = Math.pow(cl[1].getcorx() - p.getCorx(), 2) + Math.pow(cl[1].getcory() - p.getCory(), 2);
            if (dis < nearestEndPath){
                end = p;
                nearestEndPath = dis;
            }
        }
    }



}


