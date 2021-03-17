package com.node.crm.workbench.web.controller;

import com.node.crm.vo.PaginationVO;
import com.node.crm.workbench.domain.Customer;
import com.node.crm.workbench.service.CustomerService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/workbench/customer")
public class CustomerController {

    @Resource
    private CustomerService customerService;


    @RequestMapping("/pageList.do")
    @ResponseBody
    public PaginationVO<Customer> pageList(Customer c, HttpServletRequest request) {

        // 第几页
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.valueOf(pageNoStr);

        //每页展现的记录数
        String pageSizeStr = request.getParameter("pageSize");
        int pageSize = Integer.valueOf(pageSizeStr);

        //计算出略过的记录数
        int skipCount = (pageNo - 1) * pageSize;

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("name", c.getName());
        map.put("owner", c.getOwner());
        map.put("phone", c.getPhone());
        map.put("website", c.getWebsite());
        map.put("skipCount", skipCount);
        map.put("pageSize", pageSize);

        PaginationVO<Customer> vo = customerService.pageList(map);

        return vo;

    }

}
