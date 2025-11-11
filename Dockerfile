# 1. Chọn base image Python
FROM python:3.9-slim

# 2. Cài một số gói hệ thống cơ bản
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 3. Đặt thư mục làm việc
WORKDIR /app

# 4. Copy file requirements và cài thư viện
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy toàn bộ source code vào container
COPY . .

# 6. Expose port cho Streamlit (thường là 8501)
EXPOSE 8503

# 7. Lệnh chạy app Streamlit khi container start
#   - Thay "app.py" bằng tên file app của Sếp nếu khác
CMD ["streamlit", "run", "app.py", "--server.port=8503", "--server.address=0.0.0.0"]
