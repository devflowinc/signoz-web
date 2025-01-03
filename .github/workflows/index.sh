# Load environment variables
TRIEVE_URL="https://api.trieve.ai"

all_envs() {
echo "
These github repo secrets must to be set:
TRIEVE_ORGANIZATION_ID="\<your-trieve-organization-id\>"
TRIEVE_DATASET_ID="\<your-trieve-dataset-id\>"
TRIEVE_API_KEY="\<your-trieve-api-key\>"

alternatively you can modify the actions env's as such
ORGANIZATION_ID="\<your-trieve-organization-id\>"
DATASET_ID="\<your-trieve-dataset-id\>"
API_KEY="\<your-trieve-api-key\>"
"
}

[ -z $ORGANIZATION_ID ] && echo "ORGANIZATION_ID is not found" && all_envs && exit 1
[ -z $DATASET_ID ] && echo "DATASET_ID is not found" &&  all_envs && exit 1
[ -z $API_KEY ] && echo "API_KEY is not found" &&  all_envs && exit 1

PAYLOAD='{ "crawl_options": { "allow_external_links": null, "boost_titles": true, "exclude_paths": [], "exclude_tags": [ "nav", "img", "pre", ".PageFeedback_feedbackContainer___tGjJ", ".doc-sidenav", ".doc-toc", "div.z-[10].flex.flex-col.justify-center.border-t.border-solid.border-gray-900.bg-signoz_ink-500.bg-opacity-70.backdrop-blur-md", ".related-articles", "aside", "footer" ], "include_paths": [ "faqs", "docs" ], "include_tags": [ ".doc-content", "main" ], "interval": "daily", "limit": 10000, "site_url": "https://signoz.io/docs/", "scrape_options": null }, "dataset_id": "'${DATASET_ID}'" }'

echo "Payload $PAYLOAD"

# Make the API call using curl and capture the response code
curl -X PUT "${TRIEVE_URL}/api/dataset" \
  -H "Content-Type: application/json" \
  -H "Authorization: ${API_KEY}" \
  -H "TR-Organization: ${ORGANIZATION_ID}" \
  -H "TR-Dataset: ${DATAST_ID}" \
  -d "${PAYLOAD}" \
  -w "\n%{http_code}"
#
# # Extract the response code from the last line
# http_code=$(echo "$response" | tail -n1)
# # Extract the response body (everything except the last line)
# response_body=$(echo "$response" | sed \$d)
#
# # Check if the response code is 200
# if [ "$http_code" -eq 200 ]; then
#   echo "Crawling started Successfully"
#   exit 0
# else
#   echo "Error: Received HTTP status code $http_code"
#   echo "Response: $response_body"
#   echo "Full response $response"
#   exit 1
# fi
