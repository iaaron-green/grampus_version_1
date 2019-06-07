package com.project.app.entities;

import lombok.*;

import java.util.HashMap;
import java.util.Map;

@EqualsAndHashCode
@Getter
@Setter
public class ProfileWithAchievements {
    private Profile profile;
    private Map<String, Long> achievements=new HashMap<>();
}