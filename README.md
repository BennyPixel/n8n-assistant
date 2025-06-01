# n8n guru
## a context-aware assistant, working alongside you in n8n
This project is a lightweight context-aware assistant app that integrates with n8n to provide assistance with JSON formatting, workflow error correction, prompt writing, and other n8n-related tasks. The app features a dark mode UI, interchangeable AI agents running off your API keys, and a comprehensive knowledge base built from n8n documentation.
## Repository Structure

```
n8n_assistant/
├── app/                      # Main application code
│   ├── frontend/             # React TypeScript frontend
│   │   ├── src/              # Source code
│   │   │   ├── components/   # UI components
│   │   │   ├── contexts/     # React contexts
│   │   │   ├── hooks/        # Custom React hooks
│   │   │   ├── services/     # Service layer
│   │   │   └── styles/       # CSS and styling
├── knowledge_base/           # Extracted n8n documentation
├── architecture.md           # Architecture and tech stack documentation
├── deployment_guide.md       # Deployment instructions
├── requirements.md           # Detailed requirements specification
└── todo.md                   # Project progress tracking
```

## Features

- **Dark Mode UI**: Sleek, modern interface with green accent colors
- **Interchangeable AI Agents**: Switch between different LLM providers (Claude, GPT)
- **API Key Management**: Securely store and manage your API keys
- **Context-Aware Assistance**: Get help with n8n-specific tasks
- **Knowledge Base**: Built-in knowledge from n8n documentation
- **Web Search Fallback**: Automatic fallback to web search when needed
- **Error Correction**: Intelligent workflow error detection and correction
- **Prompt Templates**: Pre-built templates for common n8n tasks

## Development

The application is built with:

- React with TypeScript for the frontend
- Tailwind CSS for styling
- Context API for state management
- Modular service architecture for AI integration

## Deployment

See the `deployment_guide.md` file for detailed installation instructions.

## Security

- API keys are stored in browser localStorage and not sent to external servers
- All LLM requests are made directly from your browser to the provider's API
- No data is collected or shared outside your n8n instance
