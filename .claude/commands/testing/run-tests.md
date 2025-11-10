# /test:run

Execute test suite with proper validation and reporting.

## When to Use

- Before committing code
- After implementing a feature
- Before creating a pull request
- When debugging test failures
- During CI/CD pipeline setup

## Prerequisites

- [ ] Tests exist
- [ ] Dependencies installed
- [ ] Test environment configured

## Steps

### 1. Run Quick Tests First

Start with fast unit tests:

```bash
# Run unit tests only
npm test -- --testPathPattern=unit

# Or specific test file
npm test path/to/test.spec.js

# Watch mode for development
npm test -- --watch
```

This gives quick feedback before running slower tests.

### 2. Run Full Test Suite

```bash
# All tests
npm test

# With coverage
npm test -- --coverage

# Verbose output
npm test -- --verbose
```

### 3. Check Coverage

Coverage tells you what's tested:

```bash
# Generate coverage report
npm test -- --coverage --coverageReporters=text --coverageReporters=html

# Open HTML report
open coverage/index.html
```

**Coverage goals:**
- **Unit tests**: 80%+ coverage
- **Integration tests**: Critical paths covered
- **E2E tests**: Happy paths covered

### 4. Run Integration Tests

If you have separate integration tests:

```bash
npm run test:integration

# Or
npm test -- --testPathPattern=integration
```

### 5. Run E2E Tests

End-to-end tests (Playwright, Cypress, etc):

```bash
npm run test:e2e

# Or headless
npm run test:e2e:headless

# Specific test
npm run test:e2e -- --spec=login.spec.js
```

### 6. Validate Results

Check for:
- [ ] All tests pass
- [ ] No skipped tests (unless intentional)
- [ ] Coverage meets thresholds
- [ ] No console errors/warnings
- [ ] Performance within acceptable range

### 7. Handle Failures

If tests fail:

```bash
# Run failed tests only
npm test -- --onlyFailures

# Debug specific test
npm test -- --testNamePattern="should validate user input"

# Run with debugger
node --inspect-brk node_modules/.bin/jest --runInBand
```

See `/test:debug` for detailed debugging workflow.

## Validation

Before considering tests complete:

- [ ] All tests pass
- [ ] Coverage meets team standards
- [ ] No flaky tests (run twice to confirm)
- [ ] Tests run in reasonable time (<5 min for unit)
- [ ] No warnings or deprecation notices

## Test Output Interpretation

### Success
```
PASS src/utils/validation.test.js
  ✓ validates email format (3ms)
  ✓ rejects invalid email (2ms)

Test Suites: 1 passed, 1 total
Tests:       2 passed, 2 total
Time:        1.234s
```

### Failure
```
FAIL src/services/auth.test.js
  ✕ should authenticate user (15ms)

  Expected: 200
  Received: 401

  at auth.test.js:42:23
```

**Next steps for failure:**
1. Read error message carefully
2. Check what's expected vs received
3. Review test setup
4. Debug with `/test:debug`

### Coverage Report
```
File                | % Stmts | % Branch | % Funcs | % Lines
--------------------|---------|----------|---------|--------
All files          |   87.5  |   83.33  |    100  |   87.5
 auth.service.js   |    100  |     100  |    100  |    100
 user.service.js   |      75  |   66.67  |    100  |      75
```

**Coverage metrics:**
- **Statements**: Lines of code executed
- **Branches**: If/else paths taken
- **Functions**: Functions called
- **Lines**: Physical lines executed

## Framework-Specific Commands

### Jest (JavaScript/TypeScript)
```bash
npm test
npm test -- --coverage
npm test -- --watch
npm test -- --u  # Update snapshots
```

### Vitest (Vite projects)
```bash
npm run test
npm run test:ui
npm run coverage
```

### Pytest (Python)
```bash
pytest
pytest --cov
pytest -v  # Verbose
pytest -k test_function  # Specific test
```

### RSpec (Ruby/Rails)
```bash
rspec
rspec spec/models
rspec spec/models/user_spec.rb:42  # Specific line
```

### PHPUnit (PHP/Laravel)
```bash
php artisan test
php artisan test --coverage
php artisan test --filter=UserTest
```

## Common Issues

### Tests Pass Locally, Fail in CI

**Causes:**
- Environment differences
- Timezone issues
- Race conditions
- Missing dependencies

**Fix:**
```bash
# Run in CI-like environment
docker run --rm -v $(pwd):/app node:18 npm test
```

### Flaky Tests

**Symptoms:**
- Sometimes pass, sometimes fail
- Fail when run in parallel
- Timing-dependent

**Fix:**
```bash
# Run multiple times
for i in {1..10}; do npm test; done

# Run in sequence (not parallel)
npm test -- --runInBand
```

### Slow Tests

**Optimization:**
```bash
# Identify slow tests
npm test -- --verbose

# Run only fast tests during development
npm test -- --testPathPattern=unit

# Full suite before commit
npm test
```

## Related Commands

- `/test:write` - Write new tests
- `/test:debug` - Debug failing tests
- `/test:e2e` - Run E2E tests specifically
- `/dev:start-feature` - Includes test execution

---

**Token cost**: ~350 tokens when invoked, 0 tokens otherwise
