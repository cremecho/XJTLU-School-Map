package com.days.linker.mapper;

import com.days.linker.entity.Printer;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PrinterMapper {
    List<Printer> findAll();
}
