package com.node.crm.workbench.dao;

import com.node.crm.workbench.domain.Activity;
import com.node.crm.workbench.domain.Clue;
import com.node.crm.workbench.domain.ClueActivityRelation;
import com.node.crm.workbench.domain.ClueRemark;

import java.util.List;
import java.util.Map;

public interface ClueDao {

    int getTotalByCondition(Map<String, Object> map);

    List<Clue> getActivityListByCondition(Map<String, Object> map);

    int save(Clue c);

    Clue detail(String id);

    int saveRemark(ClueRemark cr);

    Clue getClueById(String clueId);

    int update(Clue clue);

    int delete(String id);

    List<Activity> getActivityListByNameAndNotByClueId(Map<String, Object> map);

    int bund(ClueActivityRelation car);

    List<Activity> getActivityByCid(String cid);

    int unbund(ClueActivityRelation car);

    List<Activity> getActivityListByName(String aname);

    Clue getById(String clueId);
}
