package com.cliniqueDigitaleJEE.config;

import com.cliniqueDigitaleJEE.model.Admin;
import com.cliniqueDigitaleJEE.model.Doctor;
import com.cliniqueDigitaleJEE.model.Patient;
import com.cliniqueDigitaleJEE.model.ENUMS.Gender;
import com.cliniqueDigitaleJEE.model.ENUMS.Role;
import jakarta.annotation.PostConstruct;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.mindrot.jbcrypt.BCrypt;

import java.time.LocalDate;
import java.util.logging.Logger;

/**
 * Database seeder that populates initial data using TomEE EJB
 * Runs automatically on application startup
 */
@Singleton
@Startup
public class DatabaseSeeder {
    
    private static final Logger LOGGER = Logger.getLogger(DatabaseSeeder.class.getName());
    
    @PersistenceContext(unitName = "cliniquePU")
    private EntityManager em;
    
    @PostConstruct
    public void seedDatabase() {
        try {
            LOGGER.info("🚀 Starting database seeding with @PersistenceContext...");
            LOGGER.info("🌱 Checking if database needs seeding...");
            
            // Check if admin user already exists
            Long adminCount = em.createQuery("SELECT COUNT(a) FROM Admin a WHERE a.email = :email", Long.class)
                              .setParameter("email", "admin@clinique.ma")
                              .getSingleResult();
            
            if (adminCount > 0) {
                LOGGER.info("✅ Database already seeded. Admin user exists. Skipping...");
                return;
            }
            
            LOGGER.info("👥 No admin found. Starting database seeding...");
            
            // Seed users
            seedUsers();
            
            LOGGER.info("✅ Database seeding completed successfully!");
            
        } catch (Exception e) {
            LOGGER.severe("❌ Error seeding database: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    private void seedUsers() {
        LOGGER.info("👥 Seeding users...");
        
                // 1. Admin User
        Admin admin = new Admin();
        // Ne PAS définir l'ID - laissons JPA le générer automatiquement
        admin.setName("Mohammed Alami");
        admin.setEmail("admin@clinique.ma");
        admin.setPassword(BCrypt.hashpw("admin123", BCrypt.gensalt()));
        admin.setRole(Role.ADMIN); // Définir le rôle manuellement
        admin.setActive(true);
        em.persist(admin);
        LOGGER.info("✅ Created Admin: admin@clinique.ma / admin123");
        
        // 2. Doctor User - Cardiology
        Doctor doctor1 = new Doctor();
        doctor1.setName("Dr. Sara Bennani");
        doctor1.setEmail("sara.bennani@clinique.ma");
        doctor1.setPassword(BCrypt.hashpw("doctor123", BCrypt.gensalt()));
        doctor1.setRole(Role.DOCTOR); // Définir le rôle
        doctor1.setMatricule("DOC-2024-001");
        doctor1.setTitle("Cardiologue");
        doctor1.setActive(true);
        em.persist(doctor1);
        LOGGER.info("✅ Created Doctor: sara.bennani@clinique.ma / doctor123");
        
        // 3. Doctor User - Neurology
        Doctor doctor2 = new Doctor();
        doctor2.setName("Dr. Ahmed Idrissi");
        doctor2.setEmail("ahmed.idrissi@clinique.ma");
        doctor2.setPassword(BCrypt.hashpw("doctor123", BCrypt.gensalt()));
        doctor2.setRole(Role.DOCTOR);
        doctor2.setMatricule("DOC-2024-002");
        doctor2.setTitle("Neurologue");
        doctor2.setActive(true);
        em.persist(doctor2);
        LOGGER.info("✅ Created Doctor: ahmed.idrissi@clinique.ma / doctor123");
        
        // 4. Doctor User - Pediatrics
        Doctor doctor3 = new Doctor();
        doctor3.setName("Dr. Laila Fassi");
        doctor3.setEmail("laila.fassi@clinique.ma");
        doctor3.setPassword(BCrypt.hashpw("doctor123", BCrypt.gensalt()));
        doctor3.setRole(Role.DOCTOR);
        doctor3.setMatricule("DOC-2024-003");
        doctor3.setTitle("Pédiatre");
        doctor3.setActive(true);
        em.persist(doctor3);
        LOGGER.info("✅ Created Doctor: laila.fassi@clinique.ma / doctor123");
        
        // 5. Patient User
        Patient patient1 = new Patient();
        patient1.setName("Youssef Idrissi");
        patient1.setEmail("youssef.idrissi@gmail.com");
        patient1.setPassword(BCrypt.hashpw("patient123", BCrypt.gensalt()));
        patient1.setRole(Role.PATIENT);
        patient1.setCIN("AB123456");
        patient1.setPhone("+212 6 12 34 56 78");
        patient1.setAddress("Casablanca, Morocco");
        patient1.setBirthDate(LocalDate.of(1985, 5, 15));
        patient1.setGender(Gender.MALE);
        patient1.setBloodType("A+");
        patient1.setActive(true);
        em.persist(patient1);
        LOGGER.info("✅ Created Patient: youssef.idrissi@gmail.com / patient123");
        
        // 6. Patient User
        Patient patient2 = new Patient();
        patient2.setName("Amina Fassi");
        patient2.setEmail("amina.fassi@gmail.com");
        patient2.setPassword(BCrypt.hashpw("patient123", BCrypt.gensalt()));
        patient2.setRole(Role.PATIENT);
        patient2.setCIN("CD789012");
        patient2.setPhone("+212 6 23 45 67 89");
        patient2.setAddress("Rabat, Morocco");
        patient2.setBirthDate(LocalDate.of(1992, 8, 22));
        patient2.setGender(Gender.FEMALE);
        patient2.setBloodType("O+");
        patient2.setActive(true);
        em.persist(patient2);
        LOGGER.info("✅ Created Patient: amina.fassi@gmail.com / patient123");
        
        // 7. Patient User
        Patient patient3 = new Patient();
        patient3.setName("Omar Benali");
        patient3.setEmail("omar.benali@gmail.com");
        patient3.setPassword(BCrypt.hashpw("patient123", BCrypt.gensalt()));
        patient3.setRole(Role.PATIENT);
        patient3.setCIN("EF345678");
        patient3.setPhone("+212 6 34 56 78 90");
        patient3.setAddress("Marrakech, Morocco");
        patient3.setBirthDate(LocalDate.of(1978, 12, 10));
        patient3.setGender(Gender.MALE);
        patient3.setBloodType("B+");
        patient3.setActive(true);
        em.persist(patient3);
        LOGGER.info("✅ Created Patient: omar.benali@gmail.com / patient123");
        
        LOGGER.info("🎉 Successfully seeded 7 users (1 Admin, 3 Doctors, 3 Patients)");
        LOGGER.info("📋 Default credentials:");
        LOGGER.info("   Admin:   admin@clinique.ma / admin123");
        LOGGER.info("   Doctor:  sara.bennani@clinique.ma / doctor123");
        LOGGER.info("   Patient: youssef.idrissi@gmail.com / patient123");
    }
}
