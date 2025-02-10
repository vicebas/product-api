const axios = require("axios");

exports.handler = async (event) => {
  try {
    const productId = event.pathParameters.id; // Get product ID from API Gateway URL

    // Fetch the product from FakeStoreAPI
    const response = await axios.get(`https://fakestoreapi.com/products/${productId}`);

    return {
      statusCode: 200,
      body: JSON.stringify(response.data),
      headers: {
        "Content-Type": "application/json",
      },
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: "Failed to fetch product" }),
      headers: {
        "Content-Type": "application/json",
      },
    };
  }
};
