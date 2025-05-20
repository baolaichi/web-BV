from flask import Flask, request, jsonify
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.neighbors import NearestNeighbors
import re
import os

app = Flask(__name__)

# Load data
# Adjust the path if dataset.csv is not in the same directory
DATASET_PATH = 'chatbot/dataset.csv'
df = None # Initialize df to None

try:
    df = pd.read_csv(DATASET_PATH)
    print("Dataset loaded successfully.")
except FileNotFoundError:
    print(f"Error: Dataset file not found at {DATASET_PATH}")
except Exception as e:
    print(f"Error loading or processing dataset: {e}")

# Preprocessing function
def preprocess_text(text):
    if isinstance(text, str):
        text = text.lower()
        # Remove special characters, keeping Vietnamese accents (basic approach)
        text = re.sub(r'[^\sa-z0-9àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ]', '', text)
        # Remove extra whitespaces
        text = re.sub(r'\s+', ' ', text).strip()
        return text
    return "" # Return empty string for non-string input

# Initialize TF-IDF Vectorizer and KNN model outside of request handling
tfidf_vectorizer = None
knn_model = None

# Check if the dataset was loaded and process it for KNN
if df is not None and not df.empty and 'question' in df.columns and 'answer' in df.columns:
    # Apply preprocessing to the 'question' column
    df['processed_question'] = df['question'].apply(preprocess_text)

    # Check if 'processed_question' column is not empty after preprocessing
    if not df['processed_question'].empty:
        tfidf_vectorizer = TfidfVectorizer()
        tfidf_matrix = tfidf_vectorizer.fit_transform(df['processed_question'])

        # Initialize and fit KNN model
        knn_model = NearestNeighbors(n_neighbors=1, algorithm='auto', metric='cosine')
        knn_model.fit(tfidf_matrix)
        print("KNN model trained successfully.")
    else:
        print("Warning: 'processed_question' column is empty after preprocessing. Cannot train KNN model.")
else:
    print("Error: Dataset not loaded, is empty, or missing required columns ('question', 'answer'). KNN model not trained.")

def get_response(user_input):
    if tfidf_vectorizer is None or knn_model is None:
        return "Xin lỗi, hệ thống chatbot chưa sẵn sàng. Vui lòng thử lại sau."

    processed_input = preprocess_text(user_input)

    # Handle empty processed message after preprocessing
    if not processed_input:
         return "Tôi có thể giúp gì cho bạn?"

    try:
        # Transform the user message using the trained TF-IDF vectorizer
        user_tfidf = tfidf_vectorizer.transform([processed_input])

        # Find the nearest neighbor (most similar question)
        # Set a threshold for the distance
        DISTANCE_THRESHOLD = 0.2 # Adjust this value as needed
        distances, indices = knn_model.kneighbors(user_tfidf, n_neighbors=1)

        # Check if the nearest neighbor is within the distance threshold
        if distances[0][0] < DISTANCE_THRESHOLD:
            # Get the answer for the nearest question
            response_answer = df.iloc[indices[0][0]]['answer']
            return response_answer
        else:
            # If the nearest neighbor is too far, return a default response
            return "Xin lỗi, tôi không hiểu câu hỏi của bạn. Bạn có thể hỏi lại theo cách khác được không?"

    except Exception as e:
        # Log the error and return an internal server error
        print(f"An error occurred during chatbot processing: {e}")
        return "Xin lỗi, tôi gặp sự cố khi xử lý yêu cầu của bạn."

@app.route('/chat', methods=['POST'])
def chat():
    # Check if the request contains JSON data and the 'message' field
    if not request.json or 'message' not in request.json:
        return jsonify({"response": "Invalid input: 'message' field is required in JSON body"}), 400

    user_message = request.json['message']
    bot_response = get_response(user_message)
    return jsonify({'response': bot_response}), 200

if __name__ == '__main__':
    # Ensure the dataset file exists before running the app and that df was loaded
    if df is not None:
        # Run the Flask app
        print(f"Starting Flask chatbot API. Ensure '{DATASET_PATH}' exists and is correctly formatted.")
        # Use 0.0.0.0 to make the server accessible externally if needed, or keep 127.0.0.1 for local only
        app.run(port=5000, debug=True, host='127.0.0.1')
    else:
        print("Flask app not started due to dataset loading or processing errors.")
