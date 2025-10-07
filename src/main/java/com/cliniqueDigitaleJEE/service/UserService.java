package com.cliniqueDigitaleJEE.service;


import com.cliniqueDigitaleJEE.model.User;
import com.cliniqueDigitaleJEE.repository.Interfaces.UserRepository;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import org.mindrot.jbcrypt.BCrypt;

@Stateless
public class UserService {

    @Inject
    private UserRepository userRepository;

    @Transactional
    public void registerUser(User user) {
        // Business logic here
        if (userRepository.findByEmail(user.getEmail()) != null) {
            throw new IllegalArgumentException("Email already exists");
        }


        user.setPassword(hashPassword(user.getPassword()));


        userRepository.save(user);
    }

    public User authenticate(String email, String password) {
        User user = userRepository.findByEmail(email);
        if (user != null && checkPassword(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    private String hashPassword(String password) {

        return org.mindrot.jbcrypt.BCrypt.hashpw(password, org.mindrot.jbcrypt.BCrypt.gensalt());
    }

    private boolean checkPassword(String rawPassword, String hashedPassword) {

        return org.mindrot.jbcrypt.BCrypt.checkpw(rawPassword, hashedPassword);
    }
}
