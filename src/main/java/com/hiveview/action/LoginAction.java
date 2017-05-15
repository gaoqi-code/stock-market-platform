package com.hiveview.action;

import com.alibaba.fastjson.JSON;
import com.hiveview.contants.ContantKey;
import com.hiveview.entity.User;
import com.hiveview.entity.WX;
import com.hiveview.service.UserService;
import com.hiveview.util.HttpUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("login")
public class LoginAction {

	@Autowired
	private UserService userService;
	/**
	 * Created by gonglixun on 2016/12/13.
	 * 跳转到网站首页
	 */
	@RequestMapping(value = "/index")
	public String toIndex(HttpServletRequest request){
		return "view/index";
	}

	/**
	 * 后台中转页面，中转后，通过微信接口 获得 code,然后通过 code 获得 openid。
	 * @param req
	 * @param parentId
	 * @return
	 */
	@RequestMapping(value = "/{parentId}/{agentId}")
	public String toUser(HttpServletRequest req,@PathVariable("parentId")int parentId,@PathVariable("agentId")int agentId,String domainurl){
		StringBuffer url = new StringBuffer(ContantKey.url_1);
		url.append("appid").append("=").append(ContantKey.appID);

		url.append("&redirect_uri").append("=").append("http://").append(domainurl).append("/login/toIndex/").append(parentId).append("/").append(agentId).append(".html");
		url.append("&response_type").append("=").append("code");
		url.append("&scope").append("=").append("snsapi_base");//snsapi_userinfo
		url.append("&state").append("=").append("STATE");
		url.append("&connect_redirect").append("=").append("1#wechat_redirect");
		System.out.printf("weixin login url ===>>>" + url.toString());
		req.setAttribute("url",url.toString());
		return "webchat_login";
	}

	/**
	 * 跳到推广页面
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/toTuiG")
	public String toTuiG(HttpServletRequest req){
		Object obj = req.getSession().getAttribute("user");
		if(obj==null){
            /*  登录过期 ， 需要重登录  */
			return "view/default";
		}else{
			User user = (User) obj;
			return "redirect:/nologin/toTG/"+user.getId()+"/"+user.getLevel()+".html";
		}
	}

	@RequestMapping(value = "/toDefault")
	public String toDefault(){
        return "view/default";
    }


	@RequestMapping(value = "/toserver")
	public String toserver(HttpServletRequest req) {
		return "view/server";
	}

	/**
	 * 微信登录入口
	 * @param req
	 * @param parentId
	 * @param agentId
	 * @return
	 */
	@RequestMapping(value = "/toIndex/{parentId}/{agentId}")
	public String getCode(HttpServletRequest req,@PathVariable("parentId")int parentId,@PathVariable("agentId")int agentId){
		String code = req.getParameter("code");
		System.out.println(code);
		req.setAttribute("webchat code ======>>>",code);

		String reURL = "https://api.weixin.qq.com/sns/oauth2/access_token";
		String webchatInfo = reURL+"?appid="+ ContantKey.appID+"&secret"+"="+ContantKey.appsecret+"&code="+code+"&grant_type=authorization_code";
		String contentJSON = HttpUtils.sendGet(webchatInfo,null);
		System.out.println("user webchat info ======>>> "+contentJSON);

		/**
		 * 通过code获得用户的微信信息
		 */
		if(null!=contentJSON&&contentJSON.indexOf("errcode")==-1){
			WX wx = JSON.parseObject(contentJSON, WX.class);
			String openid = wx.getOpenid();
			String unionid = wx.getUnionid();
			req.setAttribute("openid",wx.getOpenid());
			//判断openid是否存在
			User user = userService.getUserByUnionid(unionid);
			if (user==null){//用户不存在
				user = userService.addUser(openid,unionid,parentId,agentId);
			}
			req.getSession().setAttribute("user",user);
			return "index";
		}
		return "error";
	}

	@RequestMapping(value = "/getAccessToken")
	public String getAccessToken(HttpServletRequest req) {
		String access_token = req.getParameter("access_token");
		String openid = req.getParameter("openid");
		System.out.println("--------------------------------------------------------");
		System.out.println(access_token);
		System.out.println(openid);
		System.out.println("--------------------------------------------------------");
		req.setAttribute("access_token", access_token);
		req.setAttribute("openid", openid);
		return "view/index";
	}


	@RequestMapping(value = "/toTest")
	public String toTest(HttpServletRequest req) {
		return "view/test";
	}


	@RequestMapping(value = "/toError/{code}")
	public String toError(HttpServletRequest req,@PathVariable("code")String code) {
		req.setAttribute("code",code);
		return "view/error/error_pay";
	}



}
