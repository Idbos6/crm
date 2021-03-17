package com.node.crm.workbench.service.impl;

import com.node.crm.vo.PaginationVO;
import com.node.crm.workbench.dao.CustomerDao;
import com.node.crm.workbench.domain.Customer;
import com.node.crm.workbench.service.CustomerService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Resource
    private CustomerDao customerDao;

    @Override
    public List<String> getCustomerName(String name) {

        List<String> sList = customerDao.getCustomerName(name);

        return sList;
    }

    @Override
    public PaginationVO<Customer> pageList(Map<String, Object> map) {

        //取得total
        int total = customerDao.getTotalByCondition(map);

        //取得dataList
        List<Customer> dataList = customerDao.getActivityListByCondition(map);

        //创建一个vo对象，将total和dataList封装到vo中
        PaginationVO<Customer> vo = new PaginationVO<>();
        vo.setTotal(total);
        vo.setDataList(dataList);

        //将vo返回
        return vo;
    }
}
