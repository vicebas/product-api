uild an AWS API Gateway with Cognito Authentication**

#### **Objective:**

Design and implement an AWS API Gateway that uses Cognito for authentication and connects to two Lambda functions. Each Lambda function will call an external service of your's choice. Please provide and must use CloudFormation scripts to provide the necessary infrastructure and clear documentation.

### **Task Requirements:**

1. **API Gateway and Cognito Setup:**
   - Create an **API Gateway** with at least two endpoints.
   - Implement **Cognito** as the authentication mechanism for these endpoints. Use an Amazon Cognito User Pool and configure it for secure access to the API.

2. **Lambda Functions:**
   - Develop two AWS **Lambda functions**. Each function should:
     - Call an **external service** of your choice. The services can be any publicly accessible APIs (e.g., weather API, stock market API, etc.).
     - Process the response from the external service and return a meaningful output to the API Gateway.
   
3. **Infrastructure as Code:**
   - Use **AWS CloudFormation** to create all the necessary resources, including:
     - API Gateway
     - Cognito User Pool
     - Lambda Functions
     - Are any other resources required (e.g., IAM roles, permissions, etc.)?

4. **Documentation:**
   - Write a **README** in Markdown format that:
     - Describes the overall architecture.
     - Provides a step-by-step guide on how to deploy the solution.
     - Details the external services chosen for the Lambda functions.
     - Includes API endpoint testing instructions (e.g., sample requests and expected responses).
     - Documents any assumptions, limitations, or additional configurations needed.



### **Deliverables:**

1. **CloudFormation Scripts:** 
   - Include all CloudFormation scripts required to deploy the infrastructure.

2. **Source Code for Lambda Functions:**
   - Provide the source code for both Lambda functions, with clear documentation/comments within the code.

3. **README Documentation:**
   - A well-structured README file in Markdown format, following the documentation guidelines.

4. **Repository Structure:**
   - Organize the files in a Git repository with the following structure:
     

/aws-api-gateway-assessment
     ├── README.md
     ├── cloudformation
     │   ├── main.yaml (or .json) - Main CloudFormation script
     ├── lambdas
     │   ├── lambda1
     │   │   └── index.js - First Lambda function
     │   ├── lambda2
     │   │   └── index.js - Second Lambda function
     └── assets (if any)



5. **Deployment Guide:**
   - A section in the README file that includes:
     - Instructions on how to deploy using the CloudFormation script.
     - Steps to create and configure the Cognito User Pool.
     - How do you invoke the Lambda functions via the API Gateway?
     - Any necessary prerequisites and dependencies.

---

### **Evaluation Criteria:**

1. **Correctness:**
   - Does the API Gateway properly implement Cognito authentication?
   - Do the Lambda functions call the chosen external services and correctly handle responses?

2. **Completeness:**
   - Are all necessary resources created and configured using CloudFormation?
   - Is the README documentation comprehensive and easy to follow?

3. **Code Quality:**
   - Is the code for Lambda functions clean, well-structured, and documented?
   - Are best practices followed in CloudFormation scripting?

4. **Creativity and Problem Solving:**
   - Are the external services chosen for the Lambda functions meaningful and relevant?
   - How well does the you handle potential issues such as error handling, rate limiting, etc.?

5. **Documentation:**
   - Is the documentation clear and detailed, and does it adequately describe the solution and deployment steps?

---

### **Additional Notes:**

- Should use Node.js language supported by AWS Lambda 
- Using AWS Free Tier eligible services to minimize any costs.
---


Docker container
