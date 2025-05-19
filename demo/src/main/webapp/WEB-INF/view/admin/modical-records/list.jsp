<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Danh sách bệnh án</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                </head>

                <body>

                    <jsp:include page="../layout/header.jsp"/>

                    <div class="container mt-5">
                        <h1 class="text-center mb-4">Danh sách bệnh án</h1>
                        <table class="table table-striped table-bordered">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Bệnh nhân</th>
                                    <th>Chẩn đoán</th>
                                    <th>Điều trị</th>
                                    <th>Ngày nhập viện</th>
                                    <th>Ngày xuất viện</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="record" items="${medicalRecords}">
                                    <tr>
                                        <td>${record.id}</td>
                                        <td>${record.patient.name}</td>
                                        <td>${record.diagnosis}</td>
                                        <td>${record.treatment}</td>
                                        <td>${record.dateAdmitted}</td>
                                        <td>${record.dateDischarged}</td>
                                        <td>
                                            <a href="/medicalRecords/edit/${record.id}"
                                                class="btn btn-warning btn-sm">Sửa</a>
                                            <a href="/medicalRecords/delete/${record.id}" class="btn btn-danger btn-sm"
                                                onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <a href="/medicalRecords/new" class="btn btn-primary">Thêm bệnh án mới</a>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>