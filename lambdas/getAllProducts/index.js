const axios = require("axios");

exports.handler = async () => {
  try {
    // Fetch products from FakeStoreAPI
    const response = await axios.get("https://fakestoreapi.com/products");

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
      body: JSON.stringify({ error: "Failed to fetch products" }),
      headers: {
        "Content-Type": "application/json",
      },
    };
  }
};
