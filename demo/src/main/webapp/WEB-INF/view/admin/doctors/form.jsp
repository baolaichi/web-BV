<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <html>

        <head>
            <title>${medicalRecord.id == null ? 'Thêm bệnh án' : 'Sửa bệnh án'}</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>

            <jsp:include page="../layout/header.jsp"/>

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