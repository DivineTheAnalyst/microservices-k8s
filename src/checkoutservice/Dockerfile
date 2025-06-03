FROM golang:1.23-alpine

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o /app/checkoutservice 

EXPOSE 5050

CMD ["/app/checkoutservice"]

