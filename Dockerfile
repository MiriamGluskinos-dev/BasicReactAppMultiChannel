# Use the custom base image you already pulled
FROM bayesimpact/react-base:latest

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json first to leverage Docker layer caching
COPY package.json package-lock.json ./

# Copy the local packages directory (where the .tgz files are)
COPY ./packages /app/packages/

# Copy the .npmrc file to configure npm registry (auth tokens, etc.)
COPY .npmrc /app/.npmrc

# Install dependencies
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Expose the port for the React app
EXPOSE 3000

# Run the React app
CMD ["npm", "start"]