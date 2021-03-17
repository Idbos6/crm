package com.node.crm.settings.service;

import com.node.crm.exception.MyUserException;
import com.node.crm.settings.domain.User;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface UserService {

    User login(String loginAct, String loginPwd, String ip) throws MyUserException;

    List<User> getUserList();

}
