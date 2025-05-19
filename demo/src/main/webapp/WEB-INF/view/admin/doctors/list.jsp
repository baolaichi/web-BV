<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Danh sách Bác sĩ</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>

           <jsp:include page="../layout/header.jsp"/>

            <div class="container mt-5">
                <h1 class="text-center mb-4">Danh sách Bác sĩ</h1>
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Chuyên môn</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="doctor" items="${doctors}">
                            <tr>
                                <td>${doctor.id}</td>
                                <td>${doctor.name}</td>
                                <td>${doctor.specialty}</td>
                                <td>
                                    <a href="/doctors/edit/${doctor.id}" class="btn btn-warning btn-sm">Sửa</a>
                                    <a href="/doctors/delete/${doctor.id}" class="btn btn-danger btn-sm"
                                        onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <a href="/doctors/new" class="btn btn-primary">Thêm bác sĩ mới</a>
                <a href="/" class="btn btn-secondary">Quay lại Trang chủ</a>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>