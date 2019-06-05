package com.project.app.exceptions;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
class UserNameExistsExceptionResponse {
    private String username;
}
