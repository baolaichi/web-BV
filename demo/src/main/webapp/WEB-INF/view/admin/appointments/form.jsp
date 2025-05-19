<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <html>

        <head>
            <title>${medicalRecord.id == null ? 'Thêm bệnh án' : 'Sửa bệnh án'}</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>

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

            <div class="container mt-5">
                <h1 class="text-center mb-4">${medicalRecord.id == null ? 'Thêm bệnh án' : 'Sửa bệnh án'}</h1>
                <form action="/medicalRecords/new" method="post" class="row g-3">
                    <input type="hidden" name="id" value="${medicalRecord.id}" />
                    <div class="col-md-6">
                        <label class="form-label">Bệnh nhân:</label>
                        <select name="patient.id" class="form-select" required>
                            <c:forEach var="patient" items="${patients}">
                                <option value="${patient.id}" ${medicalRecord.patient.id==patient.id ? 'selected' : ''
                                    }>
                                    ${patient.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Chẩn đoán:</label>
                        <input type="text" name="diagnosis" value="${medicalRecord.diagnosis}" class="form-control"
                            required />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Điều trị:</label>
                        <input type="text" name="treatment" value="${medicalRecord.treatment}" class="form-control"
                            required />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Ngày nhập viện:</label>
                        <input type="date" name="dateAdmitted" value="${medicalRecord.dateAdmitted}"
                            class="form-control" required />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Ngày xuất viện:</label>
                        <input type="date" name="dateDischarged" value="${medicalRecord.dateDischarged}"
                            class="form-control" />
                    </div>
                    <div class="col-12 mt-3">
                        <button type="submit" class="btn btn-success">Lưu</button>
                        <a href="/medicalRecords" class="btn btn-secondary">Quay lại</a>
                    </div>
                </form>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>