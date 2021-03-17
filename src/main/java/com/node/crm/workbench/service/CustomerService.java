package com.node.crm.workbench.service;

import com.node.crm.vo.PaginationVO;
import com.node.crm.workbench.domain.Customer;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface CustomerService {
    List<String> getCustomerName(String name);

    PaginationVO<Customer> pageList(Map<String, Object> map);
}
