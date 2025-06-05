FROM python:3.11-alpine

WORKDIR /app

# Install build tools and dependencies
RUN apk add --no-cache gcc musl-dev libffi-dev g++ make

# Add this line before installing requirements.txt
#RUN pip install protobuf==3.20.3

# Or add this line after installing requirements.txt to downgrade

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

RUN pip install langgraph

RUN pip install --force-reinstall protobuf==3.20.3

COPY . .

EXPOSE 8085

CMD ["python", "shoppingassistantservice.py"]