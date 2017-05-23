package com.hiveview.action;

import com.hiveview.contants.ContantType;
import com.hiveview.entity.DepositorsOrders;
import com.hiveview.entity.StockOrder;
import com.hiveview.entity.User;
import com.hiveview.entity.vo.Data;
import com.hiveview.service.DepositorsOrdersService;
import com.hiveview.service.StockOrderService;
import com.hiveview.service.UserService;
import com.hiveview.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 个人中心
 */
@Controller
@RequestMapping("member")
public class MemberAction extends CommonAction{

	@Autowired
	private UserService userService;

	@Autowired
	private StockOrderService stockOrderService;

	@Autowired
	private DepositorsOrdersService depositorsOrdersService;
	/**
	 * Created by gonglixun on 2016/12/13.
	 * 跳转到会员中心首页
	 */
	@RequestMapping(value = "/index")
	public ModelAndView toIndex(HttpServletRequest request, ModelAndView mav){

		mav.setViewName("member/trade_detail");
		return mav;
	}



	/**
	 * toMyOrder:(查询持仓记录)
	 * @param request
	 * @param mav
	 * @author zhangsw
	 * @return
	 */
	@RequestMapping(value="toMyOrder")
	public ModelAndView toMyOrders(HttpServletRequest request, ModelAndView mav) {
		int userId=getUserId(request);
		List<StockOrder> orders=stockOrderService.getStockOrdersByUserId(41);
		mav.getModel().put("orders",orders);
		mav.setViewName("member/my_order");
		return mav;
	}

	/**
	 * toApplayDepositors:(申请提现)
	 * @param request
	 * @param mav
	 * @author zhangsw
	 * @return
	 */
	@RequestMapping(value="toApplayDepositors")
	public ModelAndView toApplayDepositors(HttpServletRequest request, ModelAndView mav) {
		int userId=getUserId(request);
		User user=userService.getUserById(41);
		mav.getModel().put("user",user);

		mav.setViewName("member/depositors_index");
		return mav;
	}

	/**
	 * toMyOrder:(保存提现记录)
	 * @param request
	 * @author zhangsw
	 * @return
	 */
	@RequestMapping(value="toSaveDepositors")
	@ResponseBody
	public Data toSaveDepositors(HttpServletRequest request,DepositorsOrders applay) {
		Data data=new Data();
		int userId=getUserId(request);

		User user=userService.getUserById(41);
		BigDecimal balance=user.getBalance();
		BigDecimal amount=applay.getAmount();

		if(amount==null||amount.toString().equals("0.00")){
			data.setCode(0);
			data.setMsg("请输入金额！");
			return data;
		}

		if(balance.compareTo(amount)==-1){
			data.setCode(0);
			data.setMsg("余额不足！");
			return data;
		}

		try {
			//冻结提现金额 不能用于交易
			userService.updateUserBalance(user.getId(),amount, ContantType.balanceLogType_7,"提现扣除",false);

			String orderNo = DateUtil.getOrderNum() + DateUtil.getThree();
			applay.setOrderNo(orderNo);
			applay.setUserId(user.getId());
			applay.setAddTime(new Date());
			applay.setUpdateTime(new Date());
			applay.setOrderStatus(DepositorsOrders.STATUS_AUDITING);
			depositorsOrdersService.save(applay);
			data.setCode(1);
			data.setMsg("申请成功！");

		}catch (Exception e){
			e.printStackTrace();
			data.setCode(0);
			data.setMsg("申请失败！");
			return data;
		}

		return data;
	}
}
