package com.node.crm.settings.service;

import com.node.crm.settings.domain.DicValue;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface DicService {


    Map<String, List<DicValue>> getAll();
}
