package com.app.dao;

import com.app.model.User;
import java.util.Optional;

public interface UserDAO {
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    boolean create(User user);
    boolean update(User user);
}
