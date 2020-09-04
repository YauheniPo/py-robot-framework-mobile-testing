*** Settings ***
Resource                ..${/}resources${/}common.robot

Test Setup              Open APP
Suite Setup             Setup Suite
Test Teardown           Teardown Test
Suite Teardown          Uninstall App


*** Variables ***
${EPAM_SYMBOL}          ${symbol}
${EXCHANGE_NYSE}        ${exchange}


*** Test Cases ***
Validate ${EPAM_SYMBOL} symbol title in Watchlist
    [Documentation]

    Given Header.Click And Open Navigation
    When Nav_Menu.Select Nav Item                   ${WATCHLIST}
    And Watchlist.Add Favorite                      ${EPAM_SYMBOL}          ${EXCHANGE_NYSE}
    And Sign_Microsoft.Reject if Exist
    ${symbol} =                                     Then Watchlist.Get Symbol Model
    And SOFT.should be equal as strings             ${symbol}               ${EPAM_SYMBOL}
    ...                                             Symbol title is incorrect
