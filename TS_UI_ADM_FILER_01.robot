*** Settings ***
Documentation     These tests are related to filers management section of the Application.
...               It covers Filer list and filer volumes list.
Library           Selenium2Library     5     10
Library           CustomSeleniumLibrary
Library           Generic_UI
Library           robot.libraries.String
Variables         Variables_UI.yaml
Variables         Credentials_UI.yaml
Variables         ObjectRepository.yaml
Resource          Resource_UI.robot

*** Test Cases ***
TC_UI_FILER_01_01
    [Documentation]    Test for checking filers list.
    [Tags]    UI    FILER
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    ...    AND    Login To Application By Admin
    On Left Pane Navigate To    ${left_pane_links_admin.Filers_List}
    Verify Text On Page    ${Generic.Filer_Name}
    [Teardown]    Run Keywords    Logout From Application
    ...    AND    Close Browser
    
TC_UI_FILER_01_02
    [Documentation]    Test for checking filers details without selecting filer list.
    [Tags]    UI    FILER
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    ...    AND    Login To Application By Admin
    On Left Pane Navigate To    ${left_pane_links_admin.Filer_Vol_List}
    Click Button    submit
    Wait Until Page Contains    Please Select Filer!    timeout=5
    [Teardown]    Run Keywords    Logout From Application
    ...    AND    Close Browser
    
TC_UI_FILER_01_03
    [Documentation]    Test for checking filers volume details list.
    [Tags]    UI    FILER
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    ...    AND    Login To Application By Admin
    On Left Pane Navigate To    ${left_pane_links_admin.Filer_Vol_List}
    Select from Drop Down    ${xpaths.filer_dd}      ${Generic.Filer_Name}
    Click Button    submit
    Verify Text On Element    ${xpaths.filer}    ${Generic.Filer_Name}
    Verify Text On Element    ${xpaths.filer}    ${filers_mgmt.filer_vol_list_text1}
    Verify Text On Element    ${xpaths.filer}    ${filers_mgmt.filer_vol_list_text2}
    [Teardown]    Run Keywords    Logout From Application
    ...    AND    Close Browser
    
TC_UI_FILER_01_04
    [Documentation]    Test for checking filers volume details search functionality.
    [Tags]    UI    FILER
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    ...    AND    Login To Application By Admin
    On Left Pane Navigate To    ${left_pane_links_admin.Filer_Vol_List}
    Select from Drop Down    ${xpaths.filer_dd}      ${Generic.Filer_Name}
    Click Button    submit
    Enter Text In Search Box    ${xpaths.searchbox}    ${Generic.Org_Name}
    Verify Text On Page    ${Generic.Org_Name}
    Element Should Not Be Visible    ${xpaths.filer}
    [Teardown]    Run Keywords    Logout From Application
    ...    AND    Close Browser