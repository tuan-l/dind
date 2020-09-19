FROM node:alpine

WORKDIR /app
COPY package.json yarn.lock /app/
COPY ./server.sh /app/
RUN chmod +x ./server.sh
RUN yarn install
COPY ./app /app/
EXPOSE 3000
CMD ["bash", "-c", "./server.sh"]
