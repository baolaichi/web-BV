package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.demo.domain.Patient;
import com.example.demo.service.PatientService;


@Controller
public class PatientController {
    private PatientService patientService;

    public PatientController(PatientService patientService) {
        this.patientService = patientService;
    }
    
    @RequestMapping("/patients")
    public String listPatients(Model model) {
        model.addAttribute("patients", patientService.getAllPatient());
        return "admin/patients/list";
    }

    @GetMapping("/patients/new")
    public String showNewPatientForm(Model model) {
        model.addAttribute("newPatient", new Patient());
        return "admin/patients/form"; 
}

    @RequestMapping(value="/patients/new", method = RequestMethod.POST)
    public String savePatients(Model model, @ModelAttribute("newPatient") Patient new_patient) {
        this.patientService.savePatient(new_patient);
        return "redirect:/patients";
    }
    
    @RequestMapping("/patients/delete/{id}")
    public String deletePatients(@PathVariable Long id) {
        patientService.deletePatient(id);
        return "redirect:/patients";
    }
    
    @RequestMapping("/patients/edit/{id}")
    public String editPatients(Model model, @PathVariable Long id) {
        Patient patient = this.patientService.editPatientById(id);
        model.addAttribute("newPatient", patient);
        return "admin/patients/form";
    }

}
