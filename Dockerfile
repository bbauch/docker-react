#Build Phase
#builder means that everything in the FROM command and below is apart of the builder phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#/app/build will have all of the stuff we care about with all of our production assets

#Run Phase
FROM nginx
# copying over the result of the /app/build directory
COPY --from=builder /app/build /usr/share/nginx/html 
#default command of nginx container will start up nginx for you