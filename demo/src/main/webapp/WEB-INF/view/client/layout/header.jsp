<%@page contentType="text/html" pageEncoding="UTF-8" %>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

      <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
                <div class="container">
                    <a class="navbar-brand text-primary" href="/">
                        <i class="fas fa-hospital me-2"></i>Bệnh viện LSB-163
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav me-auto">
                            <li class="nav-item"><a class="nav-link active" href="/">Trang chủ</a></li>
                            <li class="nav-item"><a class="nav-link" href="#about">Giới thiệu</a></li>
                            <li class="nav-item"><a class="nav-link" href="#services">Dịch vụ</a></li>
                            <li class="nav-item"><a class="nav-link" href="#doctors">Đội ngũ bác sĩ</a></li>
                            <c:if test="${sessionScope.user != null}">
                                <li class="nav-item"><a class="nav-link" href="/appointments/new">Đặt lịch hẹn</a></li>
                            </c:if>
                            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'DOCTOR'}">
                                <li class="nav-item"><a class="nav-link" href="/patients">Điều chỉnh chuyên sâu</a></li>
                            </c:if>
                            <li class="nav-item"><a class="nav-link" href="#contact">Liên hệ</a></li>
                        </ul>
                        <ul class="navbar-nav">
                            <c:if test="${sessionScope.user != null}">
                                <li class="nav-item">
                                    <a class="nav-link" href="/logout">Đăng xuất (${sessionScope.user.username})</a>
                                </li>
                            </c:if>
                            <c:if test="${sessionScope.user == null}">
                                <li class="nav-item">
                                    <a class="nav-link" href="/login">Đăng nhập</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/register">Đăng ký</a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </nav>
