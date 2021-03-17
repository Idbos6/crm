package com.node.crm.settings.web.controller;

import com.node.crm.exception.MyUserException;
import com.node.crm.settings.domain.User;
import com.node.crm.settings.service.UserService;
import com.node.crm.utils.MD5Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService us;

    @ResponseBody
    @RequestMapping("/login.do")
    public Map<String, Object> login(HttpServletRequest request) throws MyUserException {

        String loginAct = request.getParameter("loginAct");
        String loginPwd = request.getParameter("loginPwd");
        // 将密码的明文形式转换为MD5的密文形式
        loginPwd = MD5Util.getMD5(loginPwd);

        // 接收浏览器端的ip地址
        String ip = request.getRemoteAddr();
        Map<String, Object> map = new HashMap<>();

        User user = us.login(loginAct, loginPwd, ip);

        request.getSession().setAttribute("user", user);

        // 如果程序执行到此处，说明业务层没有为controller抛出任何的异常
        // 表示登录成功
            /*

                {"success":true}

             */
        map.put("success", true);

        return map;

    }


}
