package com.hiveview.action;

import com.alibaba.fastjson.JSON;
import com.hiveview.dao.StockDataMapperDao;
import com.hiveview.entity.StockData;
import com.hiveview.entity.StockOrder;
import com.hiveview.service.StockDataService;
import com.hiveview.service.StockOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ${DESCRIPTION}
 *
 * @author zhangsw
 * @create 2017-05-10 16:20
 */
@Controller
@RequestMapping("/stock")
public class StockAction {
    @Autowired
    private StockDataService stockDataService;
    @Autowired
    private StockOrderService stockOrderService;
    /**
     * toIndex:()
     * @param request
     * @param mav
     * @author zhangsw
     * @return
     */
    @RequestMapping(value="toIndex")
    public ModelAndView toIndex(HttpServletRequest request, ModelAndView mav) {
        mav.setViewName("stock_index");
        return mav;
    }

    /**
     * toMPage:(分时线)
     * @param request
     * @param mav
     * @author zhangsw
     * @return
     */
    @RequestMapping(value="toMPage")
    public ModelAndView toMPage(HttpServletRequest request, ModelAndView mav) {
        List<StockData> initDatas=stockDataService.getInitDatasForM();
        mav.getModel().put("initDatas_m",initDatas);
        mav.setViewName("stock_m");
        return mav;
    }

    /**
     * toGetOneFreshDataForM:(获取最新分时线数据)
     * @param request
     * @author zhangsw
     * @return
     */
    @RequestMapping(value="toGetOneFreshDataForM")
    @ResponseBody
    public  String toGetOneFreshDataForM(HttpServletRequest request) {
        StockData data=stockDataService.getOneFreshDataForM();
        return JSON.toJSONString(data);
    }

    /**
     * toM5Page:(5分钟k线)
     * @param request
     * @param mav
     * @author zhangsw
     * @return
     */
    @RequestMapping(value="toM5Page")
    public ModelAndView toM5Page(HttpServletRequest request, ModelAndView mav) {
        List<StockData> initDatas=stockDataService.getInitDatasForM5();
        mav.getModel().put("initDatas_m5",initDatas);
        mav.setViewName("stock_m5");
        return mav;
    }

    /**
     * toGetOneFreshDataForM5:(获取最新5分钟k线数据)
     * @param request
     * @author zhangsw
     * @return
     */
    @RequestMapping(value="toGetOneFreshDataForM5")
    @ResponseBody
    public  String toGetOneFreshDataForM5(HttpServletRequest request) {
        StockData data=stockDataService.getOneFreshDataForM5();
        return JSON.toJSONString(data);
    }

    /**
     * toCreateStockOrder:()
     * @param request
     * @author zhangsw
     * @return
     */
    @RequestMapping(value="toCreateStockOrder")
    @ResponseBody
    public  Map<String,Object> toCreateOrder(HttpServletRequest request, StockOrder order) {
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("status",true);
        map.put("message","下单成功！");
        //参数检查
        if(null!=order){
            if(StringUtils.isEmpty(order.getBuyPrice())|| StringUtils.isEmpty(order.getBuyAmount())||
                    StringUtils.isEmpty(order.getBuyGoing())||StringUtils.isEmpty(order.getProductId())||
                    StringUtils.isEmpty(order.getRevenueModelCode())||StringUtils.isEmpty(order.getProductName())
                    ){
                map.put("status",false);
                map.put("message","参数缺失！");
            }
        }else {
            map.put("status",false);
            map.put("message","参数缺失！");
        }
        order.setFeeAmount(new BigDecimal("10.00"));
        order.setAddTime(new Date());
        order.setUpdateTime(new Date());
        stockOrderService.saveStockOrder(order);

        return map;
    }
}
