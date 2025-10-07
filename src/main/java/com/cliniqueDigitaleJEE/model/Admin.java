package com.cliniqueDigitaleJEE.model;

import com.cliniqueDigitaleJEE.model.ENUMS.Role;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "admins")
public class Admin extends User{

    public Admin() {}

    public Admin(String name, String email, String password) {
        super(name, email, password, Role.ADMIN);
    }
}
