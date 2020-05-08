# Test connection
$response = Invoke-WebRequest -URI http://localhost:9200/
$response.RawContent

# Create new index
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Content-Type', 'application/json')
$response = Invoke-WebRequest -URI 127.0.0.1:9200/countries `
    -Headers $headers `
    -Method Put
$response.RawContent

# Delete index
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Content-Type', 'application/json')
$response = Invoke-WebRequest -URI 127.0.0.1:9200/countries `
    -Headers $headers `
    -Method Delete
$response.RawContent

# Add new type
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Content-Type', 'application/json')
$body = '{
    "code": "PL",
    "name": "Polska"
}'
$response = Invoke-WebRequest -URI 127.0.0.1:9200/countries/country `
    -Headers $headers `
    -Body $body `
    -Method Post
$response.RawContent

# Add document with id
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Content-Type', 'application/json')
$body = '{
    "code": "PL",
    "name": "Rzeczpospolita Polska"
}'
$response = Invoke-WebRequest -URI 127.0.0.1:9200/countries/country/1 `
    -Headers $headers `
    -Body $body `
    -Method Post
$response.RawContent

# Update document with id
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Content-Type', 'application/json')
$body = '{
    "code": "PL",
    "name": "Poland"
}'
$response = Invoke-WebRequest -URI 127.0.0.1:9200/countries/country/1 `
    -Headers $headers `
    -Body $body `
    -Method Put
$response.RawContent

# Show type schema
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Content-Type', 'application/json')
$response = Invoke-WebRequest -URI 127.0.0.1:9200/countries/_mapping `
    -Headers $headers `
    -Method Get
$response.RawContent

# Query without criteria
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Content-Type', 'application/json')
$response = Invoke-WebRequest -URI 127.0.0.1:9200/countries/country/_search `
    -Headers $headers `
    -Method Get
$response.RawContent

# Query first 3 documents
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Content-Type', 'application/json')
$response = Invoke-WebRequest -URI 127.0.0.1:9200/countries/country/_search?size=3 `
    -Headers $headers `
    -Method Get
$response.RawContent

# Query first 3 documents with offset
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Content-Type', 'application/json')
$response = Invoke-WebRequest -URI '127.0.0.1:9200/countries/country/_search?from=2&amp;size=3' `
    -Headers $headers `
    -Method Get
$response.RawContent

# Query for name
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Content-Type', 'application/json')
$response = Invoke-WebRequest -URI '127.0.0.1:9200/countries/country/_search?q=name:Rzeczpospolita' `
    -Headers $headers `
    -Method Get
$response.RawContent

# Query for all documents using DSL
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Content-Type', 'application/json')
$body = '{
    "query": {
        "match_all": {}
    }
}'
$response = Invoke-WebRequest -URI 127.0.0.1:9200/countries/country/_search `
    -Headers $headers `
    -Body $body `
    -Method Post
$response.RawContent

# Query for first 3 documents using DSL
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Content-Type', 'application/json')
$body = '{
    "query": {
        "match_all": {}
    },
    "size": 3
}'
$response = Invoke-WebRequest -URI 127.0.0.1:9200/countries/country/_search `
    -Headers $headers `
    -Body $body `
    -Method Post
$response.RawContent

# Delete document by id
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Content-Type', 'application/json')
$response = Invoke-WebRequest -URI '127.0.0.1:9200/countries/country/1' `
    -Headers $headers `
    -Method Delete
$response.RawContent

# Delete by query using DSL
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Content-Type', 'application/json')
$body = '{
    "query": {
        "match": {
            "name": "Polska"
        }
    }
}'
$response = Invoke-WebRequest -URI 127.0.0.1:9200/countries/country/_delete_by_query `
    -Headers $headers `
    -Body $body `
    -Method Post
$response.RawContent
