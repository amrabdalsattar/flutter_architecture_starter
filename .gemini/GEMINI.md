# Project Global Engineering Rules

---

## Code Quality

**1. Clean Code Always**
- Keep code clean, readable, and maintainable
- Choose clarity over cleverness

**2. Small Files and Functions**
- Files and functions must stay small and focused
- Single Responsibility Principle — one reason to change
- Avoid large classes or overcomplicated files

**3. Comments Only When Necessary**
- Comments should explain *why*, not *what*
- Avoid narrating obvious code

**4. No Business Logic in UI**
- UI must only handle rendering, user interaction, and state observation

**5. No Unnecessary Abstraction**
- Introduce abstraction only when it has clear, immediate value
- Avoid speculative generalization

---

## Problem Solving

**6. Root Cause First**
- Don't treat symptoms — find and fix the root cause

**7. No Trendy Fixes**
- Avoid applying patterns just because they're popular
- Choose boring, proven solutions over clever ones

**8. Minimal Safe Changes**
- Make the smallest change that correctly fixes the issue
- Avoid unnecessary refactoring alongside bug fixes
- Do not introduce breaking changes unless explicitly required

**9. Follow Repository Coding Standards**
- Match existing patterns, naming conventions, and file structure
- When in doubt, follow what already exists in the codebase

---

## Reliability

**10. Edge Cases and Error Handling**
- Do not allow silent failures
- Handle all error paths explicitly
- Never swallow exceptions without logging or handling them

**11. Handle Async Operations Safely**
- Always handle loading, success, and failure states
- Avoid unawaited futures unless intentional and documented
- Prevent race conditions and duplicate requests
- Cancel or ignore outdated requests when newer ones supersede them

**12. State Management Must Be Predictable**
- Keep state centralized and controlled (Cubit)
- Avoid scattered or duplicated mutable state
- UI reacts to state — it never drives business logic

---

## Dependencies & Security

**13. Don't Add Packages Unless Necessary**
- Any added package must be the latest stable version, well-maintained, and production-ready
- Justify every addition — prefer solving problems with existing tools first

**14. Proactively Warn About Security Risks**
- Never hard-code tokens, secrets, API keys, or credentials
- Never log sensitive user data
- Validate and sanitize all external input

---

## Standards & Best Practices

**15. Follow Modern Best Practices**
- Follow current Dart and Flutter standards
- Null safety must be fully respected — no `!` without certainty
- Use lints and follow project analyzer rules
- Prefer `const` constructors everywhere applicable
- Never extract a widget into a private function (e.g. `Widget _buildHeader()`)
- Always extract widgets into their own dedicated file and class

**16. Act as a Senior Engineer Partner**
- Suggest improvements when they add clear value
- Think critically — don't just implement, understand
- Briefly explain trade-offs when multiple valid approaches exist
- Flag technical debt when encountered, even if not fixing it now

**17. No Assumptions Without Verification**
- Read and understand relevant code before modifying it
- Don't assume behavior — verify it
- When context is missing, ask before proceeding

---

## Data Layer

**18. Data Layer Must Be Structured**
- Use explicit request/response models
- No raw JSON handling in UI or business logic
- Map API models to domain models when needed
- Handle and surface API errors explicitly — never silently ignore them

---

## Performance

**19. Performance Matters**
- Avoid unnecessary widget rebuilds
- Use `const` constructors wherever possible
- Use `ListView.builder` with pagination for large or dynamic lists
- Avoid expensive computation on the main thread — offload when needed
- Profile before optimizing — don't guess

---

## Observability

**20. Logging Is Structured and Meaningful**
- Log important flows, decisions, and failures
- Logs must be meaningful — avoid noise
- Never log sensitive or personal data
- Errors must always include enough context to reproduce and debug

---

## UX

**21. UX Awareness**
- Always handle loading, empty, and error states — never leave the user without feedback
- Avoid blocking the UI thread
- Provide clear, timely feedback for every user action
- Respect platform conventions (back navigation, keyboard behavior, scroll physics)

---

## Testability

**22. Write Testable Code**
- Avoid hard dependencies — inject them
- Pure functions are preferred for business logic
- Keep side effects at the edges of the system
- If code is hard to test, it's a signal the design needs improvement

---

## Task Completion Checklist

**23. Before Finishing Any Task, Verify:**
1. The root cause is correctly identified and addressed
2. The solution is safe, minimal, and doesn't over-engineer
3. No existing functionality is broken
4. Architecture and coding rules are respected
5. No business logic has leaked into the UI
6. No performance regressions introduced
7. No security issues introduced
8. All error paths are handled

Then provide a brief summary of: **what** was changed, **why** it was changed, and **why** the solution is safe and correct.

**24. When a Task Is Marked Done, Provide:**
- Branch name
- Commit message
- PR title
- PR description