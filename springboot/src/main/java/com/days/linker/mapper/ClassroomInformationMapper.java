package com.days.linker.mapper;

import com.days.linker.entity.ClassroomInformation;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ClassroomInformationMapper {
    public List<ClassroomInformation> findAll();
}
