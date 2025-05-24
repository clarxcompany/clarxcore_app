# Contributing to ClarxCore App

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/clarxcompany/clarxcore_app/pulls)  
[![Code of Conduct](https://img.shields.io/badge/Code%20of%20Conduct-enforced-yellowgreen.svg)](./CODE_OF_CONDUCT.md)

---

## 📋 Table of Contents

1. [How to Contribute](#-how-to-contribute)
2. [Branching Strategy](#-branching-strategy)
3. [Commit Message Guidelines](#-commit-message-guidelines)
4. [Coding Standards](#-coding-standards)
5. [Testing](#-testing)
6. [Pull Request Process](#-pull-request-process)
7. [Reporting Issues](#-reporting-issues)
8. [Code of Conduct](#-code-of-conduct)

---

## 🛠 How to Contribute

1. **Fork** the repository on GitHub.
2. **Clone** your fork locally:
   ```bash
   git clone https://github.com/<your-username>/clarxcore_app.git
   cd clarxcore_app
   ```
3. **Install dependencies:**
   ```bash
   flutter pub get
   ```
4. **Create a feature branch off `main`:**
   ```bash
   git checkout -b feature/your-feature-name
   ```
5. **Make your changes, then commit and push to your fork.**

---

## 🌿 Branching Strategy

- **`main`**  
  Always production-ready.

- **`feature/`**  
  New features or enhancements.
  ```bash
  git checkout -b feature/awesome-feature
  ```

- **`hotfix/`**  
  Critical fixes on main.
  ```bash
  git checkout -b hotfix/urgent-fix
  ```

- **`release/`**  
  Prepare a new release candidate.

> When your work is done, open a Pull Request against `main`.

---

## 📝 Commit Message Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <short summary>

[optional body]

[optional footer(s)]
```

- **type:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`
- **scope:** (optional) component or file
- **short summary:** imperative, ≤ 50 chars

**Example:**
- `feat(auth): add Google Sign-In button`
- `fix(login): validate email format`
- `docs: update README screenshots`
- `test(register): add widget tests for step1`

---

## 💻 Coding Standards

- **Format your code:**
  ```bash
  flutter format .
  ```
- **Analyze for issues:**
  ```bash
  flutter analyze
  ```
- **Style:**
   - 2-space indent
   - Trailing commas where appropriate
   - Clear variable and class names

---

## 🧪 Testing

- Write unit tests in the `test/` directory for logic.
- Write widget tests for UI flows.
- Run all tests locally:
  ```bash
  flutter test
  ```

---

## 🚀 Pull Request Process

1. Push your branch to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```
2. Open a Pull Request on GitHub, targeting `clarxcompany/clarxcore_app:main`.
3. In your PR description, include:
   - Purpose of the change
   - How to test
   - Screenshots or logs, if relevant
4. Wait for CI checks to pass.
5. Address review feedback.
6. Once approved, your PR will be merged!

---

## 🐛 Reporting Issues

- For bugs, open an Issue:
   - Describe the problem clearly.
   - Steps to reproduce.
   - Expected vs. actual behavior.
- For feature requests, open an Issue with a clear description.

---

## 📜 Code of Conduct

All contributors must follow our [Code of Conduct](./CODE_OF_CONDUCT.md). Please read it before participating.

---

Thank you for helping make **ClarxCore App** better! 🚀