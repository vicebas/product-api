const AWS = require("aws-sdk");

const cognito = new AWS.CognitoIdentityServiceProvider();

const USER_POOL_CLIENT_ID = process.env.USER_POOL_CLIENT_ID; // Load from environment variables

exports.handler = async (event) => {
  try {
    const { username, password, email } = JSON.parse(event.body);

    const params = {
      ClientId: USER_POOL_CLIENT_ID,
      Username: username,
      Password: password,
      UserAttributes: [
        { Name: "email", Value: email }
      ]
    };

    await cognito.signUp(params).promise();

    return {
      statusCode: 200,
      body: JSON.stringify({ message: "User signed up successfully. Please check email for verification code." }),
      headers: { "Content-Type": "application/json" },
    };

  } catch (error) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: error.message }),
      headers: { "Content-Type": "application/json" },
    };
  }
};
