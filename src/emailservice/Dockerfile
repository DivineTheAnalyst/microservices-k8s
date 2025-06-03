FROM python:3.11-alpine

WORKDIR /app

# Install build tools and dependencies
RUN apk add --no-cache gcc musl-dev libffi-dev g++ make

COPY requirements.txt ./

RUN pip install -r requirements.txt

COPY . .

EXPOSE 5001

CMD ["python", "email_server.py"]