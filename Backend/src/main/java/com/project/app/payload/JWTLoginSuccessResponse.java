package com.project.app.payload;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class JWTLoginSuccessResponse {
    private boolean success;
    private String token;

    public JWTLoginSuccessResponse(boolean success, String token) {
        this.success = success;
        this.token = token;
    }
}
