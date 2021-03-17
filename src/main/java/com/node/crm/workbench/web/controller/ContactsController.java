package com.node.crm.workbench.web.controller;

import com.node.crm.vo.PaginationVO;
import com.node.crm.workbench.domain.Contacts;
import com.node.crm.workbench.service.ContactsService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/workbench/contacts")
public class ContactsController {

    @Resource
    private ContactsService contactsService;

    @RequestMapping("/pageList.do")
    @ResponseBody
    public PaginationVO<Contacts> pageList(Contacts c, HttpServletRequest request) {

        // 第几页
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.valueOf(pageNoStr);

        //每页展现的记录数
        String pageSizeStr = request.getParameter("pageSize");
        int pageSize = Integer.valueOf(pageSizeStr);

        //计算出略过的记录数
        int skipCount = (pageNo - 1) * pageSize;

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("owner", c.getOwner());
        map.put("fullname", c.getFullname());
        map.put("customerId", c.getCustomerId());
        map.put("source", c.getSource());
        map.put("birth", c.getBirth());
        map.put("skipCount", skipCount);
        map.put("pageSize", pageSize);

        PaginationVO<Contacts> vo = contactsService.pageList(map);

        return vo;

    }

}
