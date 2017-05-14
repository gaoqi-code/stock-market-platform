package com.hiveview.dao;

import com.hiveview.entity.StockProduct;
import org.springframework.stereotype.Repository;

@Repository
public interface StockProductMapperDao {
    int deleteByPrimaryKey(Integer id);

    int insert(StockProduct record);

    int insertSelective(StockProduct record);

    StockProduct selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(StockProduct record);

    int updateByPrimaryKey(StockProduct record);
}