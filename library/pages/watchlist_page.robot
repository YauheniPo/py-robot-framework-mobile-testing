*** Settings ***
Resource                    base_page.robot


*** Variables ***
${ADD_FAVORITE_ID}          com.microsoft.amp.apps.bingfinance:id/add_favorite_glyph
${SEARCH_INPUT_FIELD_ID}    com.microsoft.amp.apps.bingfinance:id/autosuggest_form_sheet_autosuggest_view
${SEARCH_RESULT_XPATH}      //*[contains(@resource-id, 'autosuggest_form_sheet_results')]//*[./*[@text='{}']][./*[@text='{}']]
${SYMBOL_TITLE}             com.microsoft.amp.apps.bingfinance:id/watchlist_item_title


*** Keywords ***
Watchlist.Click Add Favorite
    Click                   ${ADD_FAVORITE_ID}

Watchlist.Set Symbol
    [Arguments]             ${text}
    Set Text                ${SEARCH_INPUT_FIELD_ID}            ${text}

Watchlist.Select Searched Symbol
    [Arguments]             ${symbol}                           ${exchange}
    ${result_xpath} =       format string                       ${SEARCH_RESULT_XPATH}      ${symbol}       ${exchange}
    Click                   ${result_xpath}

Watchlist.Add Favorite
    [Arguments]                         ${symbol}               ${exchange}
    Watchlist.Click Add Favorite
    Watchlist.Set Symbol                ${symbol}
    Watchlist.Select Searched Symbol    ${symbol}               ${exchange}

Watchlist.Get Symbol Model
    ${symbol} =             Get Text    ${SYMBOL_TITLE}
    [Return]                ${symbol}