from flask import Flask, request, jsonify
import pandas as pd
import random # Import random for placeholder response

app = Flask(__name__)

# Load the dataset
try:
    df = pd.read_csv('dataset.csv')
    print("Dataset loaded successfully.")
except FileNotFoundError:
    print("Error: dataset.csv not found.")
    df = None # Handle case where file is not found

@app.route('/chat', methods=['POST'])
def chat():
    if df is None:
        return jsonify({"response": "Error loading dataset."}), 500

    user_message = request.json.get('message')
    if not user_message:
        return jsonify({"response": "No message provided."}), 400

    # --- Placeholder for KNN logic ---
    # In a real implementation, you would use KNN to find the closest question
    # and return the corresponding answer.
    # For now, we'll just return a random answer from the dataset.
    if not df.empty:
        random_row = df.sample(1).iloc[0]
        bot_response = random_row['answer']
    else:
        bot_response = "Xin lỗi, tôi không tìm thấy câu trả lời phù hợp."
    # --- End Placeholder ---

    print(f"Received message: {user_message}")
    print(f"Sending response: {bot_response}")

    return jsonify({"response": bot_response})

if __name__ == '__main__':
    # Consider running with debug=False in production
    app.run(debug=True, port=5000) 