# Contributing to Claude Workflows

Thanks for your interest in contributing! This project is a collection of Markdown workflow commands for Claude Code, so contributions are straightforward.

## What to Contribute

- **New workflow commands** — add commands for categories not yet covered (e.g., `database/`, `security/`, `devops/`)
- **Framework-specific variants** — e.g., a Django-flavored `/dev:start-feature`
- **Improvements to existing commands** — clearer steps, better examples, missing edge cases
- **Bug fixes in `install.sh`**

## Getting Started

```bash
git clone https://github.com/nadimtuhin/claude-workflows
cd claude-workflows
```

No build step required — commands are plain Markdown files.

## Command Format

All commands must follow this structure:

```markdown
# /category:command-name

Brief one-line description.

## When to Use

Clear use case and when NOT to use it.

## Prerequisites

- [ ] Checklist item

## Steps

1. Numbered step with code examples

## Validation

- [ ] Acceptance criteria

## Example

Concrete usage scenario

---

**Token cost**: ~N tokens when invoked, 0 tokens otherwise
```

## Pull Request Process

1. Fork the repo and create a branch: `feature/add-database-commands`
2. Add your command(s) to the appropriate category directory under `.claude/commands/`
3. Test the command in a real project by invoking it with Claude Code
4. Update `README.md` if you added a new command to the available commands list
5. Open a PR with a clear description of what you added and why

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to uphold it.

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).
