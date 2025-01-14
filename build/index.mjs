const AWS = require("aws-sdk");
const sharp = require("sharp");
const s3 = new AWS.S3();

exports.handler = async (event) => {
  try {
    // Extract the S3 bucket and key from the event (triggered by S3 upload)
    const bucket = event.Records[0].s3.bucket.name;
    const key = event.Records[0].s3.object.key;

    // Get the image from S3
    const s3Object = await s3.getObject({ Bucket: bucket, Key: key }).promise();

    // Use sharp to resize the image
    const resizedImage = await sharp(s3Object.Body)
      .resize(300, 200) // Resize the image to 300x200 (can be dynamic)
      .toBuffer();

    // Define the parameters to save the resized image back to S3
    const resizedKey = `resized/${key}`;

    await s3
      .putObject({
        Bucket: bucket,
        Key: resizedKey,
        Body: resizedImage,
        ContentType: "image/jpeg", // Set the appropriate MIME type for your image
      })
      .promise();

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "Image resized successfully",
        resizedKey: resizedKey,
      }),
    };
  } catch (error) {
    console.error("Error resizing image:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({
        error: "Image resizing failed",
        details: error.message,
      }),
    };
  }
};
