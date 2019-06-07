package com.project.app.services;

import com.project.app.entities.Profile;
import com.project.app.entities.Rating;
import com.project.app.repositories.ProfileRepository;
import com.project.app.repositories.RatingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import static com.project.app.entities.ProfileNegativeRating.*;
import static com.project.app.entities.ProfilePositiveRating.*;

@Service
public class RatingService {

    private RatingRepository ratingRepository;
    private ProfileRepository profileRepository;

    @Autowired
    public RatingService(RatingRepository ratingRepository, ProfileRepository profileRepository) {
        this.ratingRepository = ratingRepository;
        this.profileRepository = profileRepository;
    }

    public Rating addLike(Long profileIdentifier, Rating updatedRating, String userName){

        Profile profile = profileRepository.findById(profileIdentifier).get();
        updatedRating.setProfileRating(profile);

            if (!userName.equals(profile.getUser().getUsername())) {

                addLikeAndCheckForLikeType(updatedRating, userName, profile);
            }

        return ratingRepository.save(updatedRating);
    }

    private void addLikeAndCheckForLikeType(Rating updatedRating, String userName, Profile profile) {
        Long profileLike = 0L;

        profileLike++;
        profile.setLikes(profileLike);
        updatedRating.setRatingSourceUsername(userName);

        if(updatedRating.getRatingType().equals("like_best_looker")){
            updatedRating.setRatingType(BEST_LOOKER.toString().toLowerCase());
        }
        if (updatedRating.getRatingType().equals("like_super_worker")){
            updatedRating.setRatingType(SUPER_WORKER.toString().toLowerCase());
        }
        if (updatedRating.getRatingType().equals("like_extrovert")){
            updatedRating.setRatingType(EXTROVERT.toString().toLowerCase());
        }
    }

    public Rating addDislike(Long profileIdentifier, Rating updatedRating, String userName){


        Profile profile =  profileRepository.findById(profileIdentifier).get();
        updatedRating.setProfileRating(profile);

        if (!userName.equals(profile.getUser().getUsername())) {
            addDislikeAndCheckForDislikeType(updatedRating, userName, profile);
        }

        return ratingRepository.save(updatedRating);
    }

    private void addDislikeAndCheckForDislikeType(Rating updatedRating, String userName, Profile profile) {
        Long profileDislike = 0L;

        profileDislike++;
        profile.setDislikes(profileDislike);
        updatedRating.setRatingSourceUsername(userName);

        if(updatedRating.getRatingType().equals("dislike_untidy")){
            updatedRating.setRatingType(UNTIDY.toString().toLowerCase());
        }
        if (updatedRating.getRatingType().equals("dislike_deadliner")){
            updatedRating.setRatingType(DEADLINER.toString().toLowerCase());
        }
        if (updatedRating.getRatingType().equals("dislike_introvert")){
            updatedRating.setRatingType(INTROVERT.toString().toLowerCase());
        }
    }
}
