# Code Review Skill

## Purpose

Perform thorough code reviews with consistent standards and project-specific customizations.

## When to Use

**User invokes with:**
- `/code-review` - Review current changes
- `/code-review [file]` - Review specific file
- `/code-review [PR-number]` - Review PR

**Proactively offer when:**
- User creates PR or asks to review code
- Large diff about to be committed (>200 lines changed)

## Project-Specific Customization

**IMPORTANT:** This skill checks for project-specific review guidelines in two places:

1. **Project CLAUDE.md** - Check for "Code Review" section with:
   - Required checks (security, performance, accessibility)
   - Language-specific linters/formatters to run
   - CI/CD validation requirements
   - Allowed/disallowed patterns

2. **Project files** - Check for these files:
   - `.github/PULL_REQUEST_TEMPLATE.md` - PR checklist items
   - `CONTRIBUTING.md` - Contribution guidelines
   - `.eslintrc`, `.pylintrc`, etc. - Linting standards

**If found:** Merge project rules with base standards below.
**If not found:** Use base standards only.

## Base Review Standards

Apply these universally unless overridden by project config:

### 1. Code Quality
- [ ] Logic is clear and correct
- [ ] No obvious bugs or edge cases missed
- [ ] Error handling appropriate for failure modes
- [ ] No unnecessary complexity

### 2. Security
- [ ] No SQL injection, XSS, command injection risks
- [ ] Secrets/credentials not hardcoded
- [ ] Input validation at boundaries
- [ ] Authentication/authorization checked where needed

### 3. Testing
- [ ] New code has test coverage
- [ ] Tests actually validate the functionality
- [ ] Edge cases covered
- [ ] Tests pass (run them before review completion)

### 4. Style & Maintainability
- [ ] Follows project conventions (if identifiable)
- [ ] Names are clear and descriptive
- [ ] Comments only where logic isn't self-evident
- [ ] No dead code or commented-out blocks

### 5. Performance
- [ ] No obvious performance issues (N+1 queries, unnecessary loops)
- [ ] Appropriate algorithms and data structures

## Review Output Format

Provide review in this structure:

```markdown
## Code Review Summary

**Scope:** [describe what was reviewed]
**Overall:** [APPROVED / NEEDS CHANGES / BLOCKING ISSUES]

## Critical Issues
[P0/P1 issues that must be fixed - security, bugs, breaking changes]

## Suggestions
[P2 improvements - code quality, maintainability, performance]

## Positive Notes
[Things done well - specific callouts]

## Checklist Status
- [x] Security reviewed
- [x] Tests validated
- [ ] Performance considerations
[etc - based on project requirements]
```

## Implementation Guidelines

**Start every review by:**
1. Check for project CLAUDE.md "Code Review" section
2. Check for CONTRIBUTING.md, PR templates
3. Identify language and look for linter configs
4. Build combined checklist (project + base)

**Review workflow:**
1. `git diff` or read files to understand changes
2. Run tests if available: `make test`, `npm test`, etc.
3. Run linters if configured: `make lint`, `npm run lint`, etc.
4. Apply merged checklist
5. Output findings in standard format

**Tone:**
- Be specific with line numbers (file:line format)
- Suggest concrete fixes, not just problems
- Balance criticism with positive feedback
- Escalate blocking issues clearly

**Automation:**
- Run available tests/linters automatically
- Don't suggest tests/linters if project doesn't have them
- Read config files to understand standards, don't guess
