# Use an official Node.js runtime as the base image
FROM node:14 as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build


FROM node:14-alpine
WORKDIR /app
# Copy the build output from the previous stage to this stage
COPY --from=build /app/build ./build
# Install a simple HTTP server to serve the React application
RUN npm install -g serve
EXPOSE 80
CMD ["serve", "-s", "build", "-l", "80"]
