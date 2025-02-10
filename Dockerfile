# Use AWS Lambda base image for Node.js 18
FROM public.ecr.aws/lambda/nodejs:18

# Set working directory
WORKDIR /var/task

# Copy shared package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Function to be overridden at build time
ARG FUNCTION_DIR
COPY ${FUNCTION_DIR}/index.js ./ 

# Set Lambda function entry point (must be overridden)
CMD ["index.handler"]
