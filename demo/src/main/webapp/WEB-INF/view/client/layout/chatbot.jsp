<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath}/resources/client/images/favicon.ico" type="image/x-icon">

<!-- Chatbot Toggle Button -->
<button id="chatbot-toggle" class="btn btn-primary rounded-circle shadow" style="position: fixed; bottom: 20px; right: 20px; z-index: 1001; width: 60px; height: 60px; font-size: 24px;">
    <i class="fas fa-comments"></i>
</button>

<!-- Chatbot Box -->
<div id="chatbot" class="chatbot d-none">
    <div class="chat-header d-flex justify-content-between align-items-center px-3 py-2">
        <div class="d-flex align-items-center">
            <i class="fas fa-robot rounded-circle me-2" style="width: 40px; height: 40px; font-size: 24px; display: flex; align-items: center; justify-content: center; background-color: #eb4960; color: white;"></i>
            <div>
                <h6 class="mb-0">SmartCare Bot</h6>
                <small class="text-muted">Online</small>
            </div>
        </div>
        <div>
            <button id="chatbot-minimize" class="btn btn-link text-dark p-0 me-2">
                <i class="fas fa-minus"></i>
            </button>
            <button id="chatbot-close" class="btn btn-link text-dark p-0">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>
    <div class="chat-body px-3 py-2" id="chat-body">
        <%-- Initial bot message --%>
        <div class="chat-message bot">
             <i class="fas fa-robot message-avatar rounded-circle me-2" style="font-size: 24px; display: flex; align-items: center; justify-content: center; background-color: #eb4960; color: white;"></i>
            <div class="message-content-wrapper">
                <div class="message-content">
                    Xin chào! Tôi có thể giúp gì cho bạn hôm nay?
                </div>
                 <div class="message-time">Bây giờ</div>
            </div>
        </div>
    </div>
    <div class="chat-footer px-3 py-2">
        <div class="input-group">
             <button class="btn btn-link text-muted p-0 me-2"><i class="fas fa-microphone"></i></button>
             <button class="btn btn-link text-muted p-0 me-2"><i class="fas fa-image"></i></button>
             <button class="btn btn-link text-muted p-0 me-2"><i class="fas fa-smile"></i></button>
             <button class="btn btn-link text-muted p-0 me-2"><i class="fas fa-gift"></i></button>
            <input type="text" id="chat-input" placeholder="Nhập tin nhắn..." class="form-control border-0 rounded-pill flex-grow-1 mx-2">
             <button class="btn btn-link text-muted p-0 me-2"><i class="fas fa-heart"></i></button>
            <button class="btn btn-primary rounded-circle" id="send-message" style="width: 38px; height: 38px; display: flex; align-items: center; justify-content: center;">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    </div>
</div>

<style>
.chatbot {
    position: fixed;
    bottom: 90px;
    right: 20px;
    width: 350px;
    height: 500px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    z-index: 1000;
    display: flex;
    flex-direction: column;
    overflow: hidden;
}

.chat-header {
    background: #f0f2f5;
    color: #050505;
    padding: 10px 15px;
    border-bottom: 1px solid #e4e6eb;
}

.chat-body {
    flex: 1;
    overflow-y: auto;
    padding: 15px;
    background-color: #f0f2f5;
}

.chat-footer {
    background: white;
    border-top: 1px solid #e4e6eb;
    padding: 10px;
}

.chat-message {
    margin: 5px 0;
    display: flex; /* Use flexbox for avatar and message content */
    align-items: flex-end; /* Align items to the bottom */
    max-width: 100%;
}

.chat-message.user {
    justify-content: flex-start; /* User messages on the left */
}

.chat-message.bot {
    justify-content: flex-end; /* Bot messages on the right */
}

.message-avatar {
    width: 30px;
    height: 30px;
    object-fit: cover;
    align-self: flex-start; /* Align avatar to the top of the message group */
}

.chat-message.user .message-avatar {
    margin-right: 8px;
}

.chat-message.bot .message-avatar {
    margin-left: 8px;
    order: 2; /* Place avatar after message content for bot */
}

.message-content-wrapper {
    display: flex;
    flex-direction: column;
    max-width: calc(80% - 38px); /* Adjust max-width considering avatar */
}

.chat-message.bot .message-content-wrapper {
     align-items: flex-end; /* Align content and time to the right for bot */
}

.message-content {
    padding: 8px 12px;
    border-radius: 18px; /* Default rounded corners */
    margin: 2px 0;
    word-wrap: break-word;
    max-width: 100%; /* Ensure content fits within the bubble */
}

.user .message-content {
    background-color: #e4e6eb; /* Light grey/pink for user as in the image */
    color: #050505; /* Dark text for user */
    border-top-left-radius: 4px; /* Less rounded on the side closest to sender */
    border-top-right-radius: 18px; /* Fully rounded opposite corner */
    border-bottom-left-radius: 18px; /* Fully rounded opposite corner */
    border-bottom-right-radius: 18px; /* Fully rounded opposite corner */
}

.bot .message-content {
    background-color: #eb4960; /* Red/pink color for bot as in the image */
    color: white; /* White text for bot */
    border-top-left-radius: 18px; /* Fully rounded opposite corner */
    border-top-right-radius: 4px; /* Less rounded on the side closest to sender */
    border-bottom-left-radius: 18px; /* Fully rounded opposite corner */
    border-bottom-right-radius: 18px; /* Fully rounded opposite corner */
}

.message-time {
    font-size: 0.75rem;
    color: #65676b;
    margin: 2px 8px; /* Adjust margin to align with bubble */
    align-self: flex-end; /* Align time to the right for both */
}

.chat-message.user .message-time {
     align-self: flex-start; /* Align time to the left for user */
}

#chat-input {
    background: #f0f2f5;
    border-radius: 20px;
    padding: 8px 15px;
}

#chat-input:focus {
    box-shadow: none;
    background: #e4e6eb;
}

#send-message {
    background: #0084ff; /* Messenger blue send button */
    border: none;
}

#chatbot-toggle {
    background: #0084ff;
    border: none;
    transition: transform 0.2s;
}

#chatbot-toggle:hover {
    transform: scale(1.1);
}

.btn-link {
    color: #65676b; /* Dark grey for icons */
    text-decoration: none;
}

.btn-link:hover {
    color: #050505; /* Darker grey on hover */
}

.input-group .form-control {
    border-radius: 20px !important; /* Ensure rounded corners on input */
}

.input-group .btn {
    z-index: 3; /* Ensure buttons are clickable */
}
</style>