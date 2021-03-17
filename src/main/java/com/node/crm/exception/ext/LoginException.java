package com.node.crm.exception.ext;

import com.node.crm.exception.MyUserException;

// 表示当登录有异常，抛出LoginException
public class LoginException extends MyUserException {

    public LoginException() {
        super();
    }

    public LoginException(String message) {
        super(message);
    }
}
