package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.domain.MedicalRecord;
import com.example.demo.repository.MedicalRecordRepository;

@Service
public class MedicalRecordService {
    private MedicalRecordRepository medicalRecordRepository;

    public MedicalRecordService(MedicalRecordRepository medicalRecordRepository) {
        this.medicalRecordRepository = medicalRecordRepository;
    }
    
    public List<MedicalRecord> getAllMedicalRecords() {
        return medicalRecordRepository.findAll();
    } 

    public MedicalRecord getMedicalRecordById(Long id){
        return medicalRecordRepository.findById(id).orElse(null);
    }

    public void deleteMedicalRecord(Long id){
        medicalRecordRepository.deleteById(id);
    }

    public MedicalRecord saveMedicalRecord(MedicalRecord medicalRecord){
        return this.medicalRecordRepository.save(medicalRecord);
    }
}
