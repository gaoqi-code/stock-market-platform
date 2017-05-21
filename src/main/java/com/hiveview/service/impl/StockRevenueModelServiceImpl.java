package com.hiveview.service.impl;

import com.hiveview.dao.StockOrderMapperDao;
import com.hiveview.dao.StockRevenueModelMapperDao;
import com.hiveview.entity.StockRevenueModel;
import com.hiveview.service.StockRevenueModelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * ${DESCRIPTION}
 *
 * @author zhangsw
 * @create 2017-05-19 16:40
 */
@Service
public class StockRevenueModelServiceImpl implements StockRevenueModelService {

    @Autowired
    private StockRevenueModelMapperDao stockRevenueModelMapperDao;

    @Override
    public StockRevenueModel getModelById(Integer id) {
        return stockRevenueModelMapperDao.selectByPrimaryKey(id);
    }

    @Override
    public void updateModelById(StockRevenueModel model) {
        stockRevenueModelMapperDao.updateByPrimaryKey(model);
    }
}
