package com.project.app.exceptions;

public class ProfileNotFoundExceptionResponse {

    private String profileNotFound;

    public ProfileNotFoundExceptionResponse(String profileNotFound) {
        this.profileNotFound = profileNotFound;
    }

    public String getProjectNotFound() {
        return profileNotFound;
    }

    public void setProjectNotFound(String profileNotFound) {
        this.profileNotFound = profileNotFound;
    }
}
