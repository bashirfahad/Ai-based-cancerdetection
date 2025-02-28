# 🏥 AI Cancer Detection App

![AI Cancer Detection]
![Frame 9 (1)](https://github.com/user-attachments/assets/edff8c0b-8dce-4946-9970-1964fe3b1de4)

*A cutting-edge AI-powered mobile application for detecting cancer from medical images.*

---

## 🚀 Overview
The **AI Cancer Detection App** is a **Flutter-based mobile application** that utilizes a **Convolutional Neural Network (CNN) AI model** hosted on **Google Colab** to detect cancer from medical images. Designed for **patients, doctors, and researchers**, this app aims to provide an efficient and accurate diagnosis tool with a user-friendly interface.

---

## ✨ Features
✅ **AI-Powered Image Analysis** – Detects cancer from uploaded medical images using a CNN model.  
✅ **Real-Time Processing** – Fast and accurate predictions using **TensorFlow** AI.  
✅ **Intuitive UI/UX** – Clean and minimalistic design for a seamless experience.  
✅ **Cloud-Hosted Model** – The AI model runs on **Google Colab**, ensuring high performance.  
✅ **Secure & Private** – User data is encrypted and protected.  
✅ **Cross-Platform** – Runs smoothly on **Android & iOS** using Flutter.  

---

## 🛠️ Tech Stack
- **Frontend:** Flutter (Dart)  
- **AI Model:** TensorFlow, CNN  
- **Backend:** Google Colab (Python)  
- **Design:** Figma  
- **State Management:** Provider / Riverpod  
- **Storage:** Firebase (for user authentication & image storage)  

---

## 📸 Screenshots
| Home Screen | AI Prediction | Result Screen |
|------------|--------------|--------------|
| ![Home] ![WhatsApp Image 2025-02-25 at 10 55 22 PM](https://github.com/user-attachments/assets/2b32acf2-c88b-4923-99d3-ac01da8766ff)
| ![Prediction] ![WhatsApp Image 2025-02-25 at 10 55 23 PM](https://github.com/user-attachments/assets/de3f5d05-1257-4733-b6c7-4a8158df6457)
| ![History] ![WhatsApp Image 2025-02-25 at 10 55 24 PM](https://github.com/user-attachments/assets/0b2a767c-6e54-4a95-aa3f-d66571dec89e)
|

---

## 🚀 Installation & Setup
### 🔹 Prerequisites
Ensure you have the following installed:
- **Flutter SDK** ([Install Flutter](https://flutter.dev/docs/get-started/install))
- **Dart SDK**
- **Android Studio / Xcode** (for running the app)
- **Google Colab Account** (for AI model access)

### 🔹 Steps to Run Locally
```sh
# Clone the repository
git clone https://github.com/your-username/ai-cancer-detection.git
cd ai-cancer-detection

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 🏗️ How It Works
1. **Upload** a medical image (X-ray, MRI, or CT scan).
2. The image is sent to the **CNN AI model** hosted on **Google Colab**.
3. AI processes the image and **predicts** the likelihood of cancer.
4. The result is displayed with a confidence score.
5. Users can **save reports** or share results with doctors.

---

## 🔗 API & Model Integration
The AI model is deployed on **Google Colab** and accessed via API:
- **Model:** Convolutional Neural Network (CNN)
- **Framework:** TensorFlow / Keras
- **API Endpoint:** Flask-based REST API hosted on Colab

To modify the model, update the **Google Colab notebook** and link it to the app:
```python
from flask import Flask, request, jsonify
import tensorflow as tf
import numpy as np
app = Flask(__name__)
model = tf.keras.models.load_model('model.h5')
@app.route('/predict', methods=['POST'])
def predict():
    # Process Image & Return Prediction
```

---

## 📌 Roadmap & Future Improvements
🔹 **Deploy AI Model on Firebase ML Kit** for better performance  
🔹 **Integrate Doctor Consultation Feature** for instant medical advice  
🔹 **Support More Cancer Types** by training the AI model with a diverse dataset  
🔹 **Offline Mode** – Allow predictions without internet access  

---

## 🏆 Contributors
👤 **Fahad Bashir** – *Founder & Lead Developer*  
📧 Email: [fahadbashir804@gmail.com](mailto:fahadbashir804@google.com)  
🔗 LinkedIn: https://www.linkedin.com/in/fahad-bashir-259798201/  

---

## 📜 License
This project is licensed under the **MIT License** – feel free to use and modify!  

🔗 **GitHub Repo:** [AI Cancer Detection](https://github.com/bashirfahad/ai-cancer-detection)
