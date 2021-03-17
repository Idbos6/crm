package com.node.crm.workbench.dao;

import com.node.crm.workbench.domain.ClueRemark;

import java.util.List;

public interface ClueRemarkDao {

    int saveRemark(ClueRemark cr);

    List<ClueRemark> getRemarkListByCid(String clueId);

    List<ClueRemark> getListByClueId(String clueId);

    int delete(ClueRemark clueRemark);
}
