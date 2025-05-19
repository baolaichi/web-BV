package com.example.demo.domain;

import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class MedicalRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name="patient_id")
    private Patient patient;
    private String diagnosis;
    private String treatment;
    private LocalDate dateAdmitted;
    private LocalDate dateDischarged;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getTreatment() {
        return treatment;
    }

    public void setTreatment(String treatment) {
        this.treatment = treatment;
    }

    public LocalDate getDateAdmitted() {
        return dateAdmitted;
    }

    public void setDateAdmitted(LocalDate dateAdmitted) {
        this.dateAdmitted = dateAdmitted;
    }

    public LocalDate getDateDischarged() {
        return dateDischarged;
    }

    public void setDateDischarged(LocalDate dateDischarged) {
        this.dateDischarged = dateDischarged;
    }

    
    
}
