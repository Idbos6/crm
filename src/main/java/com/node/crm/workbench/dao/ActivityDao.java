package com.node.crm.workbench.dao;

import com.node.crm.workbench.domain.Activity;

import java.util.List;
import java.util.Map;

public interface ActivityDao {


    int getTotalByCondition(Map<String, Object> map);

    List<Activity> getActivityListByCondition(Map<String, Object> map);

    Activity detail(String id);

    int save(Activity a);

    int delete(String[] ids);

    Activity getById(String id);

    int update(Activity a);
}
