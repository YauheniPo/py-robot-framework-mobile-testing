*** Settings ***
Documentation

Library                 OperatingSystem
Library                 library${/}utils${/}cmd_helper.py


*** Keywords ***
adb command
    [Documentation]
    [Arguments]                     ${command}

    ${android_home_path} =          Get Environment Variable        ANDROID_HOME
    ${adb_exe_path} =               set variable                    ${android_home_path}${/}platform-tools${/}adb.exe
    ${cmd_output} =                 Run Command                     ${adb_exe_path} ${command}
    Log                             ${cmd_output}
    sleep                           1

Install App apk
    [Documentation]

    adb command                     install ${EXECDIR}${/}apk${/}${apkName}

Uninstall App
    [Documentation]

    adb command                     uninstall ${appPackage}
