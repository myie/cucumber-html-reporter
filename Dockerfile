FROM node:9-alpine

WORKDIR /use/src/app

# use npm install to ensure dependencies are present
COPY . .
RUN npm install

# we'll provide the input and output location(s) as volumes
CMD [ "npm", "start" ]
