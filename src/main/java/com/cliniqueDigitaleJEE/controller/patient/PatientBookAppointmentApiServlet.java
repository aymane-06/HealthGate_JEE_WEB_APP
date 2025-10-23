package com.cliniqueDigitaleJEE.controller.patient;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Map;
import java.util.UUID;

import javax.print.Doc;

import com.cliniqueDigitaleJEE.model.Appointment;
import com.cliniqueDigitaleJEE.model.Doctor;
import com.cliniqueDigitaleJEE.model.Patient;
import com.cliniqueDigitaleJEE.model.ENUMS.AppointmentStatus;
import com.cliniqueDigitaleJEE.dto.AppointmentRequestDTO;
import com.cliniqueDigitaleJEE.service.AppointmentService;
import com.cliniqueDigitaleJEE.service.DoctorService;
import com.cliniqueDigitaleJEE.service.PatientService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/api/patient/book-appointment")
public class PatientBookAppointmentApiServlet extends HttpServlet {

    @Inject
    private AppointmentService appointmentService;

    @Inject
    private DoctorService doctorService;

    @Inject
    private PatientService patientService;

    private static final ObjectMapper objectMapper = new ObjectMapper()
        .registerModule(new JavaTimeModule())
        .disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
        .configure(com.fasterxml.jackson.databind.DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.setContentType("application/json");

        AppointmentRequestDTO dto = objectMapper.readValue(req.getReader(), AppointmentRequestDTO.class);

        Doctor doctor = null;
        try {
            doctor = doctorService.findByIdWithAppointments(UUID.fromString(dto.doctorId));
        } catch (Exception e) {
            // Log and treat as not found
            System.err.println("Doctor lookup failed: " + e);
        }
        if (doctor == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            objectMapper.writeValue(resp.getWriter(), Map.of("status", "error", "message", "Invalid doctor ID"));
            return;
        }
        Patient patient = patientService.findById(UUID.fromString(dto.patientId));
        if (patient == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            objectMapper.writeValue(resp.getWriter(), Map.of("status", "error", "message", "Invalid patient ID"));
            return;
        }

        // Parse date string as LocalDateTime, then extract LocalDate (frontend sends yyyy-MM-ddTHH:mm:ss)
        LocalDateTime localDateTime = LocalDateTime.parse(dto.date);
        LocalDate localDate = localDateTime.toLocalDate();

        Boolean isBooked = doctorService.isSlotBooked(doctor, localDate, LocalTime.parse(dto.time));

        if (isBooked) {
            resp.setStatus(HttpServletResponse.SC_CONFLICT);
            objectMapper.writeValue(resp.getWriter(), Map.of("status", "error", "message", "Time slot already booked"));
            return;
        }
        Boolean hasBooked = appointmentService.hasPatientBookedAppointmentOnDate(patient,doctor ,localDate,java.time.LocalTime.parse(dto.time));
        if (hasBooked) {
            resp.setStatus(HttpServletResponse.SC_CONFLICT);
            objectMapper.writeValue(resp.getWriter(), Map.of("status", "error", "message", "Patient has already booked an appointment on this date with this doctor"));
            return;
        }
        Boolean hasASameTimeAppointment = patientService.hasPatientAppointmentAtDateTime(patient, localDate, java.time.LocalTime.parse(dto.time));
        if (hasASameTimeAppointment) {
            resp.setStatus(HttpServletResponse.SC_CONFLICT);
            objectMapper.writeValue(resp.getWriter(), Map.of("status", "error", "message", "Patient has another appointment at the same time"));
            return;
        }

        // Map DTO to Appointment entity (basic mapping, adjust as needed)
        Appointment appointment = new Appointment();
        appointment.setDate(localDate);
        LocalTime startTime = LocalTime.parse(dto.time);
        appointment.setStartTime(startTime);
        // Set endTime to 35 minutes after startTime
        appointment.setEndTime(startTime.plusMinutes(35));
        appointment.setRemarks(dto.remarks);
        appointment.setDoctor(doctor);
        appointment.setPatient(patient);
        appointment.setStatus(AppointmentStatus.PLANNED);
    
        try {
            appointmentService.bookAppointment(appointment);
            Map<String, Object> responseMap = Map.of(
                "status", "success",
                "appointmentId", appointment.getId(),
                "date", appointment.getDate().toString(),
                "startTime", appointment.getStartTime().toString(),
                "endTime", appointment.getEndTime().toString(),
                    "message", "Appointment booked successfully"
            );
            resp.setStatus(HttpServletResponse.SC_OK);
            objectMapper.writeValue(resp.getWriter(), responseMap);
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            objectMapper.writeValue(resp.getWriter(), Map.of("status", "error", "message", e.getMessage()));
        }








    }

}
