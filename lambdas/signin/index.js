const AWS = require("aws-sdk");

const cognito = new AWS.CognitoIdentityServiceProvider();

const USER_POOL_CLIENT_ID = process.env.USER_POOL_CLIENT_ID; // Load from environment variables

exports.handler = async (event) => {
  try {
    const { username, password } = JSON.parse(event.body);

    const params = {
      AuthFlow: "USER_PASSWORD_AUTH",
      ClientId: USER_POOL_CLIENT_ID,
      AuthParameters: {
        USERNAME: username,
        PASSWORD: password,
      },
    };

    const response = await cognito.initiateAuth(params).promise();

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "Login successful",
        accessToken: response.AuthenticationResult.AccessToken,
        idToken: response.AuthenticationResult.IdToken,
        refreshToken: response.AuthenticationResult.RefreshToken
      }),
      headers: { "Content-Type": "application/json" },
    };

  } catch (error) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: error.message }),
      headers: { "Content-Type":  "application/json" },
    };
  }
};
