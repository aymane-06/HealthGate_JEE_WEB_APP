package com.cliniqueDigitaleJEE.service;


import com.cliniqueDigitaleJEE.model.User;
import com.cliniqueDigitaleJEE.repository.Interfaces.UserRepository;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import org.mindrot.jbcrypt.BCrypt;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Stateless
public class UserService {

    @Inject
    private UserRepository userRepository;

    @Transactional
    public boolean registerUser(User user) {
        // Business logic here
        if (userRepository.findByEmail(user.getEmail()) != null) {
            throw new IllegalArgumentException("Email already exists");
        }


        user.setPassword(hashPassword(user.getPassword()));


        userRepository.save(user);
        return true;
    }

    public User authenticate(String email, String password) {

        if (email == null || password == null) {
            return null;
        }


        User user = userRepository.findByEmail(email);
        if (user != null && checkPassword(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    private String hashPassword(String password) {

        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    private boolean checkPassword(String rawPassword, String hashedPassword) {

        return BCrypt.checkpw(rawPassword, hashedPassword);
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User getUserById(String id) {
        try {
            UUID userId = UUID.fromString(id);
            return userRepository.findById(userId);
        } catch (IllegalArgumentException e) {
            return null;
        }
    }

    @Transactional
    public void updateUser(User user) {
        if (user == null || user.getId() == null) {
            throw new IllegalArgumentException("User or user ID cannot be null");
        }
        userRepository.update(user);
    }

    @Transactional
    public void deleteUser(String userId) {
        if (userId == null || userId.trim().isEmpty()) {
            throw new IllegalArgumentException("User ID cannot be null or empty");
        }
        try {
            UUID id = UUID.fromString(userId);
            userRepository.delete(id);
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("Invalid user ID format: " + userId);
        }
    }

}
