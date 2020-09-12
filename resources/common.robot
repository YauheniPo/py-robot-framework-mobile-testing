#robot --pythonpath . -v env:saucelabs -v saucelabsUser: -v saucelabsToken: -d ./results tests

*** Settings ***
Documentation           Suite description

Library                 DebugLibrary        #breakpoint keyword - Debug
Library                 library.utils.soft_assert.SoftAssert            WITH NAME       SOFT
Library                 library.utils.common.Common                     WITH NAME       COMMON
Library                 Collections

Resource                ..${/}library${/}pages${/}main_page.robot
Resource                ..${/}library${/}pages${/}watchlist_page.robot

Variables               ..${/}configs${/}test-data.yaml


*** Keywords ***
Get BuiltIn Parameter
    [Documentation]
    [Arguments]                 ${key}

    ${value} =                  COMMON.get builtin param        ${key}
    [Return]                    ${value}

Reset APP
    [Documentation]

    Reset Application

Fail Screen & Reset APP
    [Documentation]

    Run Keyword If Test Failed                  Capture Page Screenshot
    Reset APP
