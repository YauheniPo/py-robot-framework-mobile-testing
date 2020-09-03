*** Settings ***
Resource                        ..${/}base_page.robot
Resource                        navigation_menu.robot


*** Variables ***
${HEADER_ID}                    android:id/up


*** Keywords ***
Header.Click And Open Navigation
    Click                               ${HEADER_ID}
    wait until element is visible       ${NAV_MENU_XPATH}       10
