<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Đăng nhập - Bệnh viện LSB-163</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <style>
                .login-container {
                    max-width: 400px;
                    margin: 100px auto;
                }
            </style>
        </head>

        <body>
            <div class="login-container">
                <h2 class="text-center mb-4">Đăng nhập</h2>
                <c:if test="${param.error != null}">
                    <div class="alert alert-danger">Tên đăng nhập hoặc mật khẩu không đúng!</div>
                </c:if>
                <c:if test="${param.logout != null}">
                    <div class="alert alert-success">Bạn đã đăng xuất thành công!</div>
                </c:if>
                <c:if test="${param.registered != null}">
                    <div class="alert alert-success">Đăng ký thành công! Vui lòng đăng nhập.</div>
                </c:if>
                <form action="/login" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label">Tên đăng nhập</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
                </form>
                <p class="text-center mt-3">Chưa có tài khoản? <a href="/register">Đăng ký</a></p>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>