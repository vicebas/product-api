# Product API

This project contains the source code and supporting files for a **serverless application** deployed using the **AWS Serverless Application Model (AWS SAM)**. It leverages AWS Lambda, API Gateway, and Amazon Cognito for authentication. The deployment process is streamlined using **Docker** and **Makefile commands**.

## 📂 Project Structure

- `lambdas/` - Contains the code for the application's AWS Lambda functions.
- `template.yaml` - Defines the AWS infrastructure using **AWS SAM**.
- `Makefile` - Provides a set of commands to **build, push, and deploy** the application efficiently.

## 🚀 Prerequisites

Ensure you have the following tools installed before proceeding:

- **AWS SAM CLI** - [Install the AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html).
- **Node.js (v18)** - [Download Node.js 18](https://nodejs.org/en/) (includes npm for package management).
- **Docker** - [Install Docker](https://hub.docker.com/search/?type=edition&offering=community) for building and packaging Lambda functions.
- **AWS CLI** - [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) and configure your AWS credentials.

## 🔧 Configuration

Before deploying, create a `.env` file in the root directory with the following:

```ini
AWS_REGION=us-east-1
AWS_ACCOUNT_ID=123456789012
```

Replace `AWS_ACCOUNT_ID` with your **AWS Account ID**.

## 📦 Deployment Guide

### 1️⃣ **Create the ECR Repository**

If the Elastic Container Registry (ECR) repository does not already exist, create it with:

```bash
make create-repo
```

### 2️⃣ **Build the Docker Images**

Build the Lambda function Docker images:

```bash
make build
```

### 3️⃣ **Push the Images to AWS ECR**

After building the images, push them to your AWS ECR repository:

```bash
make push
```

### 4️⃣ **Deploy the Application**

To deploy the application using AWS SAM, run:

```bash
make sam-deploy
```

Alternatively, to automate the entire process (**build → push → deploy**), run:

```bash
make deploy
```

### 5️⃣ **Update Lambda Functions** (Optional)

To update the deployed Lambda functions with the latest Docker images, run:

```bash
make update-lambda
```

## 🛠 Available Makefile Commands

| Command        | Description                                        |
|--------------|------------------------------------------------|
| `create-repo` | Creates the ECR repository if it doesn’t exist. |
| `build`      | Builds the Docker images for the Lambda functions. |
| `push`       | Pushes the built Docker images to AWS ECR. |
| `deploy`     | Builds, pushes, and deploys the application. |
| `update-lambda` | Updates Lambda functions with the latest images. |
| `sam-deploy` | Deploys the application using AWS SAM. |

## 📡 API Endpoints

Once deployed, the API Gateway URL is available in AWS CloudFormation outputs.
You can retrieve it by running:

```bash
aws cloudformation describe-stacks --stack-name product-api --query "Stacks[0].Outputs"
```

## 📝 Notes

- The API requires **Cognito authentication** for secured endpoints.
- Logs for API Gateway and Lambda functions are available in **AWS CloudWatch**.
- Modify `template.yaml` to add or update AWS resources.

