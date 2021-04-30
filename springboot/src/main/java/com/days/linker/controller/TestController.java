package com.days.linker.controller;

import com.days.linker.entity.Classroom;
import com.days.linker.entity.Printer;
import com.days.linker.service.Node;
import com.days.linker.service.Noderesult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.days.linker.service.TTL;

import java.util.List;

@RestController
public class TestController {

    @Autowired
    private TTL ttl;

    @RequestMapping("/abc")
    public List<Classroom> getDemp(){
        return ttl.findAll();
    }

    @RequestMapping("/classroom")
    public List<String> getClassroom() {return ttl.findClassroom(); }

    @RequestMapping(value = "searchpath", method = RequestMethod.POST)
    public List[] searchPath(@RequestParam(value = "tmp",required = true) String tmp){
        String[] s = tmp.split("!");
        for (String a : s){
            System.out.println(a);
        }
        String c1 = s[0];
        String c2 = s[1];
        int c3 = Integer.parseInt(s[2]);
        int c4 = Integer.parseInt(s[3]);
        return ttl.searchPath(c1,c2,c3,c4);
    }


    @RequestMapping("/bug")
    public List[] bug(){
        return ttl.searchPath("SA169", "SC321", 2, 3);
    }

    @RequestMapping(value = "po", method = RequestMethod.POST)
    public List<Classroom> t(@RequestParam(value = "classroom",required = true) String classroom){
        return ttl.findClassroomInfo(classroom);
    }

    @RequestMapping(value = "printer", method = RequestMethod.POST)
    public List<Printer> ptr(@RequestParam(value = "classroom",required = true) String classroom){
        return ttl.pt(classroom);
    }

    @RequestMapping("/printerroom")
    public List<String> roomList(){
        return ttl.ptroom();
    }
}
