package com.cliniqueDigitaleJEE.model;

import com.cliniqueDigitaleJEE.model.ENUMS.Role;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "staff")
public class STAFF extends User{

    @Column(nullable = false)
    private String position;

    @Column(unique = true, nullable = false)
    private String employeeId;

    public STAFF() {}

    public STAFF(String name, String email, String password, String position, String employeeId) {
        super(name, email, password, Role.STAFF);
        this.position = position;
        this.employeeId = employeeId;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }
}
