package com.node.crm.workbench.dao;

import com.node.crm.workbench.domain.Customer;

import java.util.List;
import java.util.Map;

public interface CustomerDao {
    Customer getCustomerByName(String company);

    int save(Customer cus);

    List<String> getCustomerName(String name);

    int getTotalByCondition(Map<String, Object> map);

    List<Customer> getActivityListByCondition(Map<String, Object> map);
}
