# Deployment Guide
### n8n Context Aware Assistant - bennypixel

## Overview

This document provides instructions for deploying the n8n Context-Aware Assistant, a lightweight app that integrates with your n8n instance to provide assistance with JSON formatting, workflow error correction, prompt writing, and more.

## Features

- **Dark Mode UI**: Sleek, modern interface with green accent colors
- **Interchangeable AI Agents**: Switch between different LLM providers (Claude, GPT)
- **API Key Management**: Securely store and manage your API keys
- **Context-Aware Assistance**: Get help with n8n-specific tasks
- **Knowledge Base**: Built-in knowledge from n8n documentation
- **Web Search Fallback**: Automatic fallback to web search when needed
- **Error Correction**: Intelligent workflow error detection and correction
- **Prompt Templates**: Pre-built templates for common n8n tasks

## Prerequisites

- n8n instance (self-hosted or cloud)
- API keys for at least one LLM provider (Anthropic Claude and/or OpenAI GPT)
- Node.js 16+ and npm/pnpm

## Installation

1. **Extract the deployment package**:

   ```bash
   unzip n8n-assistant.zip -d /path/to/your/n8n/custom/extensions/
   ```

2. **Install dependencies**:

   ```bash
   cd /path/to/your/n8n/custom/extensions/n8n-assistant
   pnpm install
   ```

3. **Build the application**:

   ```bash
   pnpm build
   ```

4. **Configure n8n to load the extension**:
   Add the following to your n8n configuration file or environment variables:

   ```
   N8N_CUSTOM_EXTENSIONS=/path/to/your/n8n/custom/extensions/n8n-assistant
   ```

5. **Restart your n8n instance**:

   ```bash
   pm2 restart n8n # or however you manage your n8n process
   ```

