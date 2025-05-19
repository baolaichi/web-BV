<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

        <html>

        <head>
            <meta charset="UTF-8">
            <title>Danh sách bệnh nhân</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
           <jsp:include page="../layout/header.jsp"/>

            <div class="container mt-5">
                <h1 class="text-center mb-4">Danh sách bệnh nhân</h1>
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Ngày sinh</th>
                            <th>Giới tính</th>
                            <th>Địa chỉ</th>
                            <th>Điện thoại</th>
                            <th>Email</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="patient" items="${patients}">
                            <tr>
                                <td>${patient.id}</td>
                                <td>${patient.name}</td>
                                <td>${patient.dateOfBirth}</td>
                                <td>${patient.gender}</td>
                                <td>${patient.address}</td>
                                <td>${patient.phone}</td>
                                <td>${patient.email}</td>
                                <td>
                                    <a href="/patients/edit/${patient.id}" class="btn btn-warning btn-sm">Sửa</a>
                                    <a href="/patients/delete/${patient.id}" class="btn btn-danger btn-sm"
                                        onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                                    <a href="/patients/edit/${patient.id}" class="btn btn-success btn-sm">Xem Chi
                                        tiết</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <a href="/patients/new" class="btn btn-primary">Thêm bệnh nhân mới</a>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>