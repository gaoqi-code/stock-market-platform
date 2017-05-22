package com.hiveview.action;

import com.hiveview.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * 个人中心
 */
@Controller
@RequestMapping("member")
public class MemberAction {

	@Autowired
	private UserService userService;
	/**
	 * Created by gonglixun on 2016/12/13.
	 * 跳转到会员中心首页
	 */
	@RequestMapping(value = "/index")
	public String toIndex(HttpServletRequest request){
		return "member/index";
	}



	@RequestMapping(value = "/toMyOrder")
	public String toMyOrder(){
        return "member/my_order";
    }



}
