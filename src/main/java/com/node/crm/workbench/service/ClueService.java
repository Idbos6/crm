package com.node.crm.workbench.service;

import com.node.crm.vo.PaginationVO;
import com.node.crm.workbench.domain.*;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface ClueService {

    PaginationVO<Clue> pageList(Map<String, Object> map);

    boolean save(Clue c);

    boolean delete(String[] ids);

    Clue detail(String id);

    boolean saveRemark(ClueRemark cr);

    Clue getClueById(String clueId);

    List<ClueRemark> getRemarkListByCid(String clueId);

    Map<String, Object> getUserListAndClue(String id);

    boolean update(Clue clue);

    List<Activity> getActivityListByNameAndNotByClueId(String aname, String clueId);

    boolean bund(String cid, String[] aid);

    List<Activity> getActivityByCid(String cid);

    boolean unbund(ClueActivityRelation car);

    List<Activity> getActivityListByName(String aname);

    boolean convert(String clueId, Tran t, String createBy);
}
