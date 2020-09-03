*** Settings ***
Resource                    ..${/}base_page.robot


*** Variables ***
${NAV_MENU_XPATH}           //android.widget.ListView[@resource-id='com.microsoft.amp.apps.bingfinance:id/navigation_drawer_list']


*** Keywords ***
Nav_Menu.Select Nav Item
    [Arguments]             ${item_name}
    ${item_locator} =       set variable               ${NAV_MENU_XPATH}//*[@text='${item_name}']
    Click                   ${item_locator}
