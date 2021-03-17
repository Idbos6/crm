package com.node.crm.workbench.dao;

import com.node.crm.workbench.domain.Contacts;

import java.util.List;
import java.util.Map;

public interface ContactsDao {
    int save(Contacts con);

    int getTotalByCondition(Map<String, Object> map);

    List<Contacts> getActivityListByCondition(Map<String, Object> map);
}
