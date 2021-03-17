package com.node.crm.workbench.dao;

import com.node.crm.workbench.domain.Tran;

import java.util.List;
import java.util.Map;

public interface TranDao {
    int save(Tran t);

    int getTotalByCondition(Map<String, Object> map);

    List<Tran> getActivityListByCondition(Map<String, Object> map);

    Tran detail(String id);

    int changeStage(Tran t);

    int getTotal();

    List<Map<String, Object>> getCharts();
}
