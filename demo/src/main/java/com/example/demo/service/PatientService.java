package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.domain.Patient;
import com.example.demo.repository.PatientRepository;

@Service
public class PatientService {
    private PatientRepository patientRepository;

    public PatientService(PatientRepository patientRepository) {
        this.patientRepository = patientRepository;
    }

    public List<Patient> getAllPatient(){
        return this.patientRepository.findAll();
    }

    public Patient savePatient(Patient patient){
        return this.patientRepository.save(patient);
    }

    public void deletePatient(Long id){
        patientRepository.deleteById(id);
    }

    public Patient editPatientById(Long id){
        return this.patientRepository.findById(id).orElse(null);
    }

}
