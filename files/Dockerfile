FROM node:alpine

WORKDIR /app
COPY ./app/package.json ./app/yarn.lock /app/
COPY ./server.sh /app/
RUN chmod +x ./server.sh
RUN yarn install
COPY ./app /app/
EXPOSE 3000
CMD ["bash", "-c", "./server.sh"]
