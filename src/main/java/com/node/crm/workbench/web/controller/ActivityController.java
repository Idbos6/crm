package com.node.crm.workbench.web.controller;

import com.node.crm.settings.domain.User;
import com.node.crm.settings.service.UserService;
import com.node.crm.utils.DateTimeUtil;
import com.node.crm.utils.UUIDUtil;
import com.node.crm.vo.PaginationVO;
import com.node.crm.workbench.domain.Activity;
import com.node.crm.workbench.domain.ActivityRemark;
import com.node.crm.workbench.service.ActivityService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/workbench/activity")
public class ActivityController {

    @Resource
    private ActivityService as;

    @Resource
    private UserService us;


    @RequestMapping("/getUserList.do")
    @ResponseBody
    public List<User> getUserList() {

        List<User> users = us.getUserList();
        return users;

    }

    @RequestMapping("/pageList.do")
    @ResponseBody
    public PaginationVO<Activity> pageList(Activity a, HttpServletRequest request) {

        // 第几页
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.valueOf(pageNoStr);

        //每页展现的记录数
        String pageSizeStr = request.getParameter("pageSize");
        int pageSize = Integer.valueOf(pageSizeStr);

        //计算出略过的记录数
        int skipCount = (pageNo - 1) * pageSize;

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("name", a.getName());
        map.put("owner", a.getOwner());
        map.put("startDate", a.getStartDate());
        map.put("endDate", a.getEndDate());
        map.put("skipCount", skipCount);
        map.put("pageSize", pageSize);
        /*

            前端要： 市场活动信息列表
                    查询的总条数

                    业务层拿到了以上两项信息之后，如果做返回
                    map
                    map.put("dataList",dataList)
                    map.put("total",total)
                    PrintJSON map --> json
                    {"total":100,"dataList":[{市场活动1},{2},{3}]}


                    vo
                    PaginationVO<T>
                        private int total;
                        private List<T> dataList;

                    PaginationVO<Activity> vo = new PaginationVO<>;
                    vo.setTotal(total);
                    vo.setDataList(dataList);
                    PrintJSON vo --> json
                    {"total":100,"dataList":[{市场活动1},{2},{3}]}


                    将来分页查询，每个模块都有，所以我们选择使用一个通用vo，操作起来比较方便




         */
        PaginationVO<Activity> vo = as.pageList(map);

        //vo--> {"total":100,"dataList":[{市场活动1},{2},{3}]}
        return vo;

    }

    @RequestMapping("/detail.do")
    @ResponseBody
    public ModelAndView detail(HttpServletRequest request) {

        String id = request.getParameter("id");

        Activity a = as.detail(id);

        ModelAndView mv = new ModelAndView();
        mv.addObject("a", a);
        mv.setViewName("forward:/workbench/activity/detail.jsp");

        return mv;

    }


    @RequestMapping("/save.do")
    @ResponseBody
    public Map<String, Object> save(Activity a, HttpServletRequest request) {

        a.setId(UUIDUtil.getUUID());
        a.setCreateTime(DateTimeUtil.getSysTime());
        a.setCreateBy(((User) request.getSession().getAttribute("user")).getName());

        boolean flag = as.save(a);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);

        return map;

    }

    @RequestMapping("/saveRemark.do")
    @ResponseBody
    public Map<String, Object> saveRemark(HttpServletRequest request) {

        String noteContent = request.getParameter("noteContent");
        String activityId = request.getParameter("activityId");
        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        String createBy = ((User) request.getSession().getAttribute("user")).getName();
        String editFlag = "0";

        ActivityRemark ar = new ActivityRemark();
        ar.setId(id);
        ar.setNoteContent(noteContent);
        ar.setActivityId(activityId);
        ar.setCreateBy(createBy);
        ar.setCreateTime(createTime);
        ar.setEditFlag(editFlag);

        boolean flag = as.saveRemark(ar);

        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        map.put("ar", ar);

        return map;

    }

    @RequestMapping("/delete.do")
    @ResponseBody
    public Map<String, Object> delete(HttpServletRequest request) {

        String ids[] = request.getParameterValues("id");
        boolean flag = as.delete(ids);

        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        return map;

    }

    @RequestMapping("/getRemarkListByAid.do")
    @ResponseBody
    public List<ActivityRemark> getRemarkListByAid(HttpServletRequest request) {

        String id = request.getParameter("activityId");
        List<ActivityRemark> list = as.getRemarkListByAid(id);

        return list;

    }

    @RequestMapping("/deleteRemark.do")
    @ResponseBody
    public Map<String, Object> deleteRemark(HttpServletRequest request) {

        String id = request.getParameter("id");
        boolean flag = as.deleteRemark(id);

        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        return map;

    }

    @RequestMapping("/updateRemark.do")
    @ResponseBody
    public Map<String, Object> updateRemark(HttpServletRequest request) {

        String id = request.getParameter("id");
        String noteContent = request.getParameter("noteContent");
        String editTime = DateTimeUtil.getSysTime();
        String editBy = ((User) request.getSession().getAttribute("user")).getName();
        String editFlag = "1";

        ActivityRemark ar = new ActivityRemark();

        ar.setId(id);
        ar.setNoteContent(noteContent);
        ar.setEditFlag(editFlag);
        ar.setEditBy(editBy);
        ar.setEditTime(editTime);

        boolean flag = as.updateRemark(ar);

        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        map.put("ar", ar);
        return map;

    }


    @RequestMapping("/getUserListAndActivity.do")
    @ResponseBody
    public Map<String, Object> getUserListAndActivity(HttpServletRequest request) {

        String id = request.getParameter("id");
        Map<String, Object> map = as.getUserListAndActivity(id);
        return map;

    }

    @RequestMapping("/update.do")
    @ResponseBody
    public Map<String, Object> update(Activity a, HttpServletRequest request) {

        //修改时间：当前系统时间
        a.setEditTime(DateTimeUtil.getSysTime());
        //修改人：当前登录用户
        a.setEditBy(((User)request.getSession().getAttribute("user")).getName());

        boolean flag = as.update(a);

        Map<String,Object> map = new HashMap<>();
        map.put("success",flag);
        return map;

    }

}
