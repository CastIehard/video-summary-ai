#!/bin/bash

# Usage: ./summarize_it.sh *.mp4

set -e

for f in "$@"; do
    echo "Processing $f..."

    base="${f%.*}"
    mp3="$base.mp3"
    transcript="$base.txt"
    summary_file="${base}_summary.txt"

    # Step 1: Convert to low-quality mp3
    ffmpeg -i "$f" -b:a 32k -ac 1 "$mp3"

    # Step 2: Transcribe using Whisper
    whisper "$mp3" --model base --output_format txt --output_dir .

    # Step 3: Send to ChatGPT for summarization
    python3 - <<EOF
import openai
import os

openai.api_key = os.environ.get("OPENAI_API_KEY")

if not openai.api_key:
    raise ValueError("OPENAI_API_KEY environment variable is not set.")

with open("$transcript", "r", encoding="utf-8") as f:
    content = f.read()

prompt = f"""You're an expert explainer. Summarize the following transcript clearly, without omitting important details. Structure the summary in bullet points or sections as needed. After the summary, generate 5-10 questions to help test understanding.

Transcript:
\"\"\"
{content}
\"\"\"
"""

response = openai.ChatCompletion.create(
    model="gpt-4",
    messages=[
        {"role": "system", "content": "You are a helpful assistant who explains clearly and thoroughly."},
        {"role": "user", "content": prompt}
    ],
    temperature=0.5,
    max_tokens=3000
)

summary = response['choices'][0]['message']['content']

with open("$summary_file", "w", encoding="utf-8") as out:
    out.write(summary)

print(f"✅ Summary saved to $summary_file")
EOF

done
