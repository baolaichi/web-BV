package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.domain.Patient;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Long>{
    Patient save(Patient patient);
}
