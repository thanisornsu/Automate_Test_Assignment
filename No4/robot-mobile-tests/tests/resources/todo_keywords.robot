*** Settings ***
Library    AppiumLibrary
Library    Collections

*** Variables ***
${BUTTON_ADD}          id=com.example.avjindersinghsekhon.minimaltodo:id/addToDoItemFAB
${BUTTON_SAVE}         id=com.example.avjindersinghsekhon.minimaltodo:id/makeToDoFloatingActionButton
${FIELD_TITLE}         id=com.example.avjindersinghsekhon.minimaltodo:id/userToDoEditText
${FIELD_DESCRIPTION}   id=com.example.avjindersinghsekhon.minimaltodo:id/userToDoDescription
${SWITCH_REMINDER}     id=com.example.avjindersinghsekhon.minimaltodo:id/toDoHasDateSwitchCompat
${FIELD_DATE}          id=com.example.avjindersinghsekhon.minimaltodo:id/newTodoDateEditText
${FIELD_TIME}          id=com.example.avjindersinghsekhon.minimaltodo:id/newTodoTimeEditText
${VIEW_LIST}           id=com.example.avjindersinghsekhon.minimaltodo:id/toDoRecyclerView
${VIEW_EMPTY}          id=com.example.avjindersinghsekhon.minimaltodo:id/toDoEmptyView
${BUTTON_OK}           id=android:id/button1

*** Keywords ***
Open App
    [Documentation]    Opens Minimal-Todo app with Appium
    [Arguments]    ${server_url}    ${app_package}    ${app_activity}    ${app_path}    ${timeout}
    Open Application    ${server_url}
    ...    platformName=Android
    ...    deviceName=Android Emulator
    ...    appPackage=${app_package}
    ...    appActivity=${app_activity}
    ...    automationName=UiAutomator2
    ...    app=${app_path}
    ...    noReset=False
    ...    fullReset=False
    Set Appium Timeout    ${timeout}

Create Todo
    [Arguments]    ${title}    ${description}=
    [Documentation]    Creates a new todo with title and optional description
    Click    ${BUTTON_ADD}
    Wait Visible    ${FIELD_TITLE}
    Type    ${FIELD_TITLE}    ${title}
    IF    '${description}' != ''
        Type    ${FIELD_DESCRIPTION}    ${description}
    END
    Click    ${BUTTON_SAVE}
    Wait Visible    ${VIEW_LIST}

Click
    [Arguments]    ${locator}
    [Documentation]    Waits for element and clicks it
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}

Type
    [Arguments]    ${locator}    ${text}
    [Documentation]    Clears field and types text
    Wait Until Element Is Visible    ${locator}
    Clear Text    ${locator}
    Input Text    ${locator}    ${text}

Clear
    [Arguments]    ${locator}
    [Documentation]    Clears text field
    Wait Until Element Is Visible    ${locator}
    Clear Text    ${locator}

Wait Visible
    [Arguments]    ${locator}
    [Documentation]    Waits for element to be visible
    Wait Until Element Is Visible    ${locator}    timeout=10s

Verify Todo Exists
    [Arguments]    ${todo_text}
    [Documentation]    Verifies todo exists in list
    ${locator}=    Set Variable    xpath=//android.widget.TextView[@text='${todo_text}']
    Wait Visible    ${locator}
    Element Should Be Visible    ${locator}

Verify Todo Not Exists
    [Arguments]    ${todo_text}
    [Documentation]    Verifies todo does not exist in list
    ${locator}=    Set Variable    xpath=//android.widget.TextView[@text='${todo_text}']
    Wait Until Page Does Not Contain Element    ${locator}    timeout=5s

Click Todo
    [Arguments]    ${todo_text}
    [Documentation]    Clicks on todo to open edit screen
    ${locator}=    Set Variable    xpath=//android.widget.TextView[@text='${todo_text}']
    Click    ${locator}
    Wait Visible    ${FIELD_TITLE}

Swipe Delete
    [Arguments]    ${todo_text}
    [Documentation]    Deletes todo by swiping left
    ${locator}=    Set Variable    xpath=//android.widget.TextView[@text='${todo_text}']
    Wait Visible    ${locator}
    ${location}=    Get Element Location    ${locator}
    ${size}=    Get Element Size    ${locator}
    ${start_x}=    Evaluate    int(${location}[x] + ${size}[width] * 0.8)
    ${start_y}=    Evaluate    int(${location}[y] + ${size}[height] * 0.5)
    ${end_x}=    Evaluate    int(${location}[x] + ${size}[width] * 0.2)
    Swipe By Coordinates    ${start_x}    ${start_y}    ${end_x}    ${start_y}    500
    Wait Until Page Does Not Contain Element    ${locator}    timeout=5s

Click Day
    [Arguments]    ${day}
    [Documentation]    Clicks day in date picker
    Wait Until Page Contains Element    xpath=//android.widget.DatePicker    timeout=5s
    ${locator}=    Set Variable    xpath=//android.widget.TextView[@text='${day}']
    Wait Visible    ${locator}
    Click    ${locator}

Select Time
    [Arguments]    ${hour}    ${minute}
    [Documentation]    Selects hour and minute in time picker
    Wait Until Page Contains Element    xpath=//android.widget.TimePicker    timeout=5s
    ${hour_loc}=    Set Variable    xpath=//android.widget.RadialTimePickerView//android.widget.TextView[@text='${hour}']
    ${min_loc}=    Set Variable    xpath=//android.widget.RadialTimePickerView//android.widget.TextView[@text='${minute}']
    Wait Visible    ${hour_loc}
    Click    ${hour_loc}
    Wait Visible    ${min_loc}
    Click    ${min_loc}
    Click    ${BUTTON_OK}

Get All Todos
    [Documentation]    Returns list of all todo titles
    ${todos}=    Get Webelements    id=com.example.avjindersinghsekhon.minimaltodo:id/toDoListItemTextview
    ${list}=    Create List
    FOR    ${todo}    IN    @{todos}
        ${text}=    Get Text    ${todo}
        Append To List    ${list}    ${text}
    END
    [Return]    ${list}

Verify Empty List
    [Documentation]    Verifies todo list is empty
    Wait Visible    ${VIEW_EMPTY}
    Element Should Be Visible    ${VIEW_EMPTY}
