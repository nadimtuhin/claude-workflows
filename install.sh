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

# Files not published yet 404 and are skipped
DOWNLOADED=0
for COMMAND_FILE in \
    development/start-feature.md \
    development/fix-bug.md \
    testing/run-tests.md \
    testing/write-tests.md \
    git/commit.md \
    git/pr.md \
    deployment/prepare-release.md; do
    if curl -fsSL "${REPO_URL}/.claude/commands/${COMMAND_FILE}" \
        -o ".claude/commands/${COMMAND_FILE}" 2>/dev/null; then
        DOWNLOADED=$((DOWNLOADED + 1))
    fi
done

if [ "$DOWNLOADED" -eq 0 ]; then
    echo -e "${RED}❌ Could not download any commands from ${REPO_URL}${NC}"
    echo "   Check your network connection and try again."
    exit 1
fi

echo "   ✓ Downloaded ${DOWNLOADED} workflow commands"

# Create commands README
cat > .claude/commands/README.md << 'EOF'
# Workflow Commands

Commands are never auto-loaded (0 tokens). Claude Code names each command
after its file; the folder only groups them:

```
/command-name
```

## Available Commands

- `/start-feature` - Start new feature with proper setup (development/start-feature.md)
- `/run-tests` - Execute test suite with coverage (testing/run-tests.md)
- `/commit` - Smart commit with conventional format (git/commit.md)

## Usage

```bash
User: /start-feature user authentication

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

- `/start-feature` - Start new feature with proper setup
- `/run-tests` - Execute test suite
- `/commit` - Smart commit workflow

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
    echo -e "${YELLOW}⚠️  --framework ${FRAMEWORK}: framework-specific commands are not published yet; installed the generic ones${NC}"
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
echo "   • /start-feature - Start new feature"
echo "   • /run-tests - Execute tests"
echo "   • /commit - Smart commit"
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
