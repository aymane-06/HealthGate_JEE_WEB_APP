package com.cliniqueDigitaleJEE.model;

import com.cliniqueDigitaleJEE.model.ENUMS.Role;
import jakarta.validation.constraints.Email;  // ✅ AJOUTEZ CETTE LIGNE
import jakarta.persistence.*;

import java.util.UUID;

@Entity
@Table(name = "users")
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    protected UUID id;
    @Column(nullable = true)
    protected String name;
    @Email(message = "Email should be valid")
    @Column(unique = true , nullable = false)
    protected String email;
    @Column(nullable = false)
    protected String password;
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    protected Role role;
    @Column(nullable = false, columnDefinition = "boolean default true")
    protected boolean active;

    public User() {}
    public User(String name, String email, String password, Role role) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.role = role;
        this.active = true;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}
