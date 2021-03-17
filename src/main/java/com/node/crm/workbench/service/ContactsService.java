package com.node.crm.workbench.service;

import com.node.crm.vo.PaginationVO;
import com.node.crm.workbench.domain.Contacts;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public interface ContactsService {
    PaginationVO<Contacts> pageList(Map<String, Object> map);
}
