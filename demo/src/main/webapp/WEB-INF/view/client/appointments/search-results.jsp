<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kết quả tìm kiếm Lịch hẹn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .results-container { max-width: 800px; margin-top: 50px; padding: 30px; background-color: #fff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .appointment-item { border: 1px solid #e9ecef; border-radius: 5px; padding: 15px; margin-bottom: 15px; background-color: #f8f9fa; }
        .appointment-item strong { display: inline-block; width: 120px; }
    </style>
</head>
<body>

<div class="container">
    <div class="results-container mx-auto">
        <h1 class="text-center mb-4">Kết quả tìm kiếm Lịch hẹn</h1>

        <c:if test="${empty appointments}">
            <div class="alert alert-info text-center">Không tìm thấy lịch hẹn nào với thông tin đã nhập.</div>
        </c:if>

        <c:if test="${not empty appointments}">
            <p class="text-center">Tìm thấy ${appointments.size()} lịch hẹn:</p>
            <div id="appointment-list">
                <c:forEach var="appointment" items="${appointments}">
                    <div class="appointment-item">
                        <p><strong>Mã lịch hẹn:</strong> <a href="/appointments/confirm/${appointment.id}">${appointment.id}</a></p>
                        <p><strong>Tên bệnh nhân:</strong> ${appointment.name}</p>
                        <p><strong>Bác sĩ:</strong> ${appointment.doctor.name}</p>
                        <p><strong>Ngày hẹn:</strong> ${appointment.appointmentDate}</p>
                        <p><strong>Trạng thái:</strong> ${appointment.status}</p>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <div class="text-center mt-4">
            <a href="/" class="btn btn-primary">Về trang chủ</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 