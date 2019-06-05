package com.project.app.repositories;

import com.project.app.entities.Profile;
import com.project.app.entities.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ProfileRepository extends CrudRepository<Profile, Long> {
    Optional<Profile> findById(Long profileId);

    @Override
    Iterable<Profile> findAll();

}
