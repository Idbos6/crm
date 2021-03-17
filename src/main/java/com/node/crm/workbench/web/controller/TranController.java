package com.node.crm.workbench.web.controller;

import com.node.crm.settings.domain.User;
import com.node.crm.settings.service.UserService;
import com.node.crm.utils.DateTimeUtil;
import com.node.crm.utils.UUIDUtil;
import com.node.crm.vo.PaginationVO;
import com.node.crm.workbench.domain.*;
import com.node.crm.workbench.service.ClueService;
import com.node.crm.workbench.service.CustomerService;
import com.node.crm.workbench.service.TranService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/workbench/transaction")
public class TranController {

    @Resource
    private TranService ts;

    @Resource
    private UserService us;

    @Resource
    private CustomerService cs;

    @RequestMapping("/pageList.do")
    @ResponseBody
    public PaginationVO<Tran> pageList(Tran t, HttpServletRequest request) {

        // 第几页
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.valueOf(pageNoStr);

        //每页展现的记录数
        String pageSizeStr = request.getParameter("pageSize");
        int pageSize = Integer.valueOf(pageSizeStr);

        //计算出略过的记录数
        int skipCount = (pageNo - 1) * pageSize;

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("owner", t.getOwner());
        map.put("name", t.getName());
        map.put("customerId", t.getCustomerId());
        map.put("stage", t.getStage());
        map.put("type", t.getType());
        map.put("source", t.getSource());
        map.put("contactsId", t.getContactsId());
        map.put("skipCount", skipCount);
        map.put("pageSize", pageSize);

        PaginationVO<Tran> vo = ts.pageList(map);

        return vo;

    }

    @RequestMapping("/add.do")
    @ResponseBody
    public void add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Map<String, Object> map = new HashMap<>();

        List<User> uList = us.getUserList();

        request.setAttribute("uList", uList);
        request.getRequestDispatcher("/workbench/transaction/save.jsp").forward(request, response);

    }

    @RequestMapping("/getCustomerName.do")
    @ResponseBody
    public List<String> getCustomerName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String name = request.getParameter("name");

        List<String> sList = cs.getCustomerName(name);

        return sList;

    }

    @RequestMapping("/save.do")
    public void save(Tran t, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String customerName = request.getParameter("customerName");
        t.setId(UUIDUtil.getUUID());
        t.setCreateBy(((User)request.getSession().getAttribute("user")).getName());
        t.setCreateTime(DateTimeUtil.getSysTime());

        boolean flag = ts.save(t, customerName);

        if (flag) {

            // 如果添加交易成功，跳转到列表页
            response.sendRedirect(request.getContextPath() + "/workbench/transaction/index.jsp");

        }

    }

    @RequestMapping("/detail.do")
    public void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String id = request.getParameter("id");

        Tran t = ts.detail(id);

        // 处理可能性
        /*

            阶段
            阶段和可能性之间的对应关系

        */
        String stage = t.getStage();
        ServletContext application = request.getServletContext();
        Map<String, String> map = (Map<String, String>) application.getAttribute("pMap");
        String possibility = map.get(stage);
        t.setPossibility(possibility);

        request.setAttribute("t", t);
        request.getRequestDispatcher("/workbench/transaction/detail.jsp").forward(request, response);

    }

    @RequestMapping("/getHistoryListByTranId.do")
    @ResponseBody
    public List<TranHistory> getHistoryListByTranId(HttpServletRequest request) throws ServletException, IOException {

        String id = request.getParameter("id");
        List<TranHistory> thList = ts.getHistoryListByTranId(id);

        // 阶段和可能性之间的关系
        Map<String, String> pMap = (Map<String, String>) (request.getServletContext()).getAttribute("pMap");

        // 将交易历史遍历
        for (TranHistory th : thList) {

            // 根据每一条交易历史取出每一个阶段
            String stage = th.getStage();
            th.setPossibility(pMap.get(stage));

        }

        return thList;

    }

    @RequestMapping("/changeStage.do")
    @ResponseBody
    public Map<String, Object> changeStage(Tran t, HttpServletRequest request){

        Map<String, String> pMap = (Map<String, String>) request.getServletContext().getAttribute("pMap");
        t.setEditBy(((User)(request.getSession().getAttribute("user"))).getName());
        t.setEditTime(DateTimeUtil.getSysTime());
        t.setPossibility(pMap.get(t.getStage()));
        boolean flag = ts.changeStage(t);
        Map<String,Object> map = new HashMap<>();
        map.put("success", flag);
        map.put("t", t);
        return map;

    }

    @RequestMapping("/getCharts.do")
    @ResponseBody
    public Map<String, Object> getCharts(){

        /*

            业务层为我们返回
                total
                dataList

            通过map打包以上两项进行返回

        */
        Map<String, Object> map = ts.getCharts();
        return map;

    }



}
