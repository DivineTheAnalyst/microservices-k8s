FROM golang:1.23-alpine 

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o shippingservice .

EXPOSE 8081

CMD ["./shippingservice"]