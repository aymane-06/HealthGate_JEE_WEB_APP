package com.cliniqueDigitaleJEE.repository.Interfaces;

import java.util.List;

import com.cliniqueDigitaleJEE.model.Appointment;

public interface AppointmentRepository {
    void bookAppointment(Appointment appointment);
    Appointment getAppointmentById(String appointmentId);
    List<Appointment> getAllAppointments();
    void updateAppointment(Appointment appointment);
    void deleteAppointment(String appointmentId);

}
