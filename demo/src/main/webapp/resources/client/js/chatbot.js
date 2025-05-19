document.addEventListener("DOMContentLoaded", () => {
    const chatbot = document.getElementById("chatbot");
    const toggleBtn = document.getElementById("chatbot-toggle");
    const closeBtn = document.getElementById("chatbot-close");
    const input = document.getElementById("chat-input");
    const body = document.getElementById("chat-body");
  
    // Toggle chatbot visibility when the button is clicked
    toggleBtn.addEventListener("click", () => {
      chatbot.classList.toggle("d-none");
    });
  
    // Close chatbot when the close button is clicked
    closeBtn.addEventListener("click", () => {
      chatbot.classList.add("d-none");
    });
  
    // Handle user input in the chatbot
    input.addEventListener("keypress", function (e) {
      if (e.key === "Enter" && input.value.trim() !== "") {
        const userMsg = input.value.trim();
        const reply = "Cảm ơn bạn! Chúng tôi sẽ liên hệ sớm.";
        
        // Thêm tin nhắn của người dùng
        const userMessageDiv = document.createElement("div");
        userMessageDiv.className = "chat-message user";
        userMessageDiv.innerHTML = `
          <div class="message-sender">Bạn</div>
          <div class="message-content">${userMsg}</div>
        `;
        body.appendChild(userMessageDiv);

        // Thêm tin nhắn của bot
        const botMessageDiv = document.createElement("div");
        botMessageDiv.className = "chat-message bot";
        botMessageDiv.innerHTML = `
          <div class="message-sender">Bot</div>
          <div class="message-content">${reply}</div>
        `;
        body.appendChild(botMessageDiv);

        input.value = "";
        body.scrollTop = body.scrollHeight;
      }
    });
  });
  