package com.node.crm.workbench.service.impl;

import com.node.crm.vo.PaginationVO;
import com.node.crm.workbench.dao.ContactsDao;
import com.node.crm.workbench.domain.Contacts;
import com.node.crm.workbench.domain.Customer;
import com.node.crm.workbench.service.ContactsService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class ContactsServiceImpl implements ContactsService {

    @Resource
    private ContactsDao contactsDao;

    @Override
    public PaginationVO<Contacts> pageList(Map<String, Object> map) {
        //取得total
        int total = contactsDao.getTotalByCondition(map);

        //取得dataList
        List<Contacts> dataList = contactsDao.getActivityListByCondition(map);

        //创建一个vo对象，将total和dataList封装到vo中
        PaginationVO<Contacts> vo = new PaginationVO<>();
        vo.setTotal(total);
        vo.setDataList(dataList);

        //将vo返回
        return vo;
    }
}
