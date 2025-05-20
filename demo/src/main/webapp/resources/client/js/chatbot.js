document.addEventListener("DOMContentLoaded", () => {
    const chatbot = document.getElementById("chatbot");
    const toggleBtn = document.getElementById("chatbot-toggle");
    const closeBtn = document.getElementById("chatbot-close");
    const minimizeBtn = document.getElementById("chatbot-minimize");
    const input = document.getElementById("chat-input");
    const sendBtn = document.getElementById("send-message");
    const body = document.getElementById("chat-body");
  
    // Ensure all elements are found
    if (!chatbot || !toggleBtn || !closeBtn || !minimizeBtn || !input || !sendBtn || !body) {
        console.error("Chatbot elements not found!");
        return; // Stop if elements are missing
    }
  
    // Toggle chatbot visibility when the button is clicked
    toggleBtn.addEventListener("click", () => {
      chatbot.classList.toggle("d-none");
      if (!chatbot.classList.contains("d-none")) {
        input.focus();
      }
    });
  
    // Close chatbot when the close button is clicked
    closeBtn.addEventListener("click", () => {
      chatbot.classList.add("d-none");
    });

    // Minimize chatbot
    minimizeBtn.addEventListener("click", () => {
      chatbot.classList.add("minimized");
      chatbot.classList.add("d-none"); // Hide when minimized
      toggleBtn.classList.remove("d-none"); // Show toggle button
    });
  
    // Restore chatbot when toggle button is clicked while minimized
    toggleBtn.addEventListener("click", () => {
      if (chatbot.classList.contains("minimized")) {
        chatbot.classList.remove("minimized");
        chatbot.classList.remove("d-none");
        toggleBtn.classList.add("d-none");
        input.focus();
      }
    });
  
    // Function to add a message to the chat
    function addMessage(message, isUser = false) {
      const messageDiv = document.createElement("div");
      messageDiv.className = `chat-message ${isUser ? 'user' : 'bot'}`;
      
      // Simplified message structure based on recent jsp changes
      messageDiv.innerHTML = `
        <div class="message-content">${message}</div>
      `;
      
      body.appendChild(messageDiv);
      body.scrollTop = body.scrollHeight; // Auto-scroll to the latest message
    }

    // Function to send message
    async function sendMessage() {
      const userMessage = input.value.trim();
      if (userMessage === "") return;

      addMessage("Bạn: " + userMessage, true);
      input.value = ""; // Clear input after sending

      try {
        const response = await fetch("/api/chat", {
          method: "POST",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify({ message: userMessage })
        });

        if (response.ok) {
          const data = await response.json();
          addMessage(data.response, false); // Add bot's response
        } else {
          addMessage("Bot: Lỗi khi gửi tin nhắn đến bot.", false);
          console.error("Error sending message:", response.status, response.statusText);
        }
      } catch (error) {
        addMessage("Bot: Lỗi kết nối đến dịch vụ chatbot.", false);
        console.error("Error fetching chatbot response:", error);
      }
    }
  
    // Send message on button click
    sendBtn.addEventListener("click", (event) => {
        event.preventDefault(); // Prevent default form submission if button is inside a form
        sendMessage();
    });

    // Send message on Enter key press
    input.addEventListener("keypress", (event) => {
      if (event.key === "Enter") {
        event.preventDefault(); // Prevent default form submission
        sendMessage();
      }
    });

    // Initial bot message (optional)
    // addMessage("Bot: Xin chào! Tôi có thể giúp gì cho bạn?", false);
});
  