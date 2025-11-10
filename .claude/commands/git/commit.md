# /git:commit

Create a well-formatted commit using conventional commit format.

## When to Use

When you're ready to commit changes:
- Feature work is complete and tested
- Bug fix is verified
- Refactoring is validated
- Documentation is updated

**Not for**: Work-in-progress commits (use `git commit -m "wip"` directly)

## Prerequisites

- [ ] Tests pass
- [ ] Code is formatted/linted
- [ ] You understand what changed

## Steps

### 1. Review Changes

```bash
git status
git diff
```

Make sure you understand:
- What files changed
- Why they changed
- What the impact is

### 2. Stage Changes

```bash
# Stage specific files
git add path/to/file.js

# Or stage all changes
git add .
```

**Don't commit:**
- `.env` files with secrets
- `node_modules/`
- Build artifacts (`dist/`, `.next/`)
- IDE settings (`.vscode/`, `.idea/`)
- Personal files

### 3. Determine Commit Type

Choose the appropriate type:

| Type | When to Use | Example |
|------|-------------|---------|
| `feat` | New feature | `feat: add user authentication` |
| `fix` | Bug fix | `fix: resolve login redirect loop` |
| `docs` | Documentation only | `docs: update API examples` |
| `style` | Formatting, no code change | `style: fix indentation in utils` |
| `refactor` | Code change, no behavior change | `refactor: extract validation logic` |
| `perf` | Performance improvement | `perf: memoize expensive calculation` |
| `test` | Add or update tests | `test: add integration tests for auth` |
| `chore` | Maintenance, config, deps | `chore: update dependencies` |
| `ci` | CI/CD changes | `ci: add test coverage reporting` |
| `build` | Build system changes | `build: optimize webpack config` |
| `revert` | Revert previous commit | `revert: undo feature X` |

### 4. Determine Scope (Optional)

Scope indicates what area changed:

```
feat(auth): add password reset
fix(api): handle null user response
docs(readme): update installation steps
```

**Common scopes:**
- `auth`, `api`, `ui`, `db`, `tests`, `config`
- Component names: `ProfileCard`, `UserList`
- Feature areas: `payment`, `admin`, `search`

### 5. Write Commit Message

```bash
git commit
```

**Format:**
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Subject line rules:**
- Lowercase, no period at end
- Imperative mood: "add" not "added" or "adds"
- Max 50 characters
- Describe what the commit does

**Body (optional):**
- Explain why, not what
- Wrap at 72 characters
- Blank line after subject

**Footer (optional):**
- Breaking changes: `BREAKING CHANGE: ...`
- Issue references: `Closes #123`
- Co-authors: `Co-Authored-By: Name <email>`

### 6. Add Claude Co-Author

If Claude helped significantly, add:

```
🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>
```

### 7. Push Changes

```bash
# Push to remote
git push origin feature/feature-name

# Or if first push
git push -u origin feature/feature-name
```

## Validation

Before pushing:

- [ ] Commit message follows format
- [ ] Subject is clear and descriptive
- [ ] No sensitive data committed
- [ ] Tests still pass after commit

## Examples

### Feature Commit
```bash
git commit -m "feat(auth): add password reset flow

Implements password reset via email token.
Users can now reset forgotten passwords.

- Add password reset request endpoint
- Add token validation
- Add password update endpoint
- Add email templates
- Add tests

Closes #45

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"
```

### Bug Fix Commit
```bash
git commit -m "fix(api): prevent null pointer in user lookup

Previously crashed when userId was undefined.
Now returns 404 with proper error message.

Fixes #78"
```

### Documentation Commit
```bash
git commit -m "docs: add API authentication examples

Add code examples for:
- JWT token authentication
- API key usage
- OAuth flow

Co-Authored-By: Claude <noreply@anthropic.com>"
```

### Refactor Commit
```bash
git commit -m "refactor(services): extract validation logic

Move validation from controllers to dedicated
validator service for reusability.

No behavior changes, just code organization."
```

## Common Mistakes

**❌ Don't:**
- Use vague messages: "fix stuff", "updates", "wip"
- Commit too many unrelated changes at once
- Commit sensitive data (API keys, passwords)
- Skip tests before committing

**✅ Do:**
- Make atomic commits (one logical change)
- Write descriptive messages
- Reference issues when applicable
- Test before committing

## Commit Message Tips

**Bad:**
```
fix bug
update code
changes
wip
```

**Good:**
```
fix(auth): resolve token expiration edge case
feat(ui): add loading spinner to dashboard
docs(api): document rate limiting
refactor(utils): simplify date formatting
```

## Breaking Changes

If your commit breaks backward compatibility:

```bash
git commit -m "feat(api): change authentication format

BREAKING CHANGE: JWT format changed from v1 to v2.
Clients must update to new auth library version.

Migration guide: docs/migration.md"
```

## Related Commands

- `/git:pr` - Create pull request after commits
- `/git:review` - Review code before committing
- `/dev:start-feature` - Start feature workflow

---

**Token cost**: ~300 tokens when invoked, 0 tokens otherwise
