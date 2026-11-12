#!/usr/bin/env bash
# Sitemap to AI Corpus - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~sitemap-to-ai-corpus"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Single sitemap, small smoke test
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
      "sitemapUrls": [
        {
          "url": "https://blog.apify.com/sitemap.xml"
        }
      ],
      "maxPages": 5
    }'

# 2. Filtered, incremental crawl - only blog posts changed this year
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
      "sitemapUrls": [
        {
          "url": "https://blog.apify.com/sitemap.xml"
        }
      ],
      "urlPatternInclude": "/blog/",
      "lastmodAfter": "2026-01-01",
      "maxPages": 500,
      "minWordCount": 200
    }'

# 3. Synchronous run - get items in the same response (small jobs only)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}&format=json" \
  -H "Content-Type: application/json" \
  -d '{
      "sitemapUrls": [
        {
          "url": "https://blog.apify.com/sitemap.xml"
        }
      ],
      "maxPages": 2
    }'
