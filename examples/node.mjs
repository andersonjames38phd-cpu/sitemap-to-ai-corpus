// Sitemap to AI Corpus - Node.js example.
//
// Install:
//   npm install apify-client
//
// Run:
//   APIFY_TOKEN=your_token node node.mjs

import { ApifyClient } from 'apify-client';

const TOKEN = process.env.APIFY_TOKEN ?? 'YOUR_TOKEN';
const ACTOR = 'Turboextract/sitemap-to-ai-corpus';

const client = new ApifyClient({ token: TOKEN });

// 1. Start the actor and wait for it to finish
const runInput = {
    sitemapUrls: [{ url: 'https://blog.apify.com/sitemap.xml' }],
    maxPages: 200,
    minWordCount: 200,
};

const run = await client.actor(ACTOR).call(runInput);

// 2. Pull dataset items
const { items } = await client.dataset(run.defaultDatasetId).listItems();

for (const item of items) {
    console.log(`[${String(item.wordCount).padStart(5)}w] ${item.title}`);
    console.log(`        ${item.url}`);
}

console.log(`\n${items.length} pages returned.`);

// 3. Or stream item-by-item (useful for large jobs)
// for await (const item of client.dataset(run.defaultDatasetId).iterate()) {
//     console.log(item);
// }
