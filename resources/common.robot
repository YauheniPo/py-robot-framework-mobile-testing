*** Settings ***
#robot --pythonpath . -d ./results tests/bing_finance_test.robot
Documentation           Suite description

Library                 OperatingSystem
Library                 library${/}utils${/}cmd_helper.py
Library                 DebugLibrary        #breakpoint keyword - Debug
Library                 library.utils.soft_assert.SoftAssert            WITH NAME       SOFT

Resource                ..${/}library${/}pages${/}main_page.robot
Resource                ..${/}library${/}pages${/}watchlist_page.robot

Variables               ..${/}configs${/}test-data.yaml
Variables               ..${/}configs${/}android-${testDevice}.yaml
Variables               ..${/}configs${/}appium-conf.yaml
Variables               ..${/}configs${/}app-config.yaml


*** Variable ***


*** Keywords ***
Open APP
    [Documentation]

    Open Application            remote_url=${appiumHub}
    ...                         udid=${udidDevice}            platformName=${androidPlatform}
    ...                         deviceName=${device}        platformVersion=${androidVersion}
    ...                         appPackage=${appPackage}
    ...                         appActivity=${appActivity}
    ...                         noReset=True

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
