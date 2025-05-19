<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>       
       <nav class="navbar navbar-expand-lg" style="background-color: #cceeff;">
                <div class="container-fluid">
                    <a class="navbar-brand fw-bold text-primary" href="/">LSB-163</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">

                            <!-- Chức năng 1 -->
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="chucNang1" role="button"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                    Quản lý bệnh nhân
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="chucNang1">
                                    <li><a class="dropdown-item" href="/patients/new">Thêm bệnh nhân</a></li>
                                    <li><a class="dropdown-item" href="/patients">Danh sách bệnh nhân</a></li>
                                </ul>
                            </li>

                            <!-- Chức năng 2 -->
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="chucNang2" role="button"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                    Bác sĩ
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="chucNang2">
                                    <li><a class="dropdown-item" href="/doctors/new">Thêm bác sĩ</a></li>
                                    <li><a class="dropdown-item" href="/doctors">Danh sách bác sĩ</a></li>
                                </ul>
                            </li>

                            <!-- Chức năng 3 -->
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="chucNang3" role="button"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                    Lịch hẹn
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="chucNang3">
                                    <li><a class="dropdown-item" href="/appointments/new">Tạo lịch hẹn</a></li>
                                    <li><a class="dropdown-item" href="/appointments">Xem lịch hẹn</a></li>
                                </ul>
                            </li>

                            <!-- Chức năng 4 -->
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="chucNang4" role="button"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                    Hồ sơ bệnh án
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="chucNang4">
                                    <li><a class="dropdown-item" href="/medicalRecords/new">Thêm hồ sơ</a></li>
                                    <li><a class="dropdown-item" href="/medicalRecords">Xem hồ sơ</a></li>
                                </ul>
                            </li>

                            <!-- Chức năng 5 -->
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="chucNang5" role="button"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                    Tài khoản
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="chucNang5">
                                    <li><a class="dropdown-item" href="#">Thông tin cá nhân</a></li>
                                    <li><a class="dropdown-item" href="/logout">Đăng xuất</a></li>
                                </ul>
                            </li>

                        </ul>
                    </div>
                </div>
            </nav>