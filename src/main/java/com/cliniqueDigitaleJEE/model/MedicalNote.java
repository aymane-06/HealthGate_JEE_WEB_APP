package com.cliniqueDigitaleJEE.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.UUID;
@Entity
@Table(name = "medical_notes")
public class MedicalNote {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private UUID id;
    @Column(columnDefinition = "TEXT")
    private String content;
    @Column(nullable = false, columnDefinition = "TIMESTAMP")
    private LocalDateTime createdAt;
    @Column(nullable = false , columnDefinition = "boolean default false")
    private boolean validated;

    public MedicalNote() {}
    public MedicalNote(String content, LocalDateTime createdAt, boolean validated) {
        this.content = content;
        this.createdAt = createdAt;
        this.validated = validated;
    }
    public UUID getId() {
        return id;
    }
    public void setId(UUID id) {
        this.id = id;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    public boolean isValidated() {
        return validated;
    }
    public void setValidated(boolean validated) {
        this.validated = validated;
    }
    @Override
    public String toString() {
        return "MedicalNote{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", createdAt=" + createdAt +
                ", validated=" + validated +
                '}';
    }
}
