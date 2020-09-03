*** Settings ***
#robot --pythonpath . -d ./results tests/bing_finance_test.robot
Documentation           Suite description
Library                 OperatingSystem
Library                 library${/}utils${/}common.py
Library                 DebugLibrary        #breakpoint keyword - Debug
Resource                ..${/}library${/}pages${/}main_page.robot
Resource                ..${/}library${/}pages${/}watchlist_page.robot
Library                 library.utils.soft_assert.SoftAssert            WITH NAME   SOFT


*** Variable ***
${APPIUM_IP}                    127.0.0.1
${APPIUM_PORT}                  4723
${APPIUM_HUB}                   http://${APPIUM_IP}:${APPIUM_PORT}/wd/hub
${APPIUM_CMD}                   appium --address ${APPIUM_IP} --command-timeout "7200" --debug-log-spacing --launch-timeout "90000"
${UDID_DEVICE_5554}             emulator-5554
${ANDROID_PLATFORM}             Android
${DEVICE_PIXEL_3}               Pixel_3_API_26
${ANDROID_VERSION_8_0_0}        8.0.0
${BING_FINANCE_APP_PACKAGE}     com.microsoft.amp.apps.bingfinance
${BING_FINANCE_APP_ACTIVITY}    com.microsoft.amp.apps.bingfinance.activities.views.MainActivity
${APK_PATH}                     apk${/}bingfinance.apk


*** Keywords ***
Setup Test
    Open Application            remote_url=${APPIUM_HUB}
    ...                         udid=${UDID_DEVICE_5554}            platformName=${ANDROID_PLATFORM}
    ...                         deviceName=${DEVICE_PIXEL_3}        platformVersion=${ANDROID_VERSION_8_0_0}
    ...                         appPackage=${BING_FINANCE_APP_PACKAGE}
    ...                         appActivity=${BING_FINANCE_APP_ACTIVITY}
    ...                         noReset=True

Teardown Test
    Run Keyword If Test Failed                  Capture Page Screenshot
    Close Application

Install BingFinance App
    [Documentation]

    adb command                     install ${EXECDIR}${/}${APK_PATH}

Uninstall App
    [Documentation]

    adb command                     uninstall ${BING_FINANCE_APP_PACKAGE}

BingFinance Suite Setup
    adb command                     kill-server
    sleep                           1
    adb command                     start-server
    sleep                           1
#    Start Appium Server             ${APPIUM_CMD}
    Install BingFinance App

adb command
    [Arguments]                     ${command}
    ${android_home_path} =          Get Environment Variable        ANDROID_HOME
    ${adb_exe_path} =               set variable                    ${android_home_path}${/}platform-tools${/}adb.exe
    ${cmd_output} =                 Run Command                     ${adb_exe_path} ${command}
    Log                             ${cmd_output}
    sleep                           1
