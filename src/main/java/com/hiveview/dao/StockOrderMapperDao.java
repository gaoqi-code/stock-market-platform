package com.hiveview.dao;

import com.hiveview.entity.StockOrder;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StockOrderMapperDao {

    int saveStockOrder(StockOrder record);

    StockOrder selectByPrimaryKey(Integer id);

    int updateByPrimaryKey(StockOrder record);

    List<StockOrder> getStockOrdersByStatus(@Param("status") int status);

}