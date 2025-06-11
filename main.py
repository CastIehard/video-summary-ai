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