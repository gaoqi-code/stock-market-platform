package com.hiveview.service;

import com.hiveview.entity.StockRevenueModel;

/**
 * ${DESCRIPTION}
 *
 * @author zhangsw
 * @create 2017-05-19 16:27
 */
public interface StockRevenueModelService {
    public StockRevenueModel getModelById(Integer id);

    public void updateModelById(StockRevenueModel model);

}
