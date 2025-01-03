let TRIEVE_URL = "https://api.trieve.ai"

def all_envs [] {
echo "
These github repo secrets must to be set:
TRIEVE_ORGANIZATION_ID=<your-trieve-organization-id>
TRIEVE_DATASET_ID=<your-trieve-dataset-id>
TRIEVE_API_KEY=<your-trieve-api-key>

alternatively you can modify the actions env's as such
ORGANIZATION_ID=<your-trieve-organization-id>
DATASET_ID=<your-trieve-dataset-id>
API_KEY=<your-trieve-api-key>
"
}

# Check environment variables
if ($env | get ORGANIZATION_ID | is-empty) { 
echo "ORGANIZATION_ID is not found"
all_envs
exit 1
}
if ($env | get DATASET_ID | is-empty) {
echo "DATASET_ID is not found"
all_envs
exit 1
}
if ($env | get API_KEY | is-empty) {
echo "API_KEY is not found"
all_envs
exit 1
}

let PAYLOAD = {
    crawl_options: {
      allow_external_links: null,
      boost_titles: true,
      exclude_paths: [],
      exclude_tags: [
        "nav", "img", "pre",
        ".PageFeedback_feedbackContainer___tGjJ",
        ".doc-sidenav", ".doc-toc",
        "div.z-[10].flex.flex-col.justify-center.border-t.border-solid.border-gray-900.bg-signoz_ink-500.bg-opacity-70.backdrop-blur-md",
        ".related-articles", "aside", "footer"
      ],
      include_paths: ["faqs", "docs"],
      include_tags: [".doc-content", "main"],
      interval: "daily",
      limit: 10000,
      site_url: "https://signoz.io/docs/",
      scrape_options: null
    },
    dataset_id: $env.DATASET_ID
}

echo $"Payload ($PAYLOAD | to json)"

let headers = {
    "TR-Organization": $env.ORGANIZATION_ID
    "TR-Dataset": $env.DATASET_ID
    "Authorization": $env.API_KEY
}
http put --content-type application/json $"($TRIEVE_URL)/api/dataset" $PAYLOAD --headers $headers -e
# -d ($PAYLOAD | to json)
# --write-out "\n%{http_code}")
#
# let http_code = ($response | split row "\n" | last)
# let response_body = ($response | split row "\n" | drop -1 | str join "\n")
#
# if $http_code == "200" {
# echo "Crawling finished Successfully"
# exit 0
# } else {
# echo $"Error: Received HTTP status code ($http_code)"
# echo $"Response: ($response_body)"
# exit 1
# }
