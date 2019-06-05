package com.project.app.repositories;

import com.project.app.entities.Rating;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RatingRepository extends CrudRepository<Rating, Long> {

    Optional<Rating> findById(Long profileId);
}
