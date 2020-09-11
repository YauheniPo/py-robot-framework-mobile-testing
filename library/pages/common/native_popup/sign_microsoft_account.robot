*** Settings ***
Resource                    ..${/}..${/}base_page.robot


*** Variables ***
${NO_THANKS}                No Thanks
${SIGN_IN}                  Sign In
${CANCEL}                   Cancel
${BUTTON_FORMAT_XPATH}      //android.widget.Button[@text='{}']


*** Keywords ***
Native_Popup.Click Button
    [Documentation]
    [Arguments]                         ${button_text}

    ${button_xpath} =                   format string       ${BUTTON_FORMAT_XPATH}          ${button_text}
    Run Keyword And Ignore Error        Click               ${button_xpath}                 2

Native_Popup.Sign_Microsoft.Reject if Exist
    Native_Popup.Click Button           ${NO_THANKS}

Native_Popup.Location_Editor.Reject if Exist
    Native_Popup.Click Button           ${CANCEL}