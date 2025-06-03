FROM python:3.11-alpine

WORKDIR /app

# Install build tools and dependencies
RUN apk add --no-cache gcc musl-dev libffi-dev g++ make

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5002

CMD ["python", "recommendation_server.py"]