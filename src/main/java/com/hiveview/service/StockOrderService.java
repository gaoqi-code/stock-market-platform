package com.hiveview.service;

import com.hiveview.entity.StockOrder;

import java.math.BigDecimal;

/**
 * ${DESCRIPTION}
 *
 * @author zhangsw
 * @create 2017-05-15 17:15
 */
public interface StockOrderService {

    public StockOrder getStockOrderById(long id);

    public int saveStockOrder(StockOrder orderInfo);

    public int updateStockOrder(StockOrder orderInfo);

    public BigDecimal getHoldAmoutByUserId(long userId);

}
