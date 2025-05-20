<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác nhận Lịch hẹn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .confirmation-container { max-width: 600px; margin-top: 50px; padding: 30px; background-color: #fff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

<div class="container">
    <div class="confirmation-container mx-auto">
        <h1 class="text-center mb-4 text-success">Đặt lịch hẹn thành công!</h1>

        <p>Cảm ơn bạn đã đặt lịch hẹn. Dưới đây là thông tin chi tiết:</p>

        <ul class="list-group mb-4">
            <li class="list-group-item"><strong>Mã lịch hẹn:</strong> <span id="appointment-id">${appointment.id}</span></li>
            <li class="list-group-item"><strong>Tên bệnh nhân:</strong> ${appointment.name}</li>
            <li class="list-group-item"><strong>Bác sĩ:</strong> ${appointment.doctor.name}</li>
            <li class="list-group-item"><strong>Ngày hẹn:</strong> ${appointment.appointmentDate}</li>
            <li class="list-group-item"><strong>Trạng thái:</strong> <span id="appointment-status" class="badge bg-warning">
                <c:choose>
                    <c:when test="${appointment.status eq 'PENDING'}">Chờ xử lý</c:when>
                    <c:when test="${appointment.status eq 'ACCEPTED'}">Đã chấp nhận</c:when>
                    <c:when test="${appointment.status eq 'REJECTED'}">Đã từ chối</c:when>
                    <c:otherwise>${appointment.status}</c:otherwise>
                </c:choose> <!-- Fallback if status is not recognized -->
            </span></li>
        </ul>

        <p>Chúng tôi sẽ xử lý yêu cầu của bạn sớm nhất có thể. Bạn có thể giữ trang này để theo dõi trạng thái hoặc quay lại sau.</p>

        <div class="text-center">
            <a href="/" class="btn btn-primary mt-3">Về trang chủ</a>
        </div>
    </div>
</div>

<script>
    // JavaScript polling sẽ được thêm vào đây sau
    const appointmentId = document.getElementById('appointment-id').innerText;
    const statusElement = document.getElementById('appointment-status');
    let currentStatus = statusElement.innerText.trim();

    function updateStatusDisplay(status) {
        const statusMap = {
            'PENDING': 'Chờ xử lý',
            'ACCEPTED': 'Đã chấp nhận',
            'REJECTED': 'Đã từ chối'
        };
        statusElement.innerText = statusMap[status] || status; // Use mapped text or fallback to original
        statusElement.classList.remove('bg-warning', 'bg-success', 'bg-danger');
        if (status === 'PENDING') {
            statusElement.classList.add('bg-warning');
        } else if (status === 'ACCEPTED') {
            statusElement.classList.add('bg-success');
        } else if (status === 'REJECTED') {
            statusElement.classList.add('bg-danger');
        }
    }

    function checkAppointmentStatus() {
        if (currentStatus === 'ACCEPTED' || currentStatus === 'REJECTED') {
            // Dừng polling nếu trạng thái đã được cập nhật cuối cùng
            clearInterval(pollingInterval);
            return;
        }

        const appointmentId = document.getElementById('appointment-id').innerText.trim(); // Ensure trimming
        console.log('Fetching status for appointment ID:', appointmentId);

        fetch(`${window.location.origin}/api/appointment/status/${appointmentId}`)
            .then(response => {
                if (!response.ok) {
                    // Xử lý lỗi nếu không lấy được trạng thái
                    console.error('Failed to fetch appointment status:', response.status);
                    // Có thể dừng polling hoặc thử lại tùy vào logic mong muốn
                     clearInterval(pollingInterval);
                     return Promise.reject('Failed to fetch status');
                }
                return response.json();
            })
            .then(data => {
                const newStatus = data.status;
                if (newStatus !== currentStatus) {
                    // Trạng thái đã thay đổi, cập nhật giao diện và thông báo
                    updateStatusDisplay(newStatus);
                    if (newStatus === 'ACCEPTED') {
                        alert('Thông báo: Lịch hẹn của bạn đã được chấp nhận!');
                    } else if (newStatus === 'REJECTED') {
                        alert('Thông báo: Lịch hẹn của bạn đã bị từ chối.');
                    }
                    currentStatus = newStatus;

                    // Nếu trạng thái cuối cùng, dừng polling
                    if (currentStatus === 'ACCEPTED' || currentStatus === 'REJECTED') {
                        clearInterval(pollingInterval);
                    }
                }
            })
            .catch(error => {
                console.error('Error fetching appointment status:', error);
                // Dừng polling khi có lỗi
                clearInterval(pollingInterval);
            });
    }

    // Bắt đầu polling mỗi 5 giây (5000 miligiây)
    const pollingInterval = setInterval(checkAppointmentStatus, 5000);

    // Dừng polling khi người dùng rời khỏi trang
    window.addEventListener('beforeunload', function() {
        clearInterval(pollingInterval);
    });

    // Thực hiện kiểm tra trạng thái lần đầu ngay khi tải trang
    checkAppointmentStatus();
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 