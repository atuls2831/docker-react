# initialise starting point - as builder specified all the steps below as builder phase
FROM node:alpine as builder

#Setup work directory
WORKDIR /app

#copy package file
COPY package.json .

RUN npm install 

COPY . .

RUN npm run build

# configuration for RUN phase. Use of FROM suggest that this is new block
FROM ngix 
# Copy file from previous phase to be posted to ngix folder
COPY --from=builder /app/build /usr/share/ngix/html
