# /dev:start-feature

Start a new feature with proper setup, scaffolding, and testing infrastructure.

## When to Use

Starting work on a new feature that requires:
- New files or components
- Database changes
- Tests
- Documentation updates

**Not for**: Quick fixes, typo corrections, or trivial changes (use regular workflow)

## Prerequisites

- [ ] Feature approved and requirements clear
- [ ] Main branch is up to date
- [ ] You understand the architecture

## Steps

### 1. Create Feature Branch

```bash
git checkout main
git pull origin main
git checkout -b feature/[feature-name]
```

**Branch naming convention:**
- `feature/user-authentication`
- `feature/payment-integration`
- `feature/admin-dashboard`

### 2. Review Architecture

Before creating files, understand where things go:

**If you have Claude Token Optimizer:**
```
Load: .claude/ARCHITECTURE_MAP.md
```

**Otherwise:**
- Review existing folder structure
- Find similar features to use as reference
- Understand naming conventions

### 3. Scaffold Files

Create necessary files in the right locations:

**Backend (API/Services):**
```
services/[feature-name].service.js
controllers/[feature-name].controller.js
models/[feature-name].model.js
routes/[feature-name].routes.js
```

**Frontend (Components):**
```
components/[FeatureName]/
├── index.tsx
├── [FeatureName].tsx
├── [FeatureName].test.tsx
└── [FeatureName].module.css
```

**Database:**
```
migrations/[timestamp]_create_[feature_name]_table.js
```

### 4. Write Tests First (TDD)

Before implementation, write failing tests:

```bash
# Run the test command
/test:write [feature-name]
```

**Test checklist:**
- [ ] Unit tests for business logic
- [ ] Integration tests for API endpoints
- [ ] Component tests for UI
- [ ] E2E tests for critical paths (optional)

### 5. Implement Feature

Now implement to make tests pass:

1. Start with simplest test case
2. Write minimal code to pass
3. Refactor for clarity
4. Move to next test case
5. Repeat

**Check COMMON_MISTAKES.md** as you code:
```
Load: .claude/COMMON_MISTAKES.md
```

### 6. Validate Implementation

```bash
# Run tests
npm test

# Type check
npm run type-check

# Lint
npm run lint

# Build
npm run build
```

All must pass before continuing.

### 7. Update Documentation

- [ ] Add to `.claude/COMMON_MISTAKES.md` if you discovered a pitfall
- [ ] Update `.claude/ARCHITECTURE_MAP.md` if you changed structure
- [ ] Add to `docs/learnings/` if you learned something reusable
- [ ] Update API docs if you added endpoints

### 8. Create Completion Doc

```bash
# Document what you built
touch .claude/completions/$(date +%Y-%m-%d)-[feature-name].md
```

Include:
- What was built
- Key decisions made
- Known limitations
- Testing approach
- Related files

### 9. Commit Work

```bash
# Use the commit command for proper format
/git:commit
```

## Validation

Before considering feature complete:

- [ ] All tests pass
- [ ] Type check passes
- [ ] Lint passes with no warnings
- [ ] Code reviewed (by you or teammate)
- [ ] Documentation updated
- [ ] No console errors/warnings
- [ ] Works in dev environment
- [ ] Completion doc created

## Example

```
User: "I need to add user profile editing feature"

Claude:
1. Creates feature/user-profile-editing branch
2. Reviews architecture for user-related code location
3. Scaffolds:
   - components/ProfileEdit/ProfileEdit.tsx
   - components/ProfileEdit/ProfileEdit.test.tsx
   - services/profile.service.ts
   - api/controllers/profile.controller.js
4. Writes failing tests:
   - User can update name
   - User can upload avatar
   - Validation works
5. Implements feature to pass tests
6. Runs validation (tests, types, lint)
7. Updates docs:
   - COMMON_MISTAKES.md: "Don't forget CSRF token in profile update"
   - ARCHITECTURE_MAP.md: "Profile components in components/Profile/"
8. Creates completion doc
9. Commits with /git:commit
```

## Common Mistakes

**❌ Don't:**
- Start coding before writing tests
- Skip documentation updates
- Commit without running tests
- Create files in wrong locations

**✅ Do:**
- Follow TDD (tests first)
- Update COMMON_MISTAKES.md when you find gotchas
- Run full validation before committing
- Document as you go, not at the end

## Related Commands

- `/test:write` - Write tests for feature
- `/test:run` - Execute test suite
- `/git:commit` - Commit with proper format
- `/dev:refactor` - Refactor after feature complete

---

**Token cost**: ~400 tokens when invoked, 0 tokens otherwise
