const AWS = require('aws-sdk');
const USER_POOL_CLIENT_ID = process.env.USER_POOL_CLIENT_ID; // Load from environment variables

const cognito = new AWS.CognitoIdentityServiceProvider();

exports.handler = async (event) => {
    const { username, confirmationCode } = JSON.parse(event.body);;

    const params = {
        ClientId: USER_POOL_CLIENT_ID, // Your Cognito User Pool Client ID
        Username: username,
        ConfirmationCode: confirmationCode
    };

    try {
        const data = await cognito.confirmSignUp(params).promise();
        return {
            statusCode: 200,
            body: JSON.stringify({ message: 'User confirmed successfully', data })
        };
    } catch (error) {
        return {
            statusCode: 400,
            body: JSON.stringify({ message: 'Error confirming user', error })
        };
    }
};