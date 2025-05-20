<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Bệnh viện LSB-163</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
            
            <style>
                .hero-section {
                    background: linear-gradient(135deg, #007bff, #00c6ff);
                    color: white;
                    padding: 100px 0;
                }

                .section-title {
                    position: relative;
                    display: inline-block;
                    margin-bottom: 30px;
                }

                .section-title::after {
                    content: '';
                    width: 50px;
                    height: 3px;
                    background: #007bff;
                    position: absolute;
                    bottom: -10px;
                    left: 50%;
                    transform: translateX(-50%);
                }

                .doctor-card img {
                    width: 100%;
                    height: 200px;
                    object-fit: cover;
                }

                footer {
                    background: #f8f9fa;
                    padding: 20px 0;
                }

                .about-card {
                    transition: transform 0.3s ease, box-shadow 0.3s ease;
                }

                .about-card:hover {
                    transform: translateY(-10px);
                    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
                }

                .carousel-item img {
                    height: 500px;
                    object-fit: cover;
                }

                /* Thêm CSS cho chatbot */
                .chatbot {
                    position: fixed;
                    bottom: 80px;
                    right: 20px;
                    width: 300px;
                    height: 400px;
                    background: white;
                    border-radius: 10px;
                    box-shadow: 0 0 10px rgba(0,0,0,0.1);
                    z-index: 1000;
                    display: flex;
                    flex-direction: column;
                }

                .chat-header {
                    border-radius: 10px 10px 0 0;
                }

                .chat-body {
                    flex: 1;
                    overflow-y: auto;
                    padding: 10px;
                }

                .chat-input {
                    border: none;
                    border-top: 1px solid #eee;
                    padding: 10px;
                    width: 100%;
                }

                .chat-input:focus {
                    outline: none;
                }

                /* Thêm CSS cho tin nhắn chat */
                .chat-message {
                    margin: 10px 0;
                    display: flex;
                    flex-direction: column;
                }

                .chat-message.user {
                    align-items: flex-end;
                }

                .chat-message.bot {
                    align-items: flex-start;
                }

                .message-content {
                    max-width: 80%;
                    padding: 10px 15px;
                    border-radius: 15px;
                    margin: 5px 0;
                }

                .user .message-content {
                    background-color: #007bff;
                    color: white;
                    border-top-right-radius: 5px;
                }

                .bot .message-content {
                    background-color: #e9ecef;
                    color: black;
                    border-top-left-radius: 5px;
                }

                .message-sender {
                    font-size: 0.8em;
                    color: #6c757d;
                    margin: 0 5px;
                }
            </style>
            <script src="/resources/client/js/chatbot.js"></script>
        </head>

        <body>
            <!-- Navbar -->
           <jsp:include page="../layout/header.jsp"/>
            <!-- Thông báo -->
            <c:if test="${param.logout != null}">
                <div class="alert alert-success text-center">Bạn đã đăng xuất thành công!</div>
            </c:if>

            <!-- Hero Section -->
            <section class="hero-section text-center">
                <div class="container-fluid">
                    <h1 class="display-4 fw-bold">Chăm sóc sức khỏe toàn diện</h1>
                    <p class="lead">Đội ngũ chuyên gia hàng đầu, công nghệ hiện đại, dịch vụ tận tâm.</p>
                </div>
                <c:if test="${sessionScope.user != null}">
                    <a href="/appointments/new" class="btn btn-primary btn-lg mt-3">Đặt lịch hẹn ngay</a>
                </c:if>
                <c:if test="${sessionScope.user == null}">
                    <a href="/login" class="btn btn-primary btn-lg mt-3">Đăng nhập để đặt lịch hẹn</a>
                </c:if>
            </section>

            <!-- Thống kê -->
            <section id="stats" class="py-5 bg-light">
                <div class="container">
                    <h2 class="text-center mb-4 section-title">Thống kê hoạt động</h2>
                    <div class="row text-center">
                        <div class="col-md-3">
                            <div class="card p-3">
                                <h3 class="fw-bold">${totalPatients}</h3>
                                <p>Tổng số bệnh nhân</p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card p-3">
                                <h3 class="fw-bold">${totalDoctors}</h3>
                                <p>Tổng số bác sĩ</p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card p-3">
                                <h3 class="fw-bold">${todayAppointments}</h3>
                                <p>Lịch hẹn hôm nay</p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card p-3">
                                <h3 class="fw-bold">${pendingMedicalRecords}</h3>
                                <p>Bệnh án đang xử lý</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Giới thiệu (Phiên bản nâng cấp) -->
            <section id="about" class="py-5 bg-light">
                <div class="container">
                    <h2 class="text-center mb-5 section-title">Giới thiệu về Bệnh viện LSB-163</h2>

                    <!-- Carousel hình ảnh -->
                    <div id="aboutCarousel" class="carousel slide mb-5" data-bs-ride="carousel">
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#aboutCarousel" data-bs-slide-to="0" class="active"
                                aria-current="true" aria-label="Slide 1"></button>
                            <button type="button" data-bs-target="#aboutCarousel" data-bs-slide-to="1"
                                aria-label="Slide 2"></button>
                            <button type="button" data-bs-target="#aboutCarousel" data-bs-slide-to="2"
                                aria-label="Slide 3"></button>
                        </div>
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="https://afamilycdn.com/2019/11/25/photo-2-15746602598891524577874-1574660840289-15746608402902138958576.jpg"
                                    class="d-block w-100" alt="Bệnh viện LSB-163">
                                <div class="carousel-caption d-none d-md-block bg-dark">
                                    <h5>Cơ sở vật chất hiện đại</h5>
                                    <p>Trang thiết bị tiên tiến, phục vụ tốt nhất cho bệnh nhân.</p>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <img src="https://media.istockphoto.com/id/1502224118/vi/vec-to/b%C3%A1c-s%C4%A9-y-t%C3%A1-v%C3%A0-b%C3%A1c-s%C4%A9-ph%E1%BA%ABu-thu%E1%BA%ADt-clipart-phong-c%C3%A1ch-ho%E1%BA%A1t-h%C3%ACnh-ngh%E1%BB%81-nghi%E1%BB%87p-trong-b%E1%BB%87nh-vi%E1%BB%87n-v%C3%A0.jpg?s=1024x1024&w=is&k=20&c=y_mW15g133orwYeoFI3CELOJ3tSCa1knny5AQuI-hcM="
                                    class="d-block w-100" alt="Đội ngũ bác sĩ">
                                <div class="carousel-caption d-none d-md-block bg-dark">
                                    <h5>Đội ngũ bác sĩ chuyên môn cao</h5>
                                    <p>Đội ngũ y bác sĩ tận tâm, giàu kinh nghiệm.</p>
                                </div>
                            </div>
                            <div class="carousel-item">
                                <img src="https://images.unsplash.com/photo-1585435557343-3b092031a831?q=80&w=2070&auto=format&fit=crop"
                                    class="d-block w-100" alt="Chăm sóc bệnh nhân">
                                <div class="carousel-caption d-none d-md-block  bg-dark">
                                    <h5>Chăm sóc tận tình</h5>
                                    <p>Đặt sức khỏe và sự hài lòng của bệnh nhân lên hàng đầu.</p>
                                </div>
                            </div>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#aboutCarousel"
                            data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#aboutCarousel"
                            data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>

                    <!-- Nội dung giới thiệu -->
                    <div class="row align-items-center mb-5">
                        <div class="col-md-6">
                            <h3>Về chúng tôi</h3>
                            <p>
                                Bệnh viện LSB-163 được thành lập vào năm 2005, là một trong những cơ sở y tế hàng đầu
                                tại Việt Nam, chuyên cung cấp các dịch vụ chăm sóc sức khỏe chất lượng cao. Với sứ mệnh
                                "Chăm sóc sức khỏe, lan tỏa yêu thương", chúng tôi cam kết mang đến cho bệnh nhân những
                                trải nghiệm y tế tốt nhất thông qua đội ngũ y bác sĩ giàu kinh nghiệm và cơ sở vật chất
                                hiện đại.
                            </p>
                            <p>
                                Chúng tôi tự hào có các chuyên khoa mũi nhọn như tim mạch, thần kinh, nhi khoa, và ngoại
                                khoa, cùng với các dịch vụ hỗ trợ như xét nghiệm, chẩn đoán hình ảnh, và phục hồi chức
                                năng. Bệnh viện LSB-163 luôn đặt bệnh nhân làm trung tâm, đảm bảo mọi người đều nhận
                                được sự chăm sóc tận tình và chu đáo.
                            </p>
                            <a href="#contact" class="btn btn-primary">Liên hệ ngay</a>
                        </div>
                        <div class="col-md-6">
                            <img src="https://static.baovanhoa.vn/zoom/750_500/Portals/0/EasyGalleryImages/1/72032/z4992345019545_594fc3a60e71dcf3240f59cd59f1ab3f.jpg"
                                class="img-fluid rounded shadow" alt="Bệnh viện LSB-163">
                        </div>
                    </div>

                    <!-- Điểm nổi bật -->
                    <h3 class="text-center mb-4">Điểm nổi bật của chúng tôi</h3>
                    <div class="row">
                        <div class="col-md-4 mb-4">
                            <div class="card about-card text-center p-4 border-0 shadow-sm">
                                <i class="fas fa-hospital fa-3x text-primary mb-3"></i>
                                <h5>Cơ sở vật chất hiện đại</h5>
                                <p>Trang bị các thiết bị y tế tiên tiến nhất, đảm bảo chẩn đoán và điều trị chính xác.
                                </p>
                            </div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="card about-card text-center p-4 border-0 shadow-sm">
                                <i class="fas fa-user-md fa-3x text-primary mb-3"></i>
                                <h5>Đội ngũ chuyên gia</h5>
                                <p>Đội ngũ bác sĩ và nhân viên y tế được đào tạo chuyên sâu, tận tâm với bệnh nhân.</p>
                            </div>
                        </div>
                        <div class="col-md-4 mb-4">
                            <div class="card about-card text-center p-4 border-0 shadow-sm">
                                <i class="fas fa-heartbeat fa-3x text-primary mb-3"></i>
                                <h5>Chăm sóc toàn diện</h5>
                                <p>Cung cấp dịch vụ chăm sóc sức khỏe toàn diện, từ chẩn đoán đến phục hồi.</p>
                            </div>
                        </div>
                    </div>

                    <!-- Sứ mệnh và tầm nhìn -->
                    <div class="row mt-5">
                        <div class="col-md-6">
                            <h4><i class="fas fa-bullseye me-2 text-primary"></i> Sứ mệnh</h4>
                            <p>
                                Chúng tôi cam kết mang đến dịch vụ y tế chất lượng cao, đặt sức khỏe và sự hài lòng của
                                bệnh nhân lên hàng đầu. Bệnh viện LSB-163 không ngừng cải tiến để trở thành nơi gửi gắm
                                niềm tin của mọi gia đình.
                            </p>
                        </div>
                        <div class="col-md-6">
                            <h4><i class="fas fa-eye me-2 text-primary"></i> Tầm nhìn</h4>
                            <p>
                                Trở thành bệnh viện hàng đầu tại Việt Nam và khu vực, tiên phong trong việc ứng dụng
                                công nghệ y tế hiện đại và xây dựng môi trường chăm sóc sức khỏe thân thiện, nhân văn.
                            </p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Dịch vụ -->
            <section id="services" class="py-5 bg-light">
                <div class="container">
                    <h2 class="text-center mb-4 section-title">Dịch vụ</h2>
                    <div class="row">
                        <div class="col-md-4 text-center">
                            <i class="fas fa-stethoscope fa-3x text-primary mb-3"></i>
                            <h5>Khám chuyên khoa</h5>
                            <p>Đội ngũ bác sĩ chuyên môn cao, hỗ trợ khám và điều trị các bệnh lý phức tạp.</p>
                        </div>
                        <div class="col-md-4 text-center">
                            <i class="fas fa-x-ray fa-3x text-primary mb-3"></i>
                            <h5>Chẩn đoán hình ảnh</h5>
                            <p>Công nghệ tiên tiến với máy móc hiện đại, đảm bảo kết quả chính xác.</p>
                        </div>
                        <div class="col-md-4 text-center">
                            <i class="fas fa-ambulance fa-3x text-primary mb-3"></i>
                            <h5>Cấp cứu 24/7</h5>
                            <p>Dịch vụ cấp cứu nhanh chóng, sẵn sàng hỗ trợ mọi lúc, mọi nơi.</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Đội ngũ bác sĩ -->
            <section id="doctors" class="py-5">
                <div class="container">
                    <h2 class="text-center mb-4 section-title">Đội ngũ bác sĩ</h2>
                    <div class="row">
                        <c:forEach var="doctor" items="${doctors}">
                            <div class="col-md-4 mb-4">
                                <div class="card doctor-card">
                                    <img src="https://anhcute.net/wp-content/uploads/2024/10/Hinh-chibi-bac-si-nhan-vat-hoat-hinh-cute.jpg"
                                        class="card-img-top" alt="${doctor.name}">
                                    <div class="card-body text-center">
                                        <h5 class="card-title">${doctor.name}</h5>
                                        <p class="card-text">${doctor.specialty}</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>

            <!-- Phần xem lại lịch hẹn -->
            <section id="check-appointment" class="py-5">
                <div class="container">
                    <h2 class="text-center mb-4 section-title">Xem lại Lịch hẹn của tôi</h2>
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <div class="card p-4">
                                <div class="mb-3">
                                    <label for="patientNameInput" class="form-label">Tên bệnh nhân:</label>
                                    <input type="text" class="form-control" id="patientNameInput" placeholder="Nhập tên của bạn">
                                </div>
                                <div class="mb-3">
                                    <label for="appointmentIdInput" class="form-label">Mã lịch hẹn:</label>
                                    <input type="text" class="form-control" id="appointmentIdInput" placeholder="Nhập mã lịch hẹn">
                                </div>
                                <button id="findAppointmentsBtn" class="btn btn-primary">Tìm lịch hẹn</button>
                                <div id="searchResults" class="mt-4"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Liên hệ -->
           <jsp:include page="../layout/footer.jsp"/>
        <jsp:include page="../layout/chatbot.jsp"/>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                document.getElementById('findAppointmentsBtn').addEventListener('click', function() {
                    const patientName = document.getElementById('patientNameInput').value.trim();
                    const appointmentId = document.getElementById('appointmentIdInput').value.trim();
                    
                    if (!patientName || !appointmentId) {
                        alert('Vui lòng nhập tên và mã lịch hẹn.');
                        return;
                    }

                    try {
                        const encodedName = encodeURIComponent(patientName);
                        const url = '/appointments/confirm/' + appointmentId + '?name=' + encodedName;
                        window.location.href = url;
                    } catch (error) {
                        console.error('Lỗi khi xử lý URL:', error);
                        alert('Có lỗi xảy ra khi tìm kiếm lịch hẹn. Vui lòng thử lại.');
                    }
                });
            </script>
        </body>

        </html>