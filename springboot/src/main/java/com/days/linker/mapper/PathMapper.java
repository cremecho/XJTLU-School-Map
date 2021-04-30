package com.days.linker.mapper;

import com.days.linker.entity.Path;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PathMapper {
    List<Path> findAll();
    List<Path> findLevel1();
    List<Path> findLevel2();
}