package com.project.app.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.BAD_REQUEST)
public class ProfileIdentifierException extends RuntimeException {

    public ProfileIdentifierException(String message) {
        super(message);
    }
}
