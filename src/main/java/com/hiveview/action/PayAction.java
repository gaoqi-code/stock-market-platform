package com.hiveview.action;

import com.hiveview.entity.Orders;
import com.hiveview.entity.User;
import com.hiveview.entity.vo.Data;
import com.hiveview.service.OrdersService;
import com.hiveview.service.UserService;
import com.hiveview.util.ProperManager;
import com.hiveview.util.WXSignUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

/**
 * ${DESCRIPTION}
 *
 * @author zhangsw
 * @create 2017-05-18 17:21
 */
public class PayAction extends CommonAction{

    @Autowired
    private OrdersService ordersService;
    @Autowired
    private UserService userService;

    @RequestMapping(value = "/chongzhi")
    public String chongzhi(HttpServletRequest req){
        String orderAmt = req.getParameter("orderAmt");
        req.getParameter("payType");
        String returnURL = ProperManager.getString("pay.return.url");
        String notifyURL = ProperManager.getString("pay.notify.url");
        int userId = this.getUserId(req);
        SortedMap<String,Object> parameters = new TreeMap<String,Object>();
        parameters.put("orderAmt",orderAmt);
        parameters.put("curType","CNY");
        parameters.put("bankId","888C");
        parameters.put("returnURL",returnURL);
        parameters.put("notifyURL",notifyURL);
        parameters.put("cardType","01");
        parameters.put("userId",userId);
        parameters.put("goodsName" , req.getParameter("goodsName"));
        parameters.put("remark" , req.getParameter("remark"));
        parameters.put("goodsType",req.getParameter("goodsType"));
        //生成订单
        Orders orders = ordersService.addOrder("充值"+orderAmt+"元", new BigDecimal(orderAmt),userId,1);
        parameters.put("orderNo",orders.getOrderNo());
        String sign = WXSignUtils.createSign("utf-8",parameters);
        System.out.println("sign = " + sign);
        parameters.put("sign",sign);
        req.setAttribute("formParam",parameters);
        return "view/rz";
    }

    /**
     * 支付完成后的同步回调方法
     * @return
     */
    @RequestMapping(value = "/returnUrl")
    @ResponseBody
    public ModelAndView returnUrl(HttpServletRequest request) throws IOException {
        ModelAndView mav=new ModelAndView();
        Map<?, ?> map = request.getParameterMap();
        String sign = (String) map.remove("sign");
        String tradeNo=(String) map.remove("tradeNo");
        SortedMap mapParams=new TreeMap(map);
        int userId = this.getUserId(request);
        //验证请求信息与订单信息的合法性
        if(null!=sign&&sign.equals(WXSignUtils.createSign("utf-8",mapParams))){
            User user=userService.getUserByParentId(userId);
            mapParams.put("balance",user.getBalance());
            mav.getModel().put("data",mapParams);
            mav.setViewName("chongzhi/success");
        }else{
            mav.setViewName("chongzhi/error");
        }
        return mav;
    }

    /**
     * 支付完成后的异步回调方法
     * @return
     */
    @RequestMapping(value = "/notifyUrl")
    @ResponseBody
    public Data notifyUrl(HttpServletRequest request) throws IOException {
        String orderNo = request.getParameter("orderNo");
        String tradeNo = request.getParameter("tradeNo");
        String sign = request.getParameter("sign");
        String code = request.getParameter("code");
        System.out.println("---支付成功，异步回调。orderNo="+orderNo+",tradeNo="+tradeNo+",sign="+sign+",code="+code);
        if(null==code||!"200".equals(code))
            return new Data(501,"支付失败");

        //通过返回的信息查出订单信息
        Orders orders = ordersService.getOrderByOrderNo(orderNo);
        if(orders.getDataStatus()==100){
            return new Data(100,"已支付");
        }
        SortedMap<String,Object> parameters = new TreeMap<String,Object>();
        parameters.put("orderNo",orderNo);
        parameters.put("orderAmt",orders.getTotalFee().toString());
        parameters.put("code",code);

        //验证请求信息与订单信息的合法性
        if(null!=sign&&sign.equals(WXSignUtils.createSign("utf-8",parameters))){
            ordersService.updateOrder(orderNo,100);
            userService.updateUserBalance(orders.getUserId(),orders.getTotalFee(),1,"用户充值",true);
            return new Data(200,"支付成功");
        }else{
            //参数不合法
            System.out.println("参数不合法 === "+orderNo+" === "+tradeNo+" === "+sign);
            return new Data(500,"参数不合法");
        }
    }
}
