 <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Chatbot Toggle Button -->
  <button id="chatbot-toggle" class="btn btn-primary rounded-circle shadow" style="position: fixed; bottom: 20px; right: 20px; z-index: 1001;">
    💬
  </button>

  <!-- Chatbot Box -->
  <div id="chatbot" class="chatbot d-none">
    <div class="chat-header d-flex justify-content-between align-items-center px-3 py-2 bg-primary text-white">
      <span>🤖 SmartCare Bot</span>
      <button id="chatbot-close" class="btn-close btn-close-white btn-sm"></button>
    </div>
    <div class="chat-body px-3 py-2" id="chat-body">
      Xin chào! Tôi có thể giúp gì cho bạn hôm nay?
    </div>
    <input type="text" id="chat-input" placeholder="Nhập câu hỏi..." class="chat-input px-2 py-2">
  </div>