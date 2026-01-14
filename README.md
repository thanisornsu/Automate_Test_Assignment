# Thanisorn Automation Test Project

This project contains Python scripts and Playwright test automation files.

## Project Structure

- **No1/** - Python script: Finding duplicates between lists
- **No2/** - Playwright test: Login page automation
- **No3/** - Playwright test: API testing
- **No4/** - Robot Framework: Mobile app automation (Android)
- **No5/** - Jenkins pipeline: CI/CD configuration for Playwright tests
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

### 3. Robot Framework & Appium (for No4 mobile tests)

- **Robot Framework**: Install via pip
  ```bash
  pip install robotframework robotframework-appiumlibrary Appium-Python-Client
  ```
- **Appium Server**: [Download Appium](https://appium.io/docs/en/2.0/quickstart/install/)
- **Android SDK**: Required for Android emulator/device
- **Note**: Mobile tests require Appium server running and Android device/emulator connected

### 4. Jenkins (for No5 CI/CD pipeline - Optional)

- **Jenkins**: [Download Jenkins](https://www.jenkins.io/download/)
- **Note**: Jenkins pipeline is configured for Playwright tests automation

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

### Step 2: Install Python Dependencies

For No4 Robot Framework mobile tests:

```bash
cd No4/robot-mobile-tests
pip install -r requirements.txt
```

Note: No1 and No6 Python scripts use only standard library, so no installation needed.

### Step 3: Setup Appium (for No4 mobile tests - Optional)

1. Install Appium Server (if not already installed)
2. Start Appium server:
   ```bash
   appium
   ```
3. Connect Android device/emulator:
   ```bash
   adb devices
   ```

## Running the Code

### Python Scripts

#### No1: Find Duplicates

```bash
python No1/find_duplicates.py
```

#### No6: Simple Cipher

```bash
python No6/simpleCipher.py
```

### Robot Framework Mobile Tests (No4)

#### Prerequisites:

- Appium server must be running
- Android device/emulator must be connected

#### Run all mobile tests:

```bash
cd No4/robot-mobile-tests
python -m robot -d tests/results tests/test_cases/todo_crud_tests_clean.robot
```

#### Run specific test:

```bash
cd No4/robot-mobile-tests
python -m robot -d tests/results -t "TC001: Create Todo - Basic" tests/test_cases/todo_crud_tests_clean.robot
```

**Note**: Mobile tests require Appium server and Android environment setup. See `No4/robot-mobile-tests/README.md` for detailed setup instructions.

### Jenkins Pipeline (No5)

The Jenkinsfile in `No5/` is configured to run Playwright tests in a CI/CD pipeline.

#### Setup in Jenkins:

1. **Create a new Pipeline job** in Jenkins
2. **Configure the pipeline**:
   - Select "Pipeline script from SCM"
   - Choose Git as SCM
   - Repository URL: Your Git repository URL
   - Script Path: `No5/Jenkinsfile`
3. **Update environment variables** in `No5/Jenkinsfile`:
   - `GIT_REPO`: Your repository URL
   - `GIT_BRANCH`: Branch to checkout (default: `main`)
4. **Run the pipeline** - Jenkins will:
   - Checkout code from Git
   - Install Node.js dependencies
   - Install Playwright browsers
   - Run Playwright tests
   - Display test results

#### Pipeline Stages:

- **Checkout Code From Git**: Gets code from repository
- **Run Test Automate**: Installs dependencies and runs Playwright tests
- **Send Result To Jenkins**: Publishes test results

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

# 3. Install Robot Framework dependencies (for No4)
cd No4/robot-mobile-tests
pip install -r requirements.txt
cd ../..

# 4. Run Python scripts
python No1/find_duplicates.py
python No6/simpleCipher.py

# 5. Run Playwright tests
npm test

# 6. Run Robot Framework mobile tests (requires Appium + Android device)
cd No4/robot-mobile-tests
python -m robot -d tests/results tests/test_cases/todo_crud_tests_clean.robot

# 7. Jenkins Pipeline (No5)
# Configure Jenkins job to use No5/Jenkinsfile for CI/CD automation
```

## Notes

- Make sure you have internet connection for Playwright tests (they test external websites)
- Python scripts (No1, No6) can run independently without any installation if Python is installed
- Playwright tests (No2, No3) require Node.js and npm to be installed
- Robot Framework mobile tests (No4) require Appium server, Android SDK, and device/emulator setup
- Jenkins pipeline (No5) is optional and requires Jenkins server installation
- See individual folder READMEs for detailed setup instructions
