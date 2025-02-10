# Product API

This project contains source code and supporting files for a serverless application that you can deploy with the AWS Serverless Application Model (AWS SAM) command line interface (CLI). It includes the following files and folders:

- `lambdas` - Code for the application's Lambda functions.
- `template.yaml` - A template that defines the application's AWS resources.

The application uses several AWS resources, including Lambda functions, an API Gateway API, and Amazon Cognito for user authentication. These resources are defined in the `template.yaml` file in this project. You can update the template to add AWS resources through the same deployment process that updates your application code.

## Prerequisites

To use the AWS SAM CLI, you need the following tools:

- AWS SAM CLI - [Install the AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html).
- Node.js - [Install Node.js 18](https://nodejs.org/en/), including the npm package management tool.
- Docker - [Install Docker community edition](https://hub.docker.com/search/?type=edition&offering=community).

## Deploy the Application

First, set up the `.env` file with the following content:

```
AWS_REGION=us-east-1
AWS_ACCOUNT_ID=123241535



eplace `your-s3-bucket-name` with the name of your S3 bucket.

## Makefile Commands

The [`Makefile`](Makefile ) in this project provides a convenient way to build, push, and deploy your application. Here are the available commands:

- `create-repo`: Creates the ECR repository if it does not already exist.
- `build`: Builds the Docker images for the Lambda functions.
- `push`: Pushes the Docker images to the ECR repository.
- `deploy`: Builds, pushes, and deploys the application using AWS SAM.
- `update-lambda`: Updates the Lambda functions with the latest Docker images.
- `sam-deploy`: Deploys the application using AWS SAM.

### Usage

To create the ECR repository:

```bash
make create-repo


To build the Docker images:]

```bash
make build

To push the Docker images to ECR:
```bash
make push

To deploy the application:
```bash
make sam-deploy


To deploy the entire aplication from building the images to deploying the stack you can run:
```bash
 make deploy


