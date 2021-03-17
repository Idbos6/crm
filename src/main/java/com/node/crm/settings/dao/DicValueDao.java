package com.node.crm.settings.dao;

import com.node.crm.settings.domain.DicValue;

import java.util.List;

public interface DicValueDao {

    List<DicValue> getListByCode(String code);

}
