*** Variable ***
${ENV}                  %{env}


*** Settings ***
Resource                ..${/}resources${/}common.robot
Resource                .${/}adb_wrapper.robot
Variables               ..${/}configs${/}app-config.yaml
Variables               ..${/}configs${/}${ENV}-conf.yaml

Suite Setup             Open APP
Suite Teardown          Close Application


*** Keywords ***
Open APP
    [Documentation]

    ${remote_url} =             Get Remote URL
    ${caps} =                   Get Driver Capabilities
    Open Application            ${remote_url}
    ...                         &{caps}

Get Driver Capabilities
    [Documentation]

    ${caps_json_path} =         set variable                    ${EXECDIR}${/}configs${/}android-${ENV}-caps.json
    ${caps_file} =              Get file                        ${caps_json_path}
    ${caps_dict} =              evaluate                        json.loads('''${caps_file}''')
    ${app_apk_path} =           set variable                    ${EXECDIR}${/}apk${/}${caps_dict['app']}
    set to dictionary           ${caps_dict}                    app=${app_apk_path}
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
