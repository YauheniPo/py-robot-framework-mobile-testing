*** Settings ***
Resource                    ..${/}..${/}base_page.robot


*** Variables ***
${NO_THANKS}                No Thanks
${SIGN IN}                  Sign In
${BUTTON_XPATH}             //android.widget.Button[@text='{}']


*** Keywords ***
Sign_Microsoft.Reject if Exist
    ${no_thanks_button_xpath} =         format string       ${BUTTON_XPATH}     ${NO_THANKS}
    Run Keyword And Ignore Error        Click               ${no_thanks_button_xpath}       2
