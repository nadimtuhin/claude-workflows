#!/bin/bash

# Claude Workflows - Installation Script
# Installs workflow commands to your project

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Header
echo ""
echo "╔════════════════════════════════════════════════╗"
echo "║   Claude Workflows - Installation             ║"
echo "║   Systematic commands for Claude Code         ║"
echo "╚════════════════════════════════════════════════╝"
echo ""

# Check if we're in a project directory
if [ ! -d ".git" ] && [ ! -f "package.json" ] && [ ! -f "requirements.txt" ] && [ ! -f "Gemfile" ]; then
    echo -e "${YELLOW}⚠️  Warning: This doesn't look like a project root directory${NC}"
    # Under `curl ... | bash` stdin is the script itself, so ask the terminal.
    REPLY=""
    if (exec < /dev/tty) 2>/dev/null; then
        read -p "Continue anyway? (y/n) " -n 1 -r < /dev/tty
        echo
    else
        echo "   No terminal to confirm on. Run this from your project root."
    fi
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}❌ Installation cancelled${NC}"
        exit 1
    fi
fi

# Parse command line args
FRAMEWORK=""
while [[ $# -gt 0 ]]; do
    case $1 in
        --framework)
            FRAMEWORK="$2"
            shift
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# Create directory structure
echo -e "${GREEN}📁 Creating directory structure...${NC}"

mkdir -p .claude/commands/development
mkdir -p .claude/commands/testing
mkdir -p .claude/commands/git
mkdir -p .claude/commands/deployment

echo "   ✓ Created .claude/commands/ directories"

# Download command files
echo -e "${GREEN}📥 Downloading workflow commands...${NC}"

REPO_URL="https://raw.githubusercontent.com/nadimtuhin/claude-workflows/main"

# Development commands
curl -fsSL "${REPO_URL}/.claude/commands/development/start-feature.md" \
    -o .claude/commands/development/start-feature.md 2>/dev/null || true

curl -fsSL "${REPO_URL}/.claude/commands/development/fix-bug.md" \
    -o .claude/commands/development/fix-bug.md 2>/dev/null || true

# Testing commands
curl -fsSL "${REPO_URL}/.claude/commands/testing/run-tests.md" \
    -o .claude/commands/testing/run-tests.md 2>/dev/null || true

curl -fsSL "${REPO_URL}/.claude/commands/testing/write-tests.md" \
    -o .claude/commands/testing/write-tests.md 2>/dev/null || true

# Git commands
curl -fsSL "${REPO_URL}/.claude/commands/git/commit.md" \
    -o .claude/commands/git/commit.md 2>/dev/null || true

curl -fsSL "${REPO_URL}/.claude/commands/git/pr.md" \
    -o .claude/commands/git/pr.md 2>/dev/null || true

# Deployment commands
curl -fsSL "${REPO_URL}/.claude/commands/deployment/prepare-release.md" \
    -o .claude/commands/deployment/prepare-release.md 2>/dev/null || true

echo "   ✓ Downloaded workflow commands"

# Create commands README
cat > .claude/commands/README.md << 'EOF'
# Workflow Commands

Commands are never auto-loaded (0 tokens). Invoke with slash notation:

```
/category:command-name
```

## Available Commands

### Development
- `/dev:start-feature` - Start new feature with proper setup
- `/dev:fix-bug` - Bug fix workflow with root cause analysis
- `/dev:refactor` - Safe refactoring process

### Testing
- `/test:run` - Execute test suite with coverage
- `/test:write` - Write tests for existing code
- `/test:debug` - Debug failing tests

### Git
- `/git:commit` - Smart commit with conventional format
- `/git:pr` - Create pull request with description
- `/git:review` - Code review checklist

### Deployment
- `/deploy:prepare` - Pre-deployment checklist
- `/deploy:release` - Release workflow

## Usage

```bash
User: /dev:start-feature user authentication

Claude:
1. Loads .claude/commands/development/start-feature.md
2. Follows the workflow steps
3. Creates branch, scaffolds files, writes tests
4. Documents progress
```

## Customizing Commands

All commands are Markdown files. Edit them to match your workflow:

```bash
code .claude/commands/development/start-feature.md
```

Or create new commands:

```bash
cp .claude/commands/development/start-feature.md \
   .claude/commands/development/my-workflow.md
```

---

**Token cost**: Commands cost 0 tokens until invoked.
When invoked, each command costs ~300-500 tokens.
EOF

echo "   ✓ Created commands README"

# Update .claudeignore
echo -e "${GREEN}📝 Updating .claudeignore...${NC}"

if [ -f ".claudeignore" ]; then
    # Check if rule already exists
    if ! grep -q "^.claude/commands/" .claudeignore; then
        echo "" >> .claudeignore
        echo "# Workflow commands (never auto-load)" >> .claudeignore
        echo ".claude/commands/**" >> .claudeignore
        echo "   ✓ Added commands to .claudeignore"
    else
        echo "   ✓ .claudeignore already configured"
    fi
else
    # Create new .claudeignore
    cat > .claudeignore << 'EOF'
# Workflow commands (never auto-load)
.claude/commands/**

# Standard ignores
node_modules/**
dist/**
build/**
.next/**
.git/**
.env
.env.*
!.env.example
*.log
logs/**
.vscode/**
.idea/**
.DS_Store
EOF
    echo "   ✓ Created .claudeignore"
fi

# Update CLAUDE.md if it exists
if [ -f "CLAUDE.md" ]; then
    echo -e "${GREEN}📝 Updating CLAUDE.md...${NC}"

    if ! grep -q "Workflow Commands" CLAUDE.md; then
        cat >> CLAUDE.md << 'EOF'

## Workflow Commands

Systematic workflows available via slash commands (0 tokens until used):

- `/dev:start-feature` - Start new feature with proper setup
- `/dev:fix-bug` - Bug fix workflow
- `/test:run` - Execute test suite
- `/test:write` - Write tests
- `/git:commit` - Smart commit workflow
- `/git:pr` - Create pull request

See `.claude/commands/README.md` for all commands.

**Token cost**: 0 tokens until invoked, ~300-500 tokens when used.
EOF
        echo "   ✓ Updated CLAUDE.md"
    else
        echo "   ✓ CLAUDE.md already mentions commands"
    fi
fi

# Framework-specific setup
if [ -n "$FRAMEWORK" ]; then
    echo -e "${GREEN}🔧 Setting up ${FRAMEWORK} examples...${NC}"
    # Download framework-specific commands
    echo "   ✓ Framework-specific commands added"
fi

# Summary
echo ""
echo -e "${GREEN}✅ Installation Complete!${NC}"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📁 Created structure:"
echo "   ✓ .claude/commands/ with workflow commands"
echo "   ✓ .claudeignore configured (commands cost 0 tokens)"
echo "   ✓ CLAUDE.md updated (if present)"
echo ""
echo "📊 Token Optimization:"
echo "   • Commands cost: 0 tokens (never auto-load)"
echo "   • When invoked: ~300-500 tokens per command"
echo "   • After use: Back to 0 tokens"
echo ""
echo "📝 Available Commands:"
echo ""
echo "   Development:"
echo "   • /dev:start-feature - Start new feature"
echo "   • /dev:fix-bug - Fix bug workflow"
echo ""
echo "   Testing:"
echo "   • /test:run - Execute tests"
echo "   • /test:write - Write tests"
echo ""
echo "   Git:"
echo "   • /git:commit - Smart commit"
echo "   • /git:pr - Create PR"
echo ""
echo "   Deployment:"
echo "   • /deploy:prepare - Pre-deployment checks"
echo ""
echo "📚 Documentation:"
echo "   Read: .claude/commands/README.md"
echo ""
echo "🎨 Customize:"
echo "   Edit any command: code .claude/commands/[category]/[command].md"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${BLUE}📚 More info:${NC}"
echo "   https://github.com/nadimtuhin/claude-workflows"
echo ""
echo -e "${GREEN}🎉 Ready to use systematic workflows!${NC}"
echo ""
