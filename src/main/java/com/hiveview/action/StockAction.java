package com.hiveview.action;

import com.alibaba.fastjson.JSON;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
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
     * toCreateStockOrder:()
     * @param request
     * @author zhangsw
     * @return
     */
    @RequestMapping(value="toCreateStockOrder")
    @ResponseBody
    public String toCreateOrder(HttpServletRequest request) {
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("status",true);

        return JSON.toJSONString(map);
    }
}
