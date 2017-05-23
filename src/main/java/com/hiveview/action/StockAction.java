package com.hiveview.action;

import com.alibaba.fastjson.JSON;
import com.hiveview.contants.Constants;
import com.hiveview.contants.ContantType;
import com.hiveview.entity.*;
import com.hiveview.entity.vo.Data;
import com.hiveview.service.*;
import com.hiveview.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.*;

/**
 * ${DESCRIPTION}
 *
 * @author zhangsw
 * @create 2017-05-10 16:20
 */
@Controller
@RequestMapping("/stock")
public class StockAction extends CommonAction{
    @Autowired
    private StockDataService stockDataService;
    @Autowired
    private StockOrderService stockOrderService;
    @Autowired
    private UserService userService;
    @Autowired
    private StockRevenueModelService stockRevenueModelService;
    @Autowired
    private StockProductService stockProductService;
    /**
     * toIndex:()
     * @param request
     * @param mav
     * @author zhangsw
     * @return
     */
    @RequestMapping(value="toIndex")
    public ModelAndView toIndex(HttpServletRequest request, ModelAndView mav) {
        //产品列表
        List<StockProduct> products=stockProductService.getSellingProducts();
        //营销模式
        List<StockRevenueModel> listModel=stockRevenueModelService.getModelList();
        int userId=getUserId(request);
        User user=userService.getUserById(41);
        List<StockData> initDatas=stockDataService.getInitDatasForM();

        mav.getModel().put("products",products);
        mav.getModel().put("initDatas",initDatas);
        mav.getModel().put("user",user);
        mav.getModel().put("models",listModel);
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
    @RequestMapping(value="toGetInitData")
    @ResponseBody
    public Data toMPage(HttpServletRequest request) {
        String lineType=request.getParameter("lineType");
        Data data=new Data();
        List<StockData> initDatas=null;
        if("".equals(lineType)||null==lineType){
            data.setCode(0);
            data.setMsg("请选择k线类型");
        }
        try {
            switch (Integer.valueOf(lineType)){
                case 0:
                    initDatas=stockDataService.getInitDatasForM();
                    break;
                case 1:
                    initDatas=stockDataService.getInitDatasForM1();
                    break;
                case 5:
                    initDatas=stockDataService.getInitDatasForM5();
                    break;
                case 15:
                    initDatas=stockDataService.getInitDatasForM15();
                    break;
            }
            data.setCode(1);
            data.setMsg("查询成功！");
            data.setData(initDatas);
        }catch (Exception e){
            e.printStackTrace();
            data.setCode(0);
            data.setMsg("查询失败！");
        }
        return data;
    }

    /**
     * toGetOneFreshDataForM:(获取最新分时线数据)
     * @param request
     * @author zhangsw
     * @return
     */
    @RequestMapping(value="toGetOneFreshData")
    @ResponseBody
    public  Data toGetOneFreshData(HttpServletRequest request) {
        String lineType=request.getParameter("lineType");
        Data data=new Data();
        List<StockData> list=new ArrayList<StockData>();
        if("".equals(lineType)||null==lineType){
            data.setCode(0);
            data.setMsg("请选择k线类型");
        }
        StockData stockData=null;
        try {
            switch (Integer.valueOf(lineType)){
                case 0:
                    stockData=stockDataService.getOneFreshDataForM();
                    break;
                case 1:
                    stockData=stockDataService.getOneFreshDataForM1();
                    break;
                case 5:
                    stockData=stockDataService.getOneFreshDataForM5();
                    break;
                case 15:
                    stockData=stockDataService.getOneFreshDataForM15();
                    break;
            }
            list.add(stockData);
            data.setCode(1);
            data.setMsg("查询成功！");
            data.setData(list);
        }catch (Exception e){
            e.printStackTrace();
            data.setCode(0);
            data.setMsg("查询失败！");
        }
        return data;
    }


    /**
     * toCreateStockOrder:()
     * @param request
     * @author zhangsw
     * @return
     */
    @RequestMapping(value="toCreateStockOrder")
    @ResponseBody
    public  Data toCreateOrder(HttpServletRequest request, StockOrder order) {
        Data data=new Data();
        //参数检查
        if(null!=order){
            if(StringUtils.isEmpty(order.getBuyPrice())|| StringUtils.isEmpty(order.getBuyAmount())||
                    StringUtils.isEmpty(order.getBuyGoing())||StringUtils.isEmpty(order.getProductId())||
                    StringUtils.isEmpty(order.getProductName())
                    ){
                data.setCode(0);
                data.setMsg("参数缺失！");
                return data;
            }
        }else {
            data.setCode(0);
            data.setMsg("参数缺失！");
            return data;
        }
        try {
            //获取用户信息 检查余额
            int userId=getUserId(request);
            User user=userService.getUserById(41);
            BigDecimal balance=user.getBalance();
            StockRevenueModel model=stockRevenueModelService.getModelById(order.getModelId());
            BigDecimal buyAmount=order.getBuyAmount();
            BigDecimal feeAmount=buyAmount.multiply(new BigDecimal(model.getFeeNum())).divide(new BigDecimal(100));
            BigDecimal total=buyAmount.add(feeAmount);

            if(balance.compareTo(total)==-1){
                data.setCode(0);
                data.setMsg("余额不足！");
                return data;
            }

            //修改用户余额
            userService.updateUserBalance(user.getId(),total, ContantType.balanceLogType_5,"微盘消费",false);
            String orderNo = DateUtil.getOrderNum() + DateUtil.getThree();
            //创建订单
            order.setOrderNo(orderNo);
            order.setOrderStatus(StockOrder.STATUS_HOLDING);//持仓中
            order.setAgentId(user.getAgentId());
            order.setFeeAmount(feeAmount);
            order.setRevenueModelCode(model.getRevenueCode());
            order.setAddTime(new Date());
            order.setUpdateTime(new Date());
            stockOrderService.saveStockOrder(order);
            data.setCode(1);
            data.setMsg("下单成功！");
        }catch (Exception e){
            e.printStackTrace();
            data.setCode(0);
            data.setMsg("下单失败！");
        }

        return data;
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
            BigDecimal feeAmount=new BigDecimal(model.getFeeNum());
            if(flag>=0){//赚了
                BigDecimal buyAmount=order.getBuyAmount();
                //盈利金额=购买金额*收益百分比+购买金额-手续费
                order.setOrderStatus(StockOrder.STATUS_ZHIYING);
            }else{

            }

        }
    }
}
