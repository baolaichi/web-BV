<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Thêm mới Bệnh nhân</title>
                <!-- Latest compiled and minified CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

                <!-- Latest compiled JavaScript -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <!-- <link href="/css/demo.css" rel="stylesheet"> -->

            </head>

            <body>

                <jsp:include page="../layout/header.jsp"/>

                <div class="container mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Thêm thông tin bệnh nhân</h3>
                            <hr />
                            <form:form method="post" action="/patients/new" modelAttribute="newPatient">
                                <div class="mb-3">
                                    <label class="form-label">Email:</label>
                                    <form:input type="email" class="form-control" path="email" />
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Ngày sinh:</label>
                                    <form:input type="date" class="form-control" path="dateOfBirth" />
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Số điện thoại:</label>
                                    <form:input type="text" class="form-control" path="phone" />
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Họ và tên:</label>
                                    <form:input type="text" class="form-control" path="name" />
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Giới tính:</label>
                                    <form:select path="gender" cssClass="form-select">
                                        <form:option value="" label="-- Chọn giới tính --" />
                                        <form:option value="Nam" label="Nam" />
                                        <form:option value="Nữ" label="Nữ" />
                                        <form:option value="Khác" label="Khác" />
                                    </form:select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Địa chỉ:</label>
                                    <form:input type="text" class="form-control" path="address" />
                                </div>

                                <div class="col-12">
                                    <button type="submit" class="btn btn-success">Lưu</button>
                                    <a href="/patients" class="btn btn-secondary">Quay lại</a>
                                </div>
                            </form:form>
                        </div>

                    </div>

                </div>
            </body>

            </html>