api_key=<YOUR_API_KEY>
app_key=<YOUR_APP_KEY>

curl -X POST \
-H "Content-type: application/json" \
-H "DD-API-KEY: ${api_key}" \
-H "DD-APPLICATION-KEY: ${app_key}" \
-d '{
        "name": "My Dashboard List"
}' \
"https://api.datadoghq.com/api/v1/dashboard/lists/manual"
