package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.domain.Appointment;
import com.example.demo.service.AppointmentService;
import com.example.demo.service.DoctorService;
import com.example.demo.service.PatientService;

import java.util.List;

@Controller
@RequestMapping("/appointments")
public class AppointmentController {
    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private PatientService patientService;

    @Autowired
    private DoctorService doctorService;

    // Hiển thị danh sách lịch hẹn
    @GetMapping
    public String listAppointments(Model model) {
        model.addAttribute("appointments", appointmentService.getAllAppointments());
        return "/admin/appointments/list";
    }

    // Hiển thị form thêm lịch hẹn mới
    @GetMapping("/new")
    public String newAppointmentForm(Model model) {
        model.addAttribute("appointment", new Appointment());
        model.addAttribute("patients", patientService.getAllPatient());
        model.addAttribute("doctors", doctorService.getAllDoctors());
        return "/client/appointments/form";
    }

    // Lưu thông tin lịch hẹn (thêm hoặc sửa)
    @PostMapping
    public String saveAppointment(@ModelAttribute Appointment appointment) {
        appointmentService.saveAppointment(appointment);
        // Sau khi lưu, chuyển hướng đến trang xác nhận với ID lịch hẹn
        return "redirect:/appointments/confirm/" + appointment.getId();
    }

    // Hiển thị trang xác nhận lịch hẹn
    @GetMapping("/confirm/{id}")
    public String confirmAppointment(@PathVariable Long id, @RequestParam(required = false) String name, Model model) {
        Appointment appointment = appointmentService.getAppointmentById(id);
        if (appointment != null) {
            if (name == null || appointment.getName().equalsIgnoreCase(name.trim())) {
                model.addAttribute("appointment", appointment);
                return "/client/appointments/confirmation";
            } else {
                model.addAttribute("error", "Tên bệnh nhân không khớp với mã lịch hẹn.");
                return "/client/appointments/confirmation-error";
            }
        }
        return "redirect:/";
    }

    // Hiển thị form sửa lịch hẹn
    @GetMapping("/edit/{id}")
    public String editAppointmentForm(@PathVariable Long id, Model model) {
        Appointment appointment = appointmentService.getAppointmentById(id);
        if (appointment != null) {
            model.addAttribute("appointment", appointment);
            model.addAttribute("patients", patientService.getAllPatient());
            model.addAttribute("doctors", doctorService.getAllDoctors());
            return "appointments/form";
        }
        return "redirect:/appointments";
    }

    // Xóa lịch hẹn
    @GetMapping("/delete/{id}")
    public String deleteAppointment(@PathVariable Long id) {
        appointmentService.deleteAppointment(id);
        return "redirect:/appointments";
    }

    // Chấp nhận lịch hẹn
    @GetMapping("/accept/{id}")
    public String acceptAppointment(@PathVariable Long id) {
        Appointment appointment = appointmentService.getAppointmentById(id);
        if (appointment != null) {
            appointment.setStatus("ACCEPTED");
            appointmentService.saveAppointment(appointment); // Sử dụng saveAppointment để cập nhật
        }
        return "redirect:/appointments";
    }

    // Từ chối lịch hẹn
    @GetMapping("/reject/{id}")
    public String rejectAppointment(@PathVariable Long id) {
        Appointment appointment = appointmentService.getAppointmentById(id);
        if (appointment != null) {
            appointment.setStatus("REJECTED");
            appointmentService.saveAppointment(appointment); // Sử dụng saveAppointment để cập nhật
        }
        return "redirect:/appointments";
    }

    // Tìm kiếm lịch hẹn theo tên và số điện thoại
    @GetMapping("/search")
    public String searchAppointments(@RequestParam String name, @RequestParam String phone, Model model) {
        List<Appointment> foundAppointments = appointmentService.findAppointmentsByNameAndPhone(name, phone);
        model.addAttribute("appointments", foundAppointments);
        // Chúng ta sẽ hiển thị kết quả trên một trang JSP mới
        return "/client/appointments/search-results";
    }
}
