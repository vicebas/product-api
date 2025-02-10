AWS_REGION=$(shell grep AWS_REGION .env | cut -d '=' -f2)
AWS_ACCOUNT_ID=$(shell grep AWS_ACCOUNT_ID .env | cut -d '=' -f2)
ECR_REPO=product-api-repository

# Function Names
FUNCTIONS = getAllProducts getProductById signUp signIn confirmUser


# Build, Push, and Deploy Everything
.PHONY: create-repo build push deploy update-lambda

create-repo:
	@echo "Creating ECR Repository..."
	aws ecr create-repository --repository-name $(ECR_REPO) || true

build:
	@echo "Building Docker images..."
	@for function in $(FUNCTIONS); do \
	    echo "Building $$function..."; \
		LOWER_FUNCTION=$$(echo $$function | tr '[:upper:]' '[:lower:]'); \
		docker build --build-arg FUNCTION_DIR=lambdas/$$function -t $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(ECR_REPO):$$LOWER_FUNCTION .; \
	done

push:
	@echo "Logging into AWS ECR..."
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com
	@echo "Pushing Docker images to AWS ECR..."
	@for function in $(FUNCTIONS); do \
		LOWER_FUNCTION=$$(echo $$function | tr '[:upper:]' '[:lower:]'); \
		IMAGE_NAME=$(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(ECR_REPO):$$LOWER_FUNCTION; \
		if docker images | grep -q "$$LOWER_FUNCTION"; then \
			echo "Tagging and pushing $$LOWER_FUNCTION..."; \
			docker tag $$IMAGE_NAME $$LOWER_FUNCTION ; \
			docker push $$IMAGE_NAME; \
		else \
			echo "Skipping $$LOWER_FUNCTION: Image does not exist"; \
		fi; \
	done

update-lambda:
	@echo "Updating Lambda functions with latest image versions..."
	@for function in $(FUNCTIONS); do \
		LOWER_FUNCTION=$$(echo $$function | tr '[:upper:]' '[:lower:]'); \
		IMAGE_NAME=$(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(ECR_REPO):$$LOWER_FUNCTION; \
		FUNCTION_NAME=$$(echo $$function | sed 's/./\U&/'); \
        FUNCTION_NAME=$$FUNCTION_NAME"Function"; \
		echo "FUNCTION_NAME: $$FUNCTION_NAME"; \
		LAMBDA_NAME=$$(aws cloudformation describe-stack-resources --stack-name product-api --query "StackResources[?ResourceType=='AWS::Lambda::Function' && LogicalResourceId=='$$FUNCTION_NAME'].PhysicalResourceId" --output text --region $(AWS_REGION)); \
		echo "Updating Lambda function $$LAMBDA_NAME..."; \
		aws lambda update-function-code --function-name $$LAMBDA_NAME --image-uri $$IMAGE_NAME --region $(AWS_REGION) > /dev/null; \
	done

deploy: build push 
	@echo "Deploying with AWS SAM..."
	sam build  && sam deploy --resolve-image-repos
	update-lambda