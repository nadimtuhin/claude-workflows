# Claude Workflows

Systematic workflow commands for Claude Code. Add structure to your development process without wasting tokens.

Works standalone or alongside [Claude Token Optimizer](https://github.com/nadimtuhin/claude-token-optimizer).

## The Problem

You have good docs, but still:
- Repeat the same workflows manually
- Forget steps in complex processes
- No standardized way to execute common tasks
- Team members do things differently

## The Solution

Pre-defined workflow commands that Claude loads on-demand:
- **0 tokens** until you invoke them
- **Markdown format** (simple, readable)
- **Slash command style**: `/dev:start-feature`
- **Framework-agnostic**: Works with any stack

## Quick Setup

```bash
curl -fsSL https://raw.githubusercontent.com/nadimtuhin/claude-workflows/main/install.sh | bash
```

This creates:
```
.claude/
└── commands/
    ├── development/
    ├── testing/
    ├── git/
    └── deployment/
```

Plus adds `.claude/commands/**` to your `.claudeignore` so commands cost 0 tokens.

## Available Commands

### Development
- `/dev:start-feature` - Start new feature with proper setup
- `/dev:fix-bug` - Bug fix workflow with root cause analysis
- `/dev:refactor` - Safe refactoring process
- `/dev:spike` - Time-boxed exploration/prototype

### Testing
- `/test:write` - Write tests for existing code
- `/test:run` - Execute test suite with coverage
- `/test:debug` - Debug failing tests
- `/test:e2e` - End-to-end test workflow

### Git
- `/git:commit` - Smart commit with conventional format
- `/git:pr` - Create pull request with description
- `/git:review` - Code review checklist
- `/git:resolve-conflict` - Merge conflict resolution

### Deployment
- `/deploy:prepare` - Pre-deployment checklist
- `/deploy:release` - Release workflow
- `/deploy:rollback` - Emergency rollback procedure
- `/deploy:hotfix` - Critical hotfix process

## Usage

```bash
# User types:
/dev:start-feature user profile editing

# Claude:
# 1. Loads .claude/commands/development/start-feature.md
# 2. Follows the workflow steps
# 3. Creates branch, scaffolds files, writes tests
# 4. Documents progress
```

## How It Works

**Commands are Markdown files:**
```markdown
# /dev:start-feature

## When to Use
Starting a new feature that requires...

## Prerequisites
- [ ] Feature approved
- [ ] Branch created

## Steps
1. Create feature branch
2. Review architecture
3. Scaffold files
4. Write tests first
5. Implement feature

## Validation
- [ ] Tests pass
- [ ] Type check passes
```

**They load only when invoked:**
- Session start: 0 tokens (commands ignored)
- User invokes `/dev:start-feature`: ~400 tokens
- After use: Back to 0 tokens

## Customize Commands

All commands are just Markdown files. Edit them:

```bash
# Add your team's workflow
code .claude/commands/development/start-feature.md

# Create custom command
cp .claude/commands/development/start-feature.md \
   .claude/commands/development/my-workflow.md
```

## Works With Claude Token Optimizer

These repos are designed to work together:

**Claude Token Optimizer** = Documentation structure (what to load at startup)
**Claude Workflows** = Process automation (what to do when working)

```
.claude/
├── COMMON_MISTAKES.md          # From Token Optimizer (always loads)
├── QUICK_START.md              # From Token Optimizer (always loads)
├── ARCHITECTURE_MAP.md         # From Token Optimizer (always loads)
│
├── commands/                   # From Workflows (0 tokens)
│   ├── development/
│   ├── testing/
│   └── git/
│
├── completions/                # From Token Optimizer (0 tokens)
└── sessions/                   # From Token Optimizer (0 tokens)
```

**Result**: Both documentation AND workflows at minimal token cost.

## Framework Examples

Commands work with any framework. We provide examples for popular ones:

- Express.js
- Next.js
- Django
- Rails
- NestJS
- Laravel

Each includes framework-specific steps (migrations, component generation, etc).

## Command Format

All commands follow this structure:

```markdown
# /category:command-name

Brief description

## When to Use
Clear use case

## Prerequisites
- Checklist of requirements

## Steps
1. Numbered steps
2. With code examples
3. And sub-commands

## Validation
- [ ] Acceptance criteria
- [ ] Quality checks

## Example
Concrete usage example
```

## Creating Custom Commands

```bash
# 1. Create file in appropriate category
touch .claude/commands/development/my-command.md

# 2. Follow the format above

# 3. Document in your CLAUDE.md
echo "- /dev:my-command - Custom workflow" >> CLAUDE.md

# 4. Test it
# User: "/dev:my-command"
```

## FAQ

**Does this replace Claude Token Optimizer?**
No. They complement each other:
- Token Optimizer: Organizes documentation (what Claude knows)
- Workflows: Structures processes (what Claude does)

**What's the token cost?**
- Session start: 0 tokens (commands in .claudeignore)
- Per command invocation: ~300-500 tokens
- After completion: Back to 0 tokens

**Do I need both repos?**
No. Use what you need:
- Just docs? Token Optimizer
- Just workflows? This repo
- Both? Install both

**Can I use with existing .claude/ setup?**
Yes. Commands install to `.claude/commands/` subdirectory. Won't conflict.

**XML or Markdown?**
We use Markdown. Simpler, more readable, easier to edit.

## Examples

### Starting a Feature

```
User: /dev:start-feature user authentication

Claude:
1. Creates feature/user-authentication branch
2. Reviews ARCHITECTURE_MAP.md for structure
3. Scaffolds:
   - components/Auth/Login.tsx
   - services/auth.service.ts
   - __tests__/auth.test.ts
4. Writes failing tests
5. Implements feature
6. Validates tests pass
7. Documents in completion doc
```

### Fixing a Bug

```
User: /dev:fix-bug users can't login

Claude:
1. Reproduces bug
2. Writes test case that fails
3. Debugs root cause
4. Implements fix
5. Verifies test passes
6. Checks for similar issues
7. Updates COMMON_MISTAKES.md
8. Commits with fix type
```

### Preparing Deployment

```
User: /deploy:prepare v1.2.0

Claude:
1. Runs full test suite
2. Checks for uncommitted changes
3. Verifies migrations
4. Updates version numbers
5. Generates changelog
6. Creates release branch
7. Runs production build
8. Validates bundle size
```

## Installation Options

### Quick Install (Recommended)
```bash
curl -fsSL https://raw.githubusercontent.com/nadimtuhin/claude-workflows/main/install.sh | bash
```

### Manual Install
```bash
git clone https://github.com/nadimtuhin/claude-workflows
cd claude-workflows
cp -r .claude/commands /path/to/your/project/.claude/
echo ".claude/commands/**" >> /path/to/your/project/.claudeignore
```

### Framework-Specific
```bash
# Install with Express.js examples
curl -fsSL https://raw.githubusercontent.com/nadimtuhin/claude-workflows/main/install.sh | bash -s -- --framework express

# Install with Django examples
curl -fsSL https://raw.githubusercontent.com/nadimtuhin/claude-workflows/main/install.sh | bash -s -- --framework django
```

## Contributing

Want to add commands for your framework or workflow?

1. Fork the repo
2. Add command to appropriate category
3. Follow the Markdown format
4. Test in a real project
5. Submit PR

See [CONTRIBUTING.md](CONTRIBUTING.md).

## Related Projects

- **[Claude Token Optimizer](https://github.com/nadimtuhin/claude-token-optimizer)** - Optimize documentation structure (90% token savings). Designed to work together with this repo.
- **[Claude Modular](https://github.com/oxygen-fragment/claude-modular)** - Enterprise workflow system (XML-based, more complex)

## License

MIT - use it however you want.

---

**Systematic workflows without token waste.**

Install commands once, invoke them forever at minimal cost.
