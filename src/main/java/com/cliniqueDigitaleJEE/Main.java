package com.cliniqueDigitaleJEE;

import com.cliniqueDigitaleJEE.config.JPAUtil;
import jakarta.persistence.EntityManager;

public class Main {
    public static void main(String[] args) {
        System.out.println("🚀 Starting Clinique Digitale Application...");

        try {
            // Test database connection
            EntityManager em = JPAUtil.getEntityManager();
            System.out.println("✅ Database connection successful!");
            System.out.println("✅ Hibernate should have created all tables automatically!");

            // Close the EntityManager
            em.close();

            System.out.println("\n📊 Check your database - tables should be created!");
            System.out.println("   - users, admins, doctors, patients, staff");
            System.out.println("   - departments, specialties");
            System.out.println("   - appointments, availabilities, medical_notes");

        } catch (Exception e) {
            System.err.println("❌ Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            JPAUtil.closeEntityManagerFactory();
        }

        System.out.println("\n✅ Application finished!");
    }
}

