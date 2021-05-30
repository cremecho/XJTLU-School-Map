package com.days.linker.mapper;

import com.days.linker.entity.Drinking;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DrinkingMapper {
    List<Drinking> findAll();
}
