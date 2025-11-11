# 1. Chọn image Python nhẹ
FROM python:3.9-slim

# 2. Cài gói hệ thống: Tesseract, Poppler, Chromium, ChromeDriver, v.v.
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    poppler-utils \
    chromium \
    chromium-driver \
    libglib2.0-0 \
    libnss3 \
    libgconf-2-4 \
    libxss1 \
    libasound2 \
    libx11-6 \
    fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

# 3. Đặt thư mục làm việc
WORKDIR /app

# 4. Copy file requirements và cài thư viện Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy toàn bộ source code vào container
COPY . .

# 6. Mở port cho Streamlit (mặc định 8501)
EXPOSE 8501

# 7. Lệnh chạy app Streamlit
#    Nếu file chính không phải app.py thì Sếp đổi lại tên file
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
