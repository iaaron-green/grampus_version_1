package com.project.app.entities;

import lombok.*;

@Getter
@Setter
@EqualsAndHashCode
@Builder
public class LikableProfile {

    private Long profileId;
    private String picture;
    private String fullName;
    private String jobTitle;
    private Boolean isAbleToLike;

}
