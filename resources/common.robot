#robot --pythonpath . -v env:saucelabs -v saucelabsUser: -v saucelabsToken: -d ./results tests/*_test.robot

*** Variable ***
${ENV}                  %{env}


*** Settings ***
Documentation           Suite description

Library                 OperatingSystem
Library                 library${/}utils${/}cmd_helper.py
Library                 DebugLibrary        #breakpoint keyword - Debug
Library                 library.utils.soft_assert.SoftAssert            WITH NAME       SOFT
Library                 library.utils.common.Common                     WITH NAME       COMMON
Library                 Collections

Resource                ..${/}library${/}pages${/}main_page.robot
Resource                ..${/}library${/}pages${/}watchlist_page.robot

Variables               ..${/}configs${/}test-data.yaml
Variables               ..${/}configs${/}app-config.yaml
Variables               ..${/}configs${/}${ENV}-conf.yaml


*** Keywords ***
Get BuiltIn Parameter
    [Documentation]
    [Arguments]                 ${key}

    ${value} =                  COMMON.get builtin param        ${key}
    [Return]                    ${value}

Get Driver Capabilities
    [Documentation]

    ${caps_json_path} =         set variable                    ${EXECDIR}${/}configs${/}android-${ENV}-caps.json
    ${caps_file} =              Get file                        ${caps_json_path}
    ${caps_dict} =              evaluate                        json.loads('''${caps_file}''')
    [Return]                    ${caps_dict}

Get Remote URL
    [Documentation]

    ${saucelabs_user_var} =     Get_builtin_Parameter           saucelabsUser
    ${saucelabs_token_var} =    Get_builtin_Parameter           saucelabsToken
    ${remote_url} =             format string                   ${hub}
    ...                         user=${saucelabs_user_var}
    ...                         token=${saucelabs_token_var}
    ...                         ip=${ip}
    ...                         port=${port}
    [Return]                    ${remote_url}

Open APP
    [Documentation]

    ${remote_url} =             Get Remote URL
    ${caps} =                   Get Driver Capabilities
    Open Application            ${remote_url}
    ...                         &{caps}

Teardown Test
    [Documentation]

    Run Keyword If Test Failed                  Capture Page Screenshot
    Close Application

Install App apk
    [Documentation]

    adb command                     install ${EXECDIR}${/}apk${/}${apkName}

Uninstall App
    [Documentation]

    adb command                     uninstall ${appPackage}

Setup Suite
    [Documentation]

    adb command                     kill-server
    sleep                           1
    adb command                     start-server
    sleep                           1
#    Start Appium Server             ${appiumCmd}
    Install App apk

adb command
    [Documentation]
    [Arguments]                     ${command}

    ${android_home_path} =          Get Environment Variable        ANDROID_HOME
    ${adb_exe_path} =               set variable                    ${android_home_path}${/}platform-tools${/}adb.exe
    ${cmd_output} =                 Run Command                     ${adb_exe_path} ${command}
    Log                             ${cmd_output}
    sleep                           1
