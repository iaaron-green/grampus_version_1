package com.project.app.entities;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Getter
@Setter
@EqualsAndHashCode(exclude = "user")
@Entity
@Table(name = "profiles")
@ToString
public class Profile {

    @Id
    private Long id;

    private String profilePicture;

    private Long likes;

    private Long dislikes;

    private String achievements;

    private String information;

    private String skills;

    @OneToOne
    private User user;

    @OneToMany(cascade = CascadeType.ALL,
            fetch = FetchType.LAZY, mappedBy = "profileRating")
    private List<Rating> ratings = new ArrayList<>();

    public Profile() {
    }

    public Profile(User user) {
        this.id = user.getId();
        this.likes = 0L;
        this.dislikes = 0L;
        this.user = user;
        this.user.setJobTitle(JobTitle.getById((int) (Math.random() * (10 - 1))+1));
    }
}
