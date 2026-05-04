---
description: "AI team member that handles tasks, answers questions, manages workflows, and builds internal tools via chat."
tags: [productivity, workspace, coding, google-workspace, mcp, scheduling, whatsapp]
authors:
  - name: Array Ventures
    account: array-ventures
capabilities:
  - "Answers questions and drafts content from conversation context"
  - "Builds and maintains internal dashboards and tools with git version control"
  - "Reads and sends Gmail, manages Calendar events and Drive files"
  - "Installs and manages MCP servers via built-in registry"
  - "Runs recurring AI workflows on a cron schedule"
  - "Interacts with users over WhatsApp"
  - "Uploads, manages, and references files in conversations"
  - "Switches between AI providers and models at runtime"
  - "Installs community skills from ClawHub and skills.sh"
  - "Communicates with other agents via the A2A protocol"
repository: github:Array-Ventures/coworker
integrations:
  - Anthropic
  - OpenAI
  - Google Workspace
  - WhatsApp
  - GitHub
  - Slack
---

## Overview

Coworker is an open-source AI agent that acts as a team member rather than a tool. It remembers past conversations, tracks tasks across sessions, manages your Google Workspace, and can build internal dashboards — all through natural language chat.

Built on [Mastra](https://mastra.ai) and designed for team deployment on the Astro platform.

## Usage

Chat naturally. Coworker picks the right tools based on context:

- **Ask questions** — it searches memory for relevant past context before answering
- **Request tasks** — it tracks multi-step work with a visible task list and checks in when done
- **Google Workspace** — "summarise my unread emails", "schedule a meeting Thursday 3pm", "share the Q2 doc with the team"
- **Build tools** — "create a dashboard showing our open GitHub issues" — it scaffolds, commits, and maintains the app
- **Schedule work** — "every Monday morning, summarise last week's activity and post to Slack"
- **Install skills** — "install the Jira skill from ClawHub" to extend what it can do

## Inputs

| Input | Required | Description |
|-------|----------|-------------|
| `MODEL` | No | Model to use, e.g. `anthropic/claude-sonnet-4-5` or `openai/gpt-4o` |
| `ANTHROPIC_API_KEY` | If using Anthropic | Anthropic API key |
| `OPENAI_API_KEY` | If using OpenAI | OpenAI API key |
| `GOG_GOOGLE_CLIENT_ID` | For Google Workspace | OAuth client ID from Google Cloud Console |
| `GOG_GOOGLE_CLIENT_SECRET` | For Google Workspace | OAuth client secret |
| `GOG_KEYRING_PASSWORD` | Recommended | Encrypts stored Google OAuth tokens at rest |

## Limitations

- Google Workspace requires a Google Cloud OAuth app — see README for setup steps
- WhatsApp sessions are not persisted across redeployments (re-scan QR on restart)
- Scheduled tasks run in-process — they pause if the agent container restarts
- Local LLM providers (LM Studio, Ollama) require the agent to share a network with the provider
