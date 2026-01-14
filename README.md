# Thanisorn Automation Test Project

This project contains Python scripts and Playwright test automation files.

## Project Structure

- **No1/** - Python script: Finding duplicates between lists
- **No2/** - Playwright test: Login page automation
- **No3/** - Playwright test: API testing
- **No6/** - Python script: Simple cipher decryption

## Prerequisites

### 1. Python (for Python scripts)

- **Download**: [Python 3.8+](https://www.python.org/downloads/)
- **Verify installation**:
  ```bash
  python --version
  ```
  or
  ```bash
  python3 --version
  ```

### 2. Node.js (for Playwright tests)

- **Download**: [Node.js 16+](https://nodejs.org/)
- **Verify installation**:
  ```bash
  node --version
  npm --version
  ```

## Setup Instructions

### Step 1: Install Node.js Dependencies (for Playwright tests)

1. Open terminal in the project root directory
2. Install dependencies:
   ```bash
   npm install
   ```
3. Install Playwright browsers:
   ```bash
   npx playwright install
   ```

### Step 2: Install Python Dependencies (optional)

The current Python scripts use only standard library modules, so no installation is needed. However, if you add dependencies in the future:

```bash
pip install -r requirements.txt
```

## Running the Code

### Python Scripts

#### No1: Find Duplicates
```bash
python No1/find_duplicates_1.py
```

#### No6: Simple Cipher
```bash
python No6/simpleCipher.py
```

### Playwright Tests

#### Run all tests:
```bash
npm test
```

#### Run specific test files:
```bash
# Login test
npm run test:login

# API test
npm run test:api

# All tests
npm run test:all
```

#### Run with Playwright directly:
```bash
# Run specific file
npx playwright test No2/login.spec.js
npx playwright test No3/api.spec.js

# Run all tests in directories
npx playwright test No2 No3
```

## Quick Setup Summary

For Windows PowerShell/Command Prompt:

```powershell
# 1. Install Node.js dependencies
npm install

# 2. Install Playwright browsers
npx playwright install

# 3. Run Python scripts
python No1/find_duplicates_1.py
python No6/simpleCipher.py

# 4. Run Playwright tests
npm test
```

## Notes

- Make sure you have internet connection for Playwright tests (they test external websites)
- Python scripts can run independently without any installation if Python is installed
- Playwright tests require Node.js and npm to be installed
