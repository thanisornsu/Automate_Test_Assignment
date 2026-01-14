# Minimal-Todo Android App Test Automation

Robot Framework + Appium test automation suite for Minimal-Todo Android application.

## Project Structure

```
robot-mobile-tests/
├── tests/
│   ├── test_cases/          # Test suite files
│   ├── resources/
│   │   ├── keywords/       # Reusable keywords and page objects
│   │   └── variables/       # Configuration and test data
│   └── results/            # Test reports and logs
├── app/                    # APK file location
├── requirements.txt        # Python dependencies
└── README.md              # This file
```

## Prerequisites

1. **Python 3.8+** installed
2. **Appium Server** (v2.0+) installed and running
3. **Android SDK** with ADB tools
4. **Android Emulator** or physical device connected
5. **APK File** located in `app/minimal-todo.apk`

## Installation

1. Install Python dependencies:
```bash
pip install -r requirements.txt
```

2. Start Appium Server:
```bash
appium
```
   Or use Appium Desktop GUI application.

3. Ensure Android device/emulator is connected:
```bash
adb devices
```

## Configuration

Edit `tests/resources/variables/app_config.robot` to configure:
- Appium server URL (default: `http://localhost:4723`)
- Device name
- App package and activity
- APK file path

## Running Tests

### Run all tests:
```bash
robot -d tests/results tests/test_cases/todo_crud_tests.robot
```

### Run tests by tag:
```bash
# Run only critical tests
robot -d tests/results --include critical tests/test_cases/todo_crud_tests.robot

# Run only smoke tests
robot -d tests/results --include smoke tests/test_cases/todo_crud_tests.robot
```

### Run specific test:
```bash
robot -d tests/results -t "TC001: Create Todo - Basic" tests/test_cases/todo_crud_tests.robot
```

## Test Cases

The suite includes 7 critical path test cases:

1. **TC001**: Create Todo - Basic
2. **TC002**: Create Todo - With Reminder
3. **TC003**: View Todo List
4. **TC004**: Edit Todo
5. **TC005**: Delete Todo - Swipe
6. **TC006**: Delete Todo - Multiple
7. **TC007**: Empty State Verification

## Test Reports

After execution, reports are generated in `tests/results/`:
- `report.html` - HTML test report
- `log.html` - Detailed execution log
- `output.xml` - XML output for CI/CD integration

## Troubleshooting

### Appium Connection Issues
- Ensure Appium server is running on port 4723
- Check device connection: `adb devices`
- Verify device is authorized (check for "unauthorized" status)

### Element Not Found Errors
- Use `uiautomatorviewer` or Appium Inspector to verify element IDs
- Check if app package name matches in `app_config.robot`
- Ensure app is installed: `adb install app/minimal-todo.apk`

### Test Failures
- Screenshots are automatically captured on failure in `tests/results/`
- Check Appium server logs for detailed error messages
- Verify Android emulator/device is responsive

## Element Identification

If element IDs change or tests fail, use:
- **uiautomatorviewer**: `uiautomatorviewer` (included with Android SDK)
- **Appium Inspector**: Built into Appium Desktop
- **ADB**: `adb shell uiautomator dump` to get UI hierarchy

## Notes

- Tests use Page Object Model pattern for maintainability
- Screenshots are captured automatically on test failures
- App data is reset between test runs (configurable in `app_config.robot`)

