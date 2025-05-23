package com.example.demo.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.domain.Doctor;

@Repository
public interface DoctorRepository extends JpaRepository<Doctor, Long> {
}
