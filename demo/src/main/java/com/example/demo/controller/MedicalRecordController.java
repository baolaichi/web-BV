package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.demo.domain.MedicalRecord;
import com.example.demo.service.MedicalRecordService;
import com.example.demo.service.PatientService;





@Controller
public class MedicalRecordController {
    private PatientService patientService;
    private MedicalRecordService medicalRecordService;

    
    public MedicalRecordController(PatientService patientService, MedicalRecordService medicalRecordService) {
        this.patientService = patientService;
        this.medicalRecordService = medicalRecordService;
    }

    @RequestMapping("/medicalRecords")
    public String requestMethodName(Model model) {
        model.addAttribute("medicalRecords", medicalRecordService.getAllMedicalRecords());
        return "admin/modical-records/list";
    }
    

    @RequestMapping(value="/medicalRecords/new")
    public String newMedicalRecordform(Model model) {
        model.addAttribute("medicalRecord", new MedicalRecord());
        model.addAttribute("patients", patientService.getAllPatient());
        return "admin/modical-records/form";
    }

    @RequestMapping(value="/medicalRecords/edit/{id}", method=RequestMethod.GET)
    public String editMedicalRecord(Model model, @PathVariable Long id) {
       MedicalRecord medicalRecord = medicalRecordService.getMedicalRecordById(id);
        model.addAttribute("medicalRecord", medicalRecord);
        model.addAttribute("patients", patientService.getAllPatient());
        return "admin/modical-records/form";
    }
    

    @PostMapping("/medicalRecords/new")
    public String postMethodName(@ModelAttribute MedicalRecord medicalRecord) {
        //TODO: process POST request
        medicalRecordService.saveMedicalRecord(medicalRecord);
        return "redirect:/medicalRecords";
    }

    @GetMapping("/medicalRecords/delete/{id}")
    public String deleteMedicalRecord(@PathVariable Long id) {
        medicalRecordService.deleteMedicalRecord(id);
        return "redirect:/medicalRecords";
    }
    
    
    
}
