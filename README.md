# ClarxCore App
[![Sponsor](https://img.shields.io/badge/Sponsor-GitHub%20Sponsors-ff69b4)](https://github.com/sponsors/clarxcompany)
[![Open Collective](https://img.shields.io/badge/Sponsor-Open%20Collective-51cf66)](https://opencollective.com/clarxcore-app)
[![Flutter](https://img.shields.io/badge/Flutter-3.22.0-blue.svg)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Build Status](https://github.com/clarxcompany/clarxcore_app/actions/workflows/flutter-ci.yml/badge.svg)](https://github.com/clarxcompany/clarxcore_app/actions/workflows/flutter-ci.yml)

---

## 📖 Table of Contents

- [🚀 Overview](#-overview)
- [🔑 Key Features](#-key-features)
- [📸 Screenshots](#-screenshots)
- [🛠️ Getting Started](#️-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation & Running](#installation--running)
- [📂 Project Structure](#-project-structure)
- [⚙️ Configuration](#️-configuration)
- [🌿 Branching & Versioning](#️-branching--versioning)
- [🤝 Contributing](#-contributing)
- [📜 License](#-license)
- [📬 Contact](#-contact)
- [💾 Next Steps](#-next-steps)

---

## 🚀 Overview

**ClarxCore** is a cross-platform Flutter app that gamifies your daily routines and fitness goals into “missions.”  
Built with Firebase for secure auth and real-time data, it offers:

- Intuitive multi-step registration
- Custom splash & onboarding flows
- Daily task reminders & AI-powered suggestions
- Community invites & weekly progress reports

> **ClarxCore** is modular and scalable—it's the foundation for ClarxCompany projects like **clarxAI**, **clarxcoin**, and more.

---

## 🔑 Key Features

### 🎬 Branded Splash & Auto-Routing

3s animated splash → smart redirect based on login state.

<div align="center">
  <img src="docs/screenshots/splash.png" alt="Splash Screen" width="200"/>
</div>

---

### 🔒 Secure Authentication

Email/password + Google/Facebook SSO, with user-friendly choice screens.

<div align="center">
  <img src="docs/screenshots/auth_choice1.png" alt="Auth Choice 1" width="150" style="margin:0 10px;"/>
  <img src="docs/screenshots/auth_choice2.png" alt="Auth Choice 2" width="150" style="margin:0 10px;"/>
</div>

---

### 📝 Streamlined Registration

Multi-step forms, validation, and progress bar.

<div align="center">
  <img src="docs/screenshots/register_step1.png" alt="Register Step 1" width="150" style="margin:0 10px;"/>
  <img src="docs/screenshots/register_step2.png" alt="Register Step 2" width="150" style="margin:0 10px;"/>
</div>

---

### ⏰ Task Reminders & AI Suggestions

Schedule daily missions, get smart reminders and actionable tips.

---

### 🌐 Community & Reports

Invite friends, share progress, and receive weekly summaries.

---

### 📊 Real-Time Dashboard

Live overview of active missions & history.

<div align="center">
  <img src="docs/screenshots/dashboard.png" alt="Dashboard" width="200"/>
</div>

---

### 🎨 Theming & Accessibility

Light/dark modes, responsive layout, and high-contrast support.

---

## 📸 Screenshots

<div align="center">
  <img src="docs/screenshots/auth_choice3.png" alt="Auth Choice 3" width="180"/>
  <img src="docs/screenshots/auth_choice4.png" alt="Auth Choice 4" width="180"/>
  <img src="docs/screenshots/auth_choice5.png" alt="Auth Choice 5" width="180"/>
</div>

---

## 🛠️ Getting Started

### Prerequisites

- Flutter SDK ≥ 3.22.0
- Android Studio or Xcode (for emulators & tooling)
- Firebase project with **Authentication** & **Firestore** enabled

### Installation & Running

```bash
# 1. Clone the repo
git clone https://github.com/clarxcompany/clarxcore_app.git
cd clarxcore_app

# 2. Install dependencies
flutter pub get

# 3. Run on default device
flutter run
```

---

## 📂 Project Structure

```plaintext
clarxcore_app/
├─ android/                  # Android native code
├─ ios/                      # iOS native code
├─ lib/
│  ├─ main.dart              # Entry & app theme
│  ├─ firebase_options.dart  # Firebase config
│  ├─ screens/               # UI flows
│  │   ├─ splash_screen.dart
│  │   ├─ auth_choice_screen.dart
│  │   ├─ register_flow.dart
│  │   ├─ login_page.dart
│  │   └─ home_screen.dart
│  ├─ services/              # Business logic & Firestore
│  └─ widgets/               # Reusable UI components
├─ assets/
│  ├─ icons/
│  ├─ images/
│  └─ legal/                 # Markdown docs
├─ docs/
│  └─ screenshots/
├─ test/                     # Unit & widget tests
└─ pubspec.yaml              # Dependencies & config
```

---

## ⚙️ Configuration

- **Theme colors:** `lib/main.dart`
- **Localization:** Intl settings in `lib/screens/step2_profile_contact.dart`
- **Notifications:** Managed per-user in Firestore
- **Integrations:** See `lib/screens/step5_device_integrations.dart`

---

## 🌿 Branching & Versioning

- **main:** protected, production-ready
- **feature/**: for new features (e.g., `feature/login-ui`)
- **hotfix/**: for urgent fixes
- **release/**: for release candidates

Follows [Semantic Versioning](https://semver.org/):

```yaml
version: 1.1.0+1
```

**Tagging:**
```bash
git tag -a v1.1.0 -m "Release 1.1.0 – added features"
git push origin v1.1.0
```

---

## 🤝 Contributing

- **Fork** the repo
- **Branch:**
  ```bash
  git checkout -b feature/your-feature
  ```
- **Commit:**
  ```bash
  git commit -m "feat: add awesome feature"
  ```
- **Push & PR** against `main`

**Templates:**
- Bug: `.github/ISSUE_TEMPLATE/bug_report.md`
- Feature: `.github/ISSUE_TEMPLATE/feature_request.md`
- PR: `.github/PULL_REQUEST_TEMPLATE.md`

For details, see [CONTRIBUTING.md](CONTRIBUTING.md).

---

## 📜 License

MIT License © 2025 ClarxCompany. See [LICENSE](LICENSE) for details.

---

## 📬 Contact

- **GitHub:** [clarxcompany/clarxcore_app](https://github.com/clarxcompany/clarxcore_app)
- **Email:** clarxcompany@gmail.com

---

## 💾 Next Steps

Save as `README.md` and:

```bash
git add README.md
git commit -m "docs: modernize README"
git push
```