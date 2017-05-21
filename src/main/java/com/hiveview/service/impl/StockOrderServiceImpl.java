package com.hiveview.service.impl;

import com.hiveview.dao.StockDataMapperDao;
import com.hiveview.dao.StockOrderMapperDao;
import com.hiveview.entity.StockOrder;
import com.hiveview.service.StockOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

/**
 * ${DESCRIPTION}
 *
 * @author zhangsw
 * @create 2017-05-15 17:21
 */
@Service
public class StockOrderServiceImpl implements StockOrderService {
    @Autowired
    private StockOrderMapperDao stockOrderMapperDao;

    @Override
    public StockOrder getStockOrderById(long id) {
        return null;
    }

    @Override
    public int saveStockOrder(StockOrder orderInfo) {
        return stockOrderMapperDao.saveStockOrder(orderInfo);
    }

    @Override
    public int updateStockOrder(StockOrder orderInfo) {
        return 0;
    }

    @Override
    public BigDecimal getHoldAmoutByUserId(long userId) {
        return null;
    }

    @Override
    public List<StockOrder> getStockOrdersByStatus(int status) {
        return null;
    }
}
