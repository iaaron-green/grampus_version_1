package com.project.app.entities;

public enum JobTitle {
    CEO(1, "CEO"),
    CFO(2, "CFO"),
    OWNER(3, "owner"),
    DEVELOPER(4, "developer"),
    HR(5, "HR"),
    QA(6, "QA"),
    PM(7, "PM"),
    ADMIN(8, "sys admin"),
    ARCHITECT(9, "architect"),
    OFFICE_MANAGER(10, "office manager");

    private final Integer id;
    private final String value;

    JobTitle(Integer id, String value) {
        this.id = id;
        this.value = value;
    }

    public static String getById(Integer id) {
        for(JobTitle jobTitle : values()) {
            if(jobTitle.id.equals(id))
                return jobTitle.value;
        }
        return "";
    }

}
