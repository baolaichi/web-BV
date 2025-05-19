 <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <section id="contact" class="py-5 bg-primary">
                <div class="container">
                    <h2 class="text-center mb-4 section-title text-light">Liên hệ</h2>
                    <div class="row">
                        <div class="col-md-6">
                            <h5 class="text-light">Thông tin liên hệ</h5>
                            <p class="text-light"><i class="fas fa-map-marker-alt me-2"></i>Sơn Nam, Sơn Dương, Tuyên Quang</p>
                            <p class="text-light"><i class="fas fa-phone me-2"></i>(+84) 123 456 789</p>
                            <p class="text-light"><i class="fas fa-envelope me-2"></i>contact@lsb163.com</p>
                        </div>
                        <div class="col-md-6">
                            <h5 class="text-light">Gửi tin nhắn</h5>
                            <form>
                                <div class="mb-3">
                                    <input type="text" class="form-control" placeholder="Họ và tên" required>
                                </div>
                                <div class="mb-3">
                                    <input type="email" class="form-control" placeholder="Email" required>
                                </div>
                                <div class="mb-3">
                                    <textarea class="form-control" rows="3" placeholder="Tin nhắn" required></textarea>
                                </div>
                                <button type="submit" class="btn btn-success">Gửi</button>
                            </form>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Footer -->
            <footer class="text-center">
                <p>© 2025 Bệnh viện LSB-163. All rights reserved.</p>
            </footer>