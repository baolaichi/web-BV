<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>${appointment.id == null ? 'Thêm lịch hẹn' : 'Sửa lịch hẹn'}</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>

           <jsp:include page="../layout/header.jsp"/>

            <div class="container mt-5">
                <h1 class="text-center mb-4">${appointment.id == null ? 'Thêm lịch hẹn' : 'Sửa lịch hẹn'}</h1>
                <form action="/appointments" method="post" class="row g-3">
                    <input type="hidden" name="id" value="${appointment.id}" />
                    
                    <div class="col-md-6">
                        <label class="form-label">Họ và tên:</label>
                        <input type="text" name="name" value="${appointment.name}" class="form-control" required />
                    </div>
                    
                    <div class="col-md-6">
                        <label class="form-label">Tuổi:</label>
                        <input type="number" name="age" value="${appointment.age}" class="form-control" required />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Bác sĩ:</label>
                        <select name="doctor.id" class="form-select" required>
                            <c:forEach var="doctor" items="${doctors}">
                                <option value="${doctor.id}" ${appointment.doctor.id == doctor.id ? 'selected' : ''}>
                                    ${doctor.name} - ${doctor.specialty}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Ngày hẹn:</label>
                        <input type="date" name="appointmentDate" value="${appointment.appointmentDate}" class="form-control" required />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Địa chỉ:</label>
                        <input type="text" name="address" value="${appointment.address}" class="form-control" required />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Triệu chứng:</label>
                        <input type="text" name="symptom" value="${appointment.symptom}" class="form-control" required />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Trạng thái:</label>
                        <select name="status" class="form-select" required>
                            <option value="PENDING" ${appointment.status == 'PENDING' ? 'selected' : ''}>Chờ xác nhận</option>
                            <option value="CONFIRMED" ${appointment.status == 'CONFIRMED' ? 'selected' : ''}>Đã xác nhận</option>
                            <option value="CANCELLED" ${appointment.status == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                            <option value="COMPLETED" ${appointment.status == 'COMPLETED' ? 'selected' : ''}>Đã hoàn thành</option>
                        </select>
                    </div>

                    <div class="col-12 mt-3">
                        <button type="submit" class="btn btn-success">Lưu</button>
                        <a href="/appointments" class="btn btn-secondary">Quay lại</a>
                    </div>
                </form>
            </div>

              <!-- Liên hệ -->
           <jsp:include page="../layout/footer.jsp"/>
           
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>