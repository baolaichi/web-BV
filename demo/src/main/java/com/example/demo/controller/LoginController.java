package com.example.demo.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.domain.User;
import com.example.demo.service.UserService;
import com.example.demo.service.DoctorService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @Autowired
    private DoctorService doctorService;

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String login(
            @RequestParam String username,
            @RequestParam String password,
            HttpSession session,
            Model model) {
        User user = userService.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            // Đăng nhập thành công
            session.setAttribute("user", user);

            // Nếu user là bác sĩ, lưu thêm thông tin bác sĩ vào session
            if ("DOCTOR".equals(user.getRole())) {
                // Giả định User.id của bác sĩ trùng với Doctor.id
                Long doctorId = user.getId();
                session.setAttribute("loggedInDoctorId", doctorId);
                // Optional: Lấy cả Doctor object nếu cần thông tin khác
                // Doctor doctor = doctorService.getDoctorById(doctorId);
                // session.setAttribute("loggedInDoctor", doctor);
            }

            return "redirect:/";
        } else {
            // Đăng nhập thất bại
            model.addAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // Xóa session
        return "redirect:/?logout=true";
    }
}