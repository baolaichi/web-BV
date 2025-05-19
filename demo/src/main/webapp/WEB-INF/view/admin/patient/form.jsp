<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>${doctor.id == null ? 'Thêm Bác sĩ' : 'Sửa Bác sĩ'}</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>

            <jsp:include page="../layout/header.jsp"/>

            <div class="container mt-5">
                <h1 class="text-center mb-4">${doctor.id == null ? 'Thêm Bác sĩ' : 'Sửa Bác sĩ'}</h1>
                <form action="/doctors" method="post" class="row g-3">
                    <input type="hidden" name="id" value="${doctor.id}" />
                    <div class="col-md-6">
                        <label class="form-label">Tên:</label>
                        <input type="text" name="name" value="${doctor.name}" class="form-control" required />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Chuyên môn:</label>
                        <input type="text" name="specialty" value="${doctor.specialty}" class="form-control" required />
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn btn-success">Lưu</button>
                        <a href="/doctors" class="btn btn-secondary">Quay lại</a>
                    </div>
                </form>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>