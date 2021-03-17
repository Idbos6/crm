package com.node.crm.workbench.service;

import com.node.crm.vo.PaginationVO;
import com.node.crm.workbench.domain.Tran;
import com.node.crm.workbench.domain.TranHistory;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface TranService {
    PaginationVO<Tran> pageList(Map<String, Object> map);

    boolean save(Tran t, String customerName);

    Tran detail(String id);

    List<TranHistory> getHistoryListByTranId(String id);

    boolean changeStage(Tran t);

    Map<String, Object> getCharts();
}
