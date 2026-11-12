"""Sitemap to AI Corpus - Python example.

Install:
    pip install apify-client

Run:
    APIFY_TOKEN=your_token python python.py
"""

import os
from apify_client import ApifyClient

TOKEN = os.environ.get("APIFY_TOKEN", "YOUR_TOKEN")
ACTOR = "Turboextract/sitemap-to-ai-corpus"

client = ApifyClient(TOKEN)

# 1. Start the actor and wait for it to finish
run_input = {
    "sitemapUrls": [{"url": "https://blog.apify.com/sitemap.xml"}],
    "maxPages": 200,
    "minWordCount": 200,
}

run = client.actor(ACTOR).call(run_input=run_input)

# 2. Stream results
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(f"[{item['wordCount']:>5}w] {item['title']}")
    print(f"        {item['url']}")

# 3. Or pull all at once into a list
items = list(client.dataset(run["defaultDatasetId"]).iterate_items())
print(f"\n{len(items)} pages returned.")
