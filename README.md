# Engineering Memory

Generate long-term engineering documentation from GitHub PRs and Jira tickets.

## Vision

Capture and preserve engineering knowledge by automatically generating documentation after a feature is completed.

The goal is to answer questions like:

- Why was this change made?
- What problem did it solve?
- What files were affected?
- What tradeoffs were considered?
- How was the solution tested?
- What should future engineers know?

## Documentation Sections

Each generated document should include:

- Business Context
- Problem Statement
- Root Cause
- Solution Implemented
- Architecture Impact
- Files Changed
- Edge Cases Considered
- Testing Strategy
- Future Considerations

## MVP Flow

GitHub PR
→ Jira Ticket
→ AI Analysis
→ Google Docs

## Architecture

CLI
 ↓
GithubClient
 ↓
JiraClient
 ↓
DocumentationContext
 ↓
DocumentationGenerator
 ↓
GoogleDriveClient
 ↓
Google Doc

## Component Responsibilities

### GithubClient

Fetch:
- Pull Request Details
- Changed Files
- Commits
- Review Comments

### JiraClient

Fetch:
- Ticket Summary
- Description
- Acceptance Criteria
- Comments

### DocumentationContext

Aggregate all source data into a single object for analysis.

### DocumentationGenerator

Generate structured engineering documentation using AI.

### GoogleDriveClient

Create and organize Google Docs within the Engineering Memory folder.

## Future Enhancements

- GitHub Webhook Integration
- Automatic Execution on PR Merge
- Monthly Engineering Summaries
- Semantic Search
- AI Chat Interface
- Knowledge Graph


## Google Drive Structure

Engineering Memory/
│
├── YYYY/
│   └── Month/
│
└── Monthly Summaries/

Document Naming:

<TICKET_ID> - <SHORT_DESCRIPTION>