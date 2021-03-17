package com.node.crm.workbench.dao;

import com.node.crm.workbench.domain.TranHistory;

import java.util.List;

public interface TranHistoryDao {
    int save(TranHistory th);

    List<TranHistory> getHistoryListByTranId(String id);
}
