package com.node.crm.workbench.service;

import com.node.crm.vo.PaginationVO;
import com.node.crm.workbench.domain.Activity;
import com.node.crm.workbench.domain.ActivityRemark;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface ActivityService {


    PaginationVO<Activity> pageList(Map<String, Object> map);

    Activity detail(String id);

    boolean save(Activity a);

    boolean delete(String[] ids);

    boolean saveRemark(ActivityRemark ar);

    List<ActivityRemark> getRemarkListByAid(String id);

    boolean deleteRemark(String id);

    boolean updateRemark(ActivityRemark ar);

    Map<String, Object> getUserListAndActivity(String id);

    boolean update(Activity a);
}
