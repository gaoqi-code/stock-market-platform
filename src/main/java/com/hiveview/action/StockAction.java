package com.hiveview.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

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
     * toIndex:().
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
}
