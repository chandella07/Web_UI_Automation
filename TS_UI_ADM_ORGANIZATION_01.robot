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
TC_UI_ORG_01_01
    [Documentation]    Test for checking organization list.
    [Tags]    UI    ORGANIZATION
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    ...    AND    Login To Application By Admin
    On Left Pane Navigate To    ${left_pane_links_admin.Org_List}
    Verify Text On Page    ${Generic.Org_Name}
    [Teardown]    Run Keywords    Logout From Application
    ...    AND    Close Browser

TC_UI_ORG_01_02
    [Documentation]    Test for checking assign volume to organization.
    [Tags]    UI    ORGANIZATION
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    ...    AND    Login To Application By Admin
    ...    AND    Create Volume    ${org_mgmt.Org_Vol_Name}    ${Generic.Filer_Name}    ${volume_mgmt.Aggr_Name}
    On Left Pane Navigate To    ${left_pane_links_admin.Manage_Org_Vol}
    Select from Drop Down    ${xpaths.org_dd}      ${Generic.Org_Name}
    Select from Drop Down    ${xpaths.filer2_dd}      ${Generic.Filer_Name}
    Verify Text On Page    ${org_mgmt.Org_Vol_Name}
    ${loc}=    Substitute Name    ${xpaths.list_text}    ${org_mgmt.Org_Vol_Name}
    Click Element    ${loc}
	sleep    1s
    Click Button    modify Organization volumes
    sleep    1s
    ${msg}=    Confirm Action
    sleep    1s
    Should Be Equal    ${msg}    ${org_mgmt.Assign_Success}
    click link    home
    sleep    1s
    [Teardown]    Run Keywords    Delete Volume    ${org_mgmt.Org_Vol_Name}    ${Generic.Filer_Name}
    ...    AND    Logout From Application
    ...    AND    Close Browser
    
#TC_UI_ORG_01_03
#    [Documentation]    Test for checking remove volume from organization.
#    [Tags]    UI    ORGANIZATION    t3
#    [Setup]    Run Keywords    Open Browser To Login Page
#    ...    AND    Login To Application
#    On Left Pane Navigate To    ${left_pane_links_admin.Manage_Org_Vol}
#    Select from Drop Down    ${xpaths.org_dd}      ${Generic.Org_Name}
#    Select from Drop Down    ${xpaths.filer2_dd}      ${Generic.Filer_Name}
#    Verify Text On Page    ${org_mgmt.Org_Vol_Name}
#    ${loc}=    Substitute Name    ${xpaths.list_text}    ${org_mgmt.Org_Vol_Name}
#    Click Element    xpath=${loc}
#    Click Element    xpath=${loc} 
#    Click Button    modify Organization volumes
#    ${msg}=    Confirm Action
#    Should Be Equal    ${msg}    ${org_mgmt.Assign_Remove}
#    #Verify Text On Page    ${org_mgmt.Assign_Remove}    
#    [Teardown]    Run Keywords    Logout From Application
#    ...    AND    Close Browser