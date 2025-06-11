# 🎥 video-summary-ai

**video-summary-ai** is a fully automated tool that converts video files into compact, insightful summaries — with no key details left out — and generates comprehension questions to test understanding.

It converts `.mp4` videos to `.mp3`, transcribes them locally using OpenAI's Whisper, and sends the transcripts to GPT-4 for summarization.

---

## 🚀 Features

- ✅ Converts `.mp4` to compressed `.mp3` audio
- ✅ Transcribes speech to text using Whisper (locally)
- ✅ Summarizes content via ChatGPT (OpenAI API)
- ✅ Appends comprehension questions to test understanding
- ✅ Outputs clean `.txt` summary files per video
- ✅ Bash + Python, no GUI bloat

---

## 📦 Requirements

- macOS or Linux
- Python 3.7+
- [Homebrew](https://brew.sh/) (for macOS users)
- An OpenAI API key (set as `OPENAI_API_KEY`)

### 📚 Dependencies

Install via:

```bash
brew install ffmpeg
pip3 install -U openai-whisper openai
````

---

## 🔧 Installation

1. Clone this repository:

```bash
git clone https://github.com/<yourusername>/video-summary-ai.git
cd video-summary-ai
```

2. Make the script executable:

```bash
chmod +x video-summary-ai.sh
```

3. Export your OpenAI API key:

```bash
export OPENAI_API_KEY="sk-..."
```

---

## 🛠️ Usage

Place your `.mp4` video files in the directory and run:

```bash
./video-summary-ai.sh myvideo1.mp4 myvideo2.mp4
```

This will produce:

* `myvideo1.mp3` — compressed audio
* `myvideo1.txt` — full transcript
* `myvideo1_summary.txt` — GPT-4 generated summary + quiz

---

## 🧠 Prompt Philosophy

The script sends this style of prompt to GPT:

> "Summarize the transcript clearly, **without omitting important details**. Structure as needed. After the summary, generate 5–10 questions to check understanding."

This ensures:

* Maximum factual retention
* Context-aware compression
* Self-testing output

---

## 🧪 Tips

* Change `--model base` in the script to `tiny` or `small` if you want faster transcriptions.
* Add `--language` if you're working with non-English content.
* Output is readable `.txt` files for downstream processing.
