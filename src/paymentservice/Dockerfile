FROM node:18-alpine

RUN apk add --update --no-cache \
    python3 \
    make \
    g++

WORKDIR /app

COPY package*.json ./

RUN npm install 

COPY . .

EXPOSE 3002

CMD ["npm", "start"]