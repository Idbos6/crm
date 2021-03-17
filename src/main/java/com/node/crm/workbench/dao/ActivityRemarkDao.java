package com.node.crm.workbench.dao;

import com.node.crm.workbench.domain.ActivityRemark;

import java.util.List;

public interface ActivityRemarkDao {

    int saveRemark(ActivityRemark ar);

    int getCountByAids(String[] ids);

    int deleteByAids(String[] ids);

    List<ActivityRemark> getRemarkListByAid(String id);

    int deleteById(String id);

    int updateRemark(ActivityRemark ar);
}
