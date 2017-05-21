package com.hiveview.action;

import com.alibaba.fastjson.JSON;
import com.hiveview.common.Constants;
import com.hiveview.dao.StockDataMapperDao;
import com.hiveview.entity.StockData;
import com.hiveview.entity.StockOrder;
import com.hiveview.entity.StockRevenueModel;
import com.hiveview.entity.User;
import com.hiveview.service.StockDataService;
import com.hiveview.service.StockOrderService;
import com.hiveview.service.StockRevenueModelService;
import com.hiveview.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

    @Autowired
    private UserService userService;
    @Autowired
    private StockRevenueModelService stockRevenueModelService;

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
    public  String toCreateOrder(HttpServletRequest request, StockOrder order) {
        Map<String,Object> map=new HashMap<String,Object>();
        //参数检查
        if(null!=order){
            if(StringUtils.isEmpty(order.getBuyPrice())|| StringUtils.isEmpty(order.getBuyAmount())||
                    StringUtils.isEmpty(order.getBuyGoing())||StringUtils.isEmpty(order.getProductId())||
                    StringUtils.isEmpty(order.getRevenueModelCode())||StringUtils.isEmpty(order.getProductName())
                    ){
                map.put("status",false);
                map.put("message","参数缺失！");
                return JSON.toJSONString(map);
            }
        }else {
            map.put("status",false);
            map.put("message","参数缺失！");
            return JSON.toJSONString(map);
        }
        //获取用户信息 检查余额
        User user=userService.getUserByUnionid(order.getUnionid());
        BigDecimal balance=user.getBalance();
        if(balance.compareTo(order.getBuyAmount())==-1){
            map.put("status",false);
            map.put("message","余额不足！");
            return JSON.toJSONString(map);
        }

        try {
            //修改用户余额
            BigDecimal toltal=order.getBuyAmount().add(new BigDecimal("10.00"));
            BigDecimal newBalance=balance.subtract(toltal);
            userService.updateUserBalance(user.getId(),newBalance,4,"ddd",false);
            order.setOrderStatus(StockOrder.STATUS_HOLDING);//持仓中
            order.setFeeAmount(new BigDecimal("10.00"));
            order.setAddTime(new Date());
            order.setUpdateTime(new Date());
            stockOrderService.saveStockOrder(order);
            map.put("status",true);
            map.put("message","下单成功！");
        }catch (Exception e){
            e.getStackTrace();
            map.put("status",false);
            map.put("message","下单失败！");
        }

        return JSON.toJSONString(map);
    }

    /**
     * toChangeOrder:(获取最新数据)
     * @param request
     * @param mav
     * @author zhangsw
     * @return
     */
    @RequestMapping(value="toChangeOrder")
    public void toChangeOrder(HttpServletRequest request, ModelAndView mav) {
        //获取最新数据
        StockData data=stockDataService.getOneFreshDataForM5();
        BigDecimal newPrice=data.getPrice();
        //获取未结算的订单
        List<StockOrder> list=stockOrderService.getStockOrdersByStatus(StockOrder.STATUS_HOLDING);
        for(StockOrder order:list){

            //营销模式
            StockRevenueModel model=stockRevenueModelService.getModelById(order.getModelId());
            //模式要求涨跌量
            BigDecimal quantity=new BigDecimal(model.getChangeQuantity());

            BigDecimal val=null;
            int flag=-1;
            //买涨而且当前价格大于等于买入价
            if(order.getBuyGoing()== Constants.BUY_GOING_ZHANG && newPrice.compareTo(order.getBuyPrice())>=0){
                val=newPrice.subtract(order.getBuyPrice());
                flag=val.compareTo(quantity);
            //买跌而且当前价格小于买入价
            }else {
                val=order.getBuyPrice().subtract(newPrice);
                flag=val.compareTo(quantity);
            }

            if(flag>=0){//赚了
                BigDecimal buyAmount=order.getBuyAmount();
                order.setOrderStatus(StockOrder.STATUS_ZHIYING);
            }else{

            }

        }
    }
}
