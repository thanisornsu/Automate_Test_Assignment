*** Settings ***
Documentation    Test automation suite for Minimal-Todo Android app - CRUD operations
Library    AppiumLibrary
Resource    ../resources/todo_keywords.robot

*** Variables ***
${SERVER_URL}          http://localhost:4723
${APP_PACKAGE}         com.example.avjindersinghsekhon.minimaltodo
${APP_ACTIVITY}        .Main.MainActivity
${APP_PATH}            ${CURDIR}${/}..${/}..${/}..${/}app${/}minimal-todo.apk
${TIMEOUT}             30s

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

Suite Setup    Open App    ${SERVER_URL}    ${APP_PACKAGE}    ${APP_ACTIVITY}    ${APP_PATH}    ${TIMEOUT}
Suite Teardown    Close Application
Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot    failed_${TEST_NAME}

*** Test Cases ***
TC001: Create Todo - Basic
    [Documentation]    Verify creating a basic todo with title and description
    [Tags]    critical    smoke    create
    Click    ${BUTTON_ADD}
    Type    ${FIELD_TITLE}    Test Todo
    Type    ${FIELD_DESCRIPTION}    Test Description
    Click    ${BUTTON_SAVE}
    Verify Todo Exists    Test Todo

TC002: Create Todo - With Reminder
    [Documentation]    Verify creating a todo with reminder date and time
    [Tags]    critical    reminder
    Click    ${BUTTON_ADD}
    Type    ${FIELD_TITLE}    Water the plants
    Type    ${FIELD_DESCRIPTION}    Water all plants
    Click    ${SWITCH_REMINDER}
    Click    ${FIELD_DATE}
    Click Day    15
    Click    ${BUTTON_OK}
    Click    ${FIELD_TIME}
    Select Time    10    30
    Click    ${BUTTON_SAVE}
    Verify Todo Exists    Water the plants

TC003: View Multiple Todos
    [Documentation]    Verify viewing multiple todos in the list
    [Tags]    critical    read    view
    Create Todo    Get car washed    Take car to car wash
    Create Todo    Buy groceries    Milk, bread, eggs
    Verify Todo Exists    Get car washed
    Verify Todo Exists    Buy groceries

TC004: Edit Todo
    [Documentation]    Verify editing an existing todo
    [Tags]    critical    update    edit
    Create Todo    Original Title    Original Description
    Click Todo    Original Title
    Clear    ${FIELD_TITLE}
    Clear    ${FIELD_DESCRIPTION}
    Type    ${FIELD_TITLE}    Updated Title
    Type    ${FIELD_DESCRIPTION}    Updated Description
    Click    ${BUTTON_SAVE}
    Verify Todo Exists    Updated Title
    Verify Todo Not Exists    Original Title

TC005: Delete Todo - Swipe
    [Documentation]    Verify deleting a todo by swiping left
    [Tags]    critical    delete    swipe
    Create Todo    Delete Me    This will be deleted
    Verify Todo Exists    Delete Me
    Swipe Delete    Delete Me
    Verify Todo Not Exists    Delete Me

TC006: Delete Multiple Todos
    [Documentation]    Verify deleting multiple todos
    [Tags]    critical    delete    multiple
    Create Todo    Todo 1    Description 1
    Create Todo    Todo 2    Description 2
    Create Todo    Todo 3    Description 3
    Swipe Delete    Todo 1
    Swipe Delete    Todo 2
    Swipe Delete    Todo 3
    Verify Empty List

TC007: Empty State Verification
    [Documentation]    Verify empty state when no todos exist
    [Tags]    critical    empty    state
    ${todos}=    Get All Todos
    FOR    ${todo}    IN    @{todos}
        Swipe Delete    ${todo}
    END
    Verify Empty List

