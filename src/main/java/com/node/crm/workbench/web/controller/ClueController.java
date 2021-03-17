package com.node.crm.workbench.web.controller;

import com.node.crm.settings.domain.User;
import com.node.crm.utils.DateTimeUtil;
import com.node.crm.utils.UUIDUtil;
import com.node.crm.vo.PaginationVO;
import com.node.crm.workbench.domain.*;
import com.node.crm.workbench.service.ClueService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/workbench/clue")
public class ClueController {

    @Resource
    private ClueService cs;

    @RequestMapping("/pageList.do")
    @ResponseBody
    public PaginationVO<Clue> pageList(Clue c, HttpServletRequest request) {

        // 第几页
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.valueOf(pageNoStr);

        //每页展现的记录数
        String pageSizeStr = request.getParameter("pageSize");
        int pageSize = Integer.valueOf(pageSizeStr);

        //计算出略过的记录数
        int skipCount = (pageNo - 1) * pageSize;

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("fullname", c.getFullname());
        map.put("company", c.getCompany());
        map.put("phone", c.getPhone());
        map.put("mphone", c.getMphone());
        map.put("source", c.getSource());
        map.put("owner", c.getOwner());
        map.put("state", c.getState());
        map.put("skipCount", skipCount);
        map.put("pageSize", pageSize);

        PaginationVO<Clue> vo = cs.pageList(map);

        return vo;

    }

    @RequestMapping("/save.do")
    @ResponseBody
    public Map<String, Object> save(Clue c, HttpServletRequest request) {

        c.setId(UUIDUtil.getUUID());
        c.setCreateTime(DateTimeUtil.getSysTime());
        c.setCreateBy(((User)request.getSession().getAttribute("user")).getName());
        boolean flag = cs.save(c);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);

        return map;

    }

    @RequestMapping("/delete.do")
    @ResponseBody
    public Map<String, Object> delete(HttpServletRequest request) {

        String[] ids = request.getParameterValues("id");
        boolean flag = cs.delete(ids);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);

        return map;

    }

    @RequestMapping("/detail.do")
    @ResponseBody
    public ModelAndView detail(HttpServletRequest request) {

        String id = request.getParameter("id");

        Clue c = cs.detail(id);

        ModelAndView mv = new ModelAndView();
        mv.addObject("c", c);
        mv.setViewName("forward:/workbench/clue/detail.jsp");

        return mv;

    }

    @RequestMapping("/saveRemark.do")
    @ResponseBody
    public Map<String, Object> saveRemark(HttpServletRequest request, ClueRemark cr) {

        cr.setCreateBy(((User)request.getSession().getAttribute("user")).getName());
        cr.setCreateTime(DateTimeUtil.getSysTime());
        cr.setId(UUIDUtil.getUUID());
        cr.setEditFlag("0");
        boolean flag = cs.saveRemark(cr);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        Clue c = cs.getClueById(cr.getClueId());
        map.put("cr",cr);
        map.put("c",c);
        return map;

    }

    @RequestMapping("/getRemarkListByCid.do")
    @ResponseBody
    public List<ClueRemark> getRemarkListByCid(HttpServletRequest request) {

        List<ClueRemark> crList = cs.getRemarkListByCid(request.getParameter("clueId"));
        return crList;

    }

    @RequestMapping("/getUserListAndClue.do")
    @ResponseBody
    public Map<String, Object> getUserListAndActivity(HttpServletRequest request) {

        String id = request.getParameter("id");
        Map<String, Object> map = cs.getUserListAndClue(id);
        return map;

    }

    @RequestMapping("/update.do")
    @ResponseBody
    public Map<String, Object> update(Clue clue, HttpSession session) {

        Map<String, Object> map = new HashMap<>();
        clue.setEditTime(DateTimeUtil.getSysTime());
        User user = (User) session.getAttribute("user");
        String editBy = user.getName();
        clue.setEditBy(editBy);
        boolean flag = cs.update(clue);
        map.put("success", flag);
        return map;

    }

    @RequestMapping("/getActivityListByName.do")
    @ResponseBody
    public List<Activity> getActivityListByName(HttpServletRequest request) {

        String aname = request.getParameter("aname");
        List<Activity> list = cs.getActivityListByName(aname);
        return list;

    }

    @RequestMapping("/getActivityListByNameAndNotByClueId.do")
    @ResponseBody
    public List<Activity> getActivityListByNameAndNotByClueId(HttpServletRequest request) {

        String aname = request.getParameter("aname");
        String clueId = request.getParameter("clueId");
        List<Activity> list = cs.getActivityListByNameAndNotByClueId(aname, clueId);
        return list;

    }

    @RequestMapping("/bund.do")
    @ResponseBody
    public Map<String, Object> bund(HttpServletRequest request) {

        String cid = request.getParameter("cid");
        String[] aid = request.getParameterValues("aid");

        Map<String, Object> map = new HashMap<>();
        boolean flag = cs.bund(cid, aid);
        map.put("success", flag);
        return map;

    }

    @RequestMapping("/unbund.do")
    @ResponseBody
    public Map<String, Object> unbund(HttpServletRequest request) {

        String aid = request.getParameter("aid");
        String cid = request.getParameter("cid");

        Map<String, Object> map = new HashMap<>();
        ClueActivityRelation car = new ClueActivityRelation();
        car.setActivityId(aid);
        car.setClueId(cid);
        boolean flag = cs.unbund(car);
        map.put("success", flag);
        return map;

    }

    @RequestMapping("/getActivityByCid.do")
    @ResponseBody
    public List<Activity> getActivityByCid(HttpServletRequest request) {

        String cid = request.getParameter("clueId");
        List<Activity> list = cs.getActivityByCid(cid);
        return list;

    }

    @RequestMapping("/convert.do")
    @ResponseBody
    public ModelAndView convert(HttpServletRequest request) {

        String clueId = request.getParameter("clueId");

        // 接受是否需要创建交易的标记
        String flag = request.getParameter("flag");
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        Tran t = null;

        if ("a".equals(flag)) {

            t = new Tran();

            // 接收交易表单中的参数

            String money = request.getParameter("money");
            String name = request.getParameter("name");
            String expectedDate = request.getParameter("expectedDate");
            String stage = request.getParameter("stage");
            String activityId = request.getParameter("activityId");
            String id = UUIDUtil.getUUID();
            String createTime = DateTimeUtil.getSysTime();

            t.setId(id);
            t.setMoney(money);
            t.setName(name);
            t.setExpectedDate(expectedDate);
            t.setStage(stage);
            t.setActivityId(activityId);
            t.setCreateTime(createTime);
            t.setCreateBy(createBy);

        }

        /*

            为业务层传递的参数：

            1.必须传递的参数clueId，有了这个clueId之后我们才知道要转换哪条记录
            2.必须传递的参数t，因为在线索转换的过程中，有可能会临时创建一笔交易（业务层接收的t也有可能是个null）

        */
        boolean flag1 = cs.convert(clueId, t, createBy);
        ModelAndView mv = new ModelAndView();

        if (flag1 == true) {

            mv.setViewName("redirect:/workbench/clue/index.jsp");

        }

        return mv;

    }

}
