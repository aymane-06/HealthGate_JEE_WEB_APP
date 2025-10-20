package com.cliniqueDigitaleJEE.controller.patient;

import com.cliniqueDigitaleJEE.dto.DepartmentDTO;
import com.cliniqueDigitaleJEE.model.Availability;
import com.cliniqueDigitaleJEE.model.Doctor;
import com.cliniqueDigitaleJEE.service.DoctorService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import jakarta.inject.Inject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.*;

import static java.util.spi.ToolProvider.findFirst;

@WebServlet(urlPatterns = {"/api/patient/doctors/*"})
public class PatientDoctorAvailabilityApiServelet extends HttpServlet {

    @Inject
    private DoctorService doctorService;

    private static final ObjectMapper objectMapper = new ObjectMapper()
            .registerModule(new JavaTimeModule())
            .disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

    @Override
    protected void doGet(jakarta.servlet.http.HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp)
            throws jakarta.servlet.ServletException, java.io.IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        String pathInfo = req.getPathInfo();

        //if pathInfo matches /{uuid}/availabilities handle availabilities list
        if(pathInfo !=null && pathInfo.matches("^/[0-9a-fA-F\\-]+/availabilities$")){
            Doctor doctor= doctorService.findByIdWithAppointments(UUID.fromString(pathInfo.split("/")[1]));
            if(doctor == null) {
                resp.setStatus(404);
                resp.getWriter().write("{\"status\":\"error\",\"message\":\"Doctor not found\"}");
                return;
            }
            String dayParam = req.getParameter("day");
            final LocalDateTime dateTime;
            if (dayParam != null && !dayParam.isEmpty()) {
                try {
                    // Use Locale.ENGLISH for parsing browser date string
                    SimpleDateFormat sdf = new java.text.SimpleDateFormat("EEE MMM dd yyyy HH:mm:ss z", Locale.ENGLISH);
                    Date parsedDate = sdf.parse(dayParam);
                    dateTime = parsedDate.toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDateTime();
                } catch (Exception e) {
                    resp.setStatus(400);
                    resp.getWriter().write("{\"status\":\"error\",\"message\":\"Invalid date format\"}");
                    return;
                }
            } else {
                resp.setStatus(400);
                resp.getWriter().write("{\"status\":\"error\",\"message\":\"Missing day parameter\"}");
                return;
            }
            // Map DayOfWeek to French day names
            String[] frenchDays = {"Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"};
            String frenchDay = frenchDays[dateTime.getDayOfWeek().getValue() - 1];
            Optional<Availability> getAvailability = doctor.getAvailabilities().stream()
                    .filter(a -> a.getDay().equalsIgnoreCase(frenchDay)
                            && a.getStatus().toString().equals("AVAILABLE")).findFirst();

            if(getAvailability.isEmpty()){
                resp.setStatus(404);
                resp.getWriter().write("{\"status\":\"error\",\"message\":\"No available slots found for the specified day\"}");
                return;
            }
            Availability availability=getAvailability.get();
            List<Map<String, Object>> availableSlots = new ArrayList<>();
            LocalDateTime startDateTime = LocalDateTime.of(dateTime.toLocalDate(), availability.getStartTime());
            LocalDateTime endDateTime = LocalDateTime.of(dateTime.toLocalDate(), availability.getEndTime());
            java.time.format.DateTimeFormatter slotFormatter = java.time.format.DateTimeFormatter.ofPattern("HH:mm");
            while (startDateTime.isBefore(endDateTime)) {
                String slotTime = startDateTime.format(slotFormatter);
                boolean isBooked = doctorService.isSlotBooked(doctor, dateTime.toLocalDate(), startDateTime.toLocalTime());
                Map<String, Object> slotInfo = new HashMap<>();
                slotInfo.put("time", slotTime);
                slotInfo.put("status", isBooked ? "booked" : "available");
                availableSlots.add(slotInfo);
                startDateTime = startDateTime.plusMinutes(35);
            }
            Map<String, Object> responseMap = new HashMap<>();
            responseMap.put("status", "success");
            responseMap.put("availableSlots", availableSlots);
            objectMapper.writeValue(resp.getWriter(), responseMap);
            return;

        }
    }
}
