*** Settings ***
Resource                ..${/}resources${/}common.robot
Test Setup              Setup Test
Suite Setup             BingFinance Suite Setup
Test Teardown           Teardown Test
Suite Teardown          Uninstall App


*** Variables ***
${EPAM_SYMBOL}          EPAM
${EXCHANGE_NYSE}        NYSE


*** Test Cases ***
Open Application On Android
    Given Header.Click And Open Navigation
    When Nav_Menu.Select Nav Item                   ${WATCHLIST}
    And Watchlist.Add Favorite                      ${EPAM_SYMBOL}          ${EXCHANGE_NYSE}
    And Sign_Microsoft.Reject if Exist
    ${symbol} =                                     Then Watchlist.Get Symbol Model
    And SOFT.should be equal as strings             ${symbol}               ${EPAM_SYMBOL}
    ...                                             Symbol title is incorrect
