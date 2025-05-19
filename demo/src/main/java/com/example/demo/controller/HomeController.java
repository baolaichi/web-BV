package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.service.AppointmentService;
import com.example.demo.service.DoctorService;
import com.example.demo.service.MedicalRecordService;
import com.example.demo.service.PatientService;

@Controller
public class HomeController {

    @Autowired
    private PatientService patientService;

    @Autowired
    private DoctorService doctorService;

    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private MedicalRecordService medicalRecordService;

    @GetMapping("/")
    public String home(Model model) {
        // Thống kê dữ liệu (vẫn giữ nguyên)
        long totalPatients = patientService.getAllPatient().size();
        long totalDoctors = doctorService.getAllDoctors().size();
        long todayAppointments = appointmentService.getAllAppointments().stream()
                .filter(a -> a.getAppointmentDate().equals(new java.util.Date()))
                .count();
        long pendingMedicalRecords = medicalRecordService.getAllMedicalRecords().stream()
                .filter(m -> m.getDateDischarged() == null)
                .count();

        model.addAttribute("totalPatients", totalPatients);
        model.addAttribute("totalDoctors", totalDoctors);
        model.addAttribute("todayAppointments", todayAppointments);
        model.addAttribute("pendingMedicalRecords", pendingMedicalRecords);
        model.addAttribute("doctors", doctorService.getAllDoctors());

        return "/client/homepage/index";
    }
}