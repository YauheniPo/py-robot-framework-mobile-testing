*** Settings ***
Resource                .${/}common${/}header.robot
Resource                .${/}common${/}native_popup${/}sign_microsoft_account.robot
Library                 AppiumLibrary                       run_on_failure=Log Source
Library                 String
Variables               navigation_constants.py


*** Keywords ***
Click
    [Arguments]                                         ${locator}      ${timeout}=10
    AppiumLibrary.Wait Until Page Contains Element      ${locator}      ${timeout}
    AppiumLibrary.Click Element                         ${locator}

Set Text
    [Arguments]                                         ${locator}      ${text}
    Click                                               ${locator}
    AppiumLibrary.input text                            ${locator}      ${text}

Get Text
    [Arguments]                                         ${locator}      ${timeout}=10
    AppiumLibrary.Wait Until Page Contains Element      ${locator}      ${timeout}
    ${text} =           AppiumLibrary.Get Text          ${locator}
    [Return]            ${text}
