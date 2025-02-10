AWS_REGION=$(shell grep AWS_REGION .env | cut -d '=' -f2)
AWS_ACCOUNT_ID=$(shell grep AWS_ACCOUNT_ID .env | cut -d '=' -f2)
ECR_REPO=product-api-repository

# Function Names
FUNCTIONS = getAllProducts getProductById signup signin

# Build, Push, and Deploy Everything
.PHONY: build push deploy

build:
	@echo "Building Docker images..."
	@for function in $(FUNCTIONS); do \
		LOWER_FUNCTION=$$(echo $$function | tr '[:upper:]' '[:lower:]'); \
		docker build --build-arg FUNCTION_DIR=lambdas/$$function -t $(ECR_REPO):$$LOWER_FUNCTION .; \
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
			docker tag $(ECR_REPO):$$LOWER_FUNCTION $$IMAGE_NAME; \
			docker push $$IMAGE_NAME; \
		else \
			echo "Skipping $$LOWER_FUNCTION: Image does not exist"; \
		fi; \
	done

deploy:
	@echo "Deploying with AWS SAM..."
	sam build --use-container  && sam deploy --image-repository $(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(ECR_REPO)

all: build push deploy