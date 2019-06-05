package com.project.app.controllers;

import com.project.app.entities.Profile;
import com.project.app.entities.User;
import com.project.app.services.ProfileService;
import com.project.app.services.UserService;
import com.project.app.services.ValidationErrorService;
import com.project.app.validators.UserValidator;
import com.project.app.payload.LoginRequest;
import com.project.app.payload.JWTLoginSuccessResponse;
import com.project.app.configs.JwtTokenProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

import static com.project.app.configs.SecurityConstants.TOKEN_PREFIX;

@RestController
@CrossOrigin
@RequestMapping("/api/users")
public class UserController {

    private ValidationErrorService validationErrorService;
    private UserService userService;
    private ProfileService profileService;
    private UserValidator userValidator;
    private JwtTokenProvider tokenProvider;
    private AuthenticationManager authenticationManager;

    @Autowired
    public UserController(ValidationErrorService validationErrorService, UserService userService,
                          ProfileService profileService, UserValidator userValidator,
                          JwtTokenProvider tokenProvider, AuthenticationManager authenticationManager) {
        this.validationErrorService = validationErrorService;
        this.userService = userService;
        this.profileService = profileService;
        this.userValidator = userValidator;
        this.tokenProvider = tokenProvider;
        this.authenticationManager = authenticationManager;
    }

    @PostMapping("/login")
    public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginRequest loginRequest, BindingResult result){
        ResponseEntity<?> errorMap = validationErrorService.mapValidationService(result);
        if(errorMap != null) return errorMap;

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequest.getUsername(),
                        loginRequest.getPassword()
                )
        );

        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = TOKEN_PREFIX +  tokenProvider.generateToken(authentication);

        return ResponseEntity.ok(new JWTLoginSuccessResponse(true, jwt));
    }

    @PostMapping("/register")
    public ResponseEntity<?> registerUser(@Valid @RequestBody User user, BindingResult result){
        userValidator.validate(user,result);

        ResponseEntity<?> errorMap = validationErrorService.mapValidationService(result);
        if(errorMap != null)return errorMap;

        User newUser = userService.saveUser(user);
        Profile newProfile = profileService.saveProfile(new Profile(newUser));
        return  new ResponseEntity<>(newUser, HttpStatus.CREATED);
    }
}
