package com.cliniqueDigitaleJEE.repository.Interfaces;

import com.cliniqueDigitaleJEE.model.User;

import java.util.List;
import java.util.UUID;

public interface UserRepository {
    User findById(UUID id);
    User findByEmail(String email);
    List<User> findAll();
    void save(User user);
    void update(User user);
    void delete(UUID id);
}
