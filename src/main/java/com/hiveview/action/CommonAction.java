package com.hiveview.action;

import com.hiveview.entity.User;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by zhangsw on 2017/5/20.
 */
public class CommonAction {

    public int getUserId(HttpServletRequest request) {
        User member = (User) request.getSession().getAttribute("user");
        Integer memberId = null;
        if(member != null) {
            memberId = member.getId();
        }

        return memberId != null?memberId:-1;
    }
}
