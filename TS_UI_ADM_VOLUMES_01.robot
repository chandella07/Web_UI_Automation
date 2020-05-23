*** Settings ***
Documentation     These tests are related to volume management section of the Application.
...               It covers manage volume, create volumes and delete volume.
Library           Selenium2Library     5     10
Library           CustomSeleniumLibrary
Library           Generic_UI
Library           robot.libraries.String
Variables         Variables_UI.yaml
Variables         Credentials_UI.yaml
Variables         ObjectRepository.yaml
Resource          Resource_UI.robot

*** Test Cases ***
TC_UI_VOLUME_01_01
    [Documentation]    Test for checking create volume functionality.
    [Tags]    UI    VOLUME
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    ...    AND    Login To Application By Admin
    On Left Pane Navigate To    ${left_pane_links_admin.Create_New_Vol}
    Select from Drop Down    ${xpaths.filer_dd}      ${Generic.Filer_Name}
    Input Text    ${xpaths.vol_name}    ${volume_mgmt.Vol_Name}
    Input Text    ${xpaths.aggr_name}    ${volume_mgmt.Aggr_Name}
    Input Text    ${xpaths.size}    ${volume_mgmt.Vol_Size}
    Select from Drop Down    ${xpaths.unit_dd}      ${volume_mgmt.Vol_Unit}
	sleep    2s
    Click Button    create
    Verify Text On Page    Successfully created volume "${volume_mgmt.Vol_Name}" on filer "${Generic.Filer_Name}".
    [Teardown]    Run Keywords    Delete Volume    ${volume_mgmt.Vol_Name}    ${Generic.Filer_Name}
    ...    AND    Logout From Application
    ...    AND    Close Browser

TC_UI_VOLUME_01_02
    [Documentation]    Test for checking volume details on manage volume section.
    [Tags]    UI    VOLUME
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    ...    AND    Login To Application By Admin
    On Left Pane Navigate To    ${left_pane_links_admin.Manage_Vol}
    Select from Drop Down    ${xpaths.filer2_dd}      ${Generic.Filer_Name}
    Click Button    submit
    #Verify Text On Element    ${xpaths.filer}    ${Generic.Filer_Name}
    Verify Text On Element    ${xpaths.filer}    ${filers_mgmt.filer_vol_list_text1}
    Verify Text On Element    ${xpaths.filer}    ${filers_mgmt.filer_vol_list_text2}
    [Teardown]    Run Keywords    Logout From Application
    ...    AND    Close Browser
    
TC_UI_VOLUME_01_03
    [Documentation]    Test for checking manage volume details search functionality.
    [Tags]    UI    VOLUME
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    ...    AND    Login To Application By Admin
    On Left Pane Navigate To    ${left_pane_links_admin.Manage_Vol}
    Select from Drop Down    ${xpaths.filer2_dd}      ${Generic.Filer_Name}
    Click Button    submit
    Enter Text In Search Box    ${xpaths.searchbox}    ${Generic.Org_Name}
    Verify Text On Page    ${Generic.Org_Name}
    Element Should Not Be Visible    ${xpaths.filer}
    [Teardown]    Run Keywords    Logout From Application
    ...    AND    Close Browser
    
TC_UI_VOLUME_01_04
    [Documentation]    Test for checking delete volume functionality.
    [Tags]    UI    VOLUME
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    ...    AND    Login To Application By Admin
    ...    AND    Create Volume    ${volume_mgmt.Vol_Name}    ${Generic.Filer_Name}    ${volume_mgmt.Aggr_Name}
    On Left Pane Navigate To    ${left_pane_links_admin.Manage_Vol}
    Select from Drop Down    ${xpaths.filer2_dd}      ${Generic.Filer_Name}
    Click Button    submit
    ${loc}=    Substitute Name    ${xpaths.rows}    ${volume_mgmt.Vol_Name}
    sleep    5s
    Click Element    ${loc}
    Click button    deletevolume
    ${msg}=    Confirm Action
    #Should Be Equal    ${msg}    Do you want to delete selected  volume (s)?
    #Verify Text On Page    Volume '${volume_mgmt.Vol_Name}' deleted successfully.
    Wait Until Page Contains    Volume '${volume_mgmt.Vol_Name}' deleted successfully.    timeout=20
    [Teardown]    Run Keywords    Logout From Application
    ...    AND    Close Browser
    
TC_UI_VOLUME_01_05
    [Documentation]    Test for checking create volume with size less than 20 MB.
    [Tags]    UI    VOLUME
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    ...    AND    Login To Application By Admin
    On Left Pane Navigate To    ${left_pane_links_admin.Create_New_Vol}
    Select from Drop Down    ${xpaths.filer_dd}      ${Generic.Filer_Name}
    Input Text    ${xpaths.vol_name}    ${volume_mgmt.Small_Size_Vol_Name}
    Input Text    ${xpaths.aggr_name}    ${volume_mgmt.Aggr_Name}
    Input Text    ${xpaths.size}    10
    Select from Drop Down    ${xpaths.unit_dd}      ${volume_mgmt.Vol_Unit}
	sleep    2s
    Click Button    create
    Verify Text On Page    Volume size is too small. Minimum is 20m.
    [Teardown]    Run Keywords    Logout From Application
    ...    AND    Close Browser
    
    