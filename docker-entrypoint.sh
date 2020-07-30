#!/usr/bin/env sh

# Does the container look intact?
# We need numerous environment variables.

: "${CLUBHOUSE_API_TOKEN?Need to set CLUBHOUSE_API_TOKEN}"

# If writing to a bucket we need more credentials.
if [ -n "${BUCKET_NAME}" ]; then
  : "${AWS_ACCESS_KEY_ID?Need to set AWS_ACCESS_KEY_ID}"
  : "${AWS_SECRET_ACCESS_KEY?Need to set AWS_SECRET_ACCESS_KEY}"
fi

if [ ! -d "${EXPORT_ROOT}" ]; then
    echo "ERROR - the destination directory (/export) does not exist"
    exit 0
fi

# Export
echo "+> Exporting to ${EXPORT_ROOT}..."
cd "${EXPORT_ROOT}"
"${APP_ROOT}"/exporter.sh
"${APP_ROOT}"/get-all-stories.sh
ls -l ./data
echo "+> Exported."

# Write the exported directory content to AWS S3?
if [ -n "${BUCKET_NAME}" ]; then

  echo "+> Synchronising to bucket ${BUCKET_NAME}..."
  aws s3 sync ./data "s3://${BUCKET_NAME}/"
  echo "+> Synchronised."

fi

echo "+> Done."
