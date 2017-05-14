package com.hiveview.service;

import com.hiveview.entity.StockData;

import java.util.List;

/**
 * ${DESCRIPTION}
 *
 * @author zhangsw
 * @create 2017-05-14 11:48
 */
public interface StockDataService {
    /**
     * 分时线初始化数据
     */
    List<StockData> getInitDatasForM();

    /**
     * 查询分时线最新数据
     */
    StockData getOneFreshDataForM();

    /**
     * 5分钟K线初始化数据
     */
    List<StockData> getInitDatasForM5();

    /**
     * 5分钟K线最新数据
     */
    StockData getOneFreshDataForM5();
}
