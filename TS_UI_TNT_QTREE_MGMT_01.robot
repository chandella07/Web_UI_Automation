*** Settings ***
Documentation     These tests are related to login functionality of the Application.
...               It covers valid login fuctionality.
Library           Selenium2Library     5     10
Library           CustomSeleniumLibrary
Library           Generic_UI
Library           robot.libraries.String
Variables         Variables_UI.yaml
Variables         Credentials_UI.yaml
Variables         ObjectRepository.yaml
Resource          Resource_UI.robot
Suite Setup       Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
...    AND        Login To Application By Admin
...    AND        Create Volume    ${qtree_mgmt.Vol_Name}    ${Generic.Filer_Name}    ${volume_mgmt.Aggr_Name}
...    AND        Assign Volume To Org    ${qtree_mgmt.Vol_Name}
...    AND        Logout From Application
...    AND        Close Browser
Suite Teardown    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
...    AND        Login To Application By Admin
...    AND        Delete Volume    ${qtree_mgmt.Vol_Name}    ${Generic.Filer_Name}
...    AND        Logout From Application
...    AND        Close Browser

*** Test Cases ***
TC_UI_TNT_QTREE_MGMT_01_01
    [Documentation]    Test for checking orgVDC list.
    [Tags]    UI    QTREE
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Tenant}
    ...    AND    Login To Application By Tenant
    On Left Pane Navigate To    ${left_pane_links_tenant.VDC_List}
    Wait Until Page Contains    ${Generic.orgVDC_Name}    timeout=30
    [Teardown]    Run Keywords     Logout From Application
    ...    AND    Close Browser

TC_UI_TNT_QTREE_MGMT_01_02
    [Documentation]    Test for checking vApp list.
    [Tags]    UI    QTREE
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Tenant}
    ...    AND    Login To Application By Tenant
    On Left Pane Navigate To    ${left_pane_links_tenant.Vapp_List}
    Wait Until Page Contains    ${Generic.vApp_Name}    timeout=30
    [Teardown]    Run Keywords     Logout From Application
    ...    AND    Close Browser    
    
TC_UI_TNT_QTREE_MGMT_01_03
    [Documentation]    Test for checking delegate admin role assigning qtree.
    [Tags]    UI    DELEGATE
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Tenant}
    ...    AND    Login To Application By Tenant
    ...    AND    Create Qtree    ${qtree_mgmt.Vol_Name}    ${exp_mgmt.delegate_Qtree}
    On Left Pane Navigate To    ${left_pane_links_tenant.Delegate_ADM_Role}
    sleep    1s
    Select from Drop Down    ${xpaths.vdc_select}      ${Generic.orgVDC_Name}
    ${loc1}=    Substitute Name    ${xpaths.vapp_select}      ${Generic.vApp_Name}
    Wait Until Page Contains Element    ${loc1}    timeout=20    
    Select from Drop Down    ${xpaths.vapp_select}      ${Generic.vApp_Name}
    sleep    1s
    Select from Drop Down    ${xpaths.vol_dd1}      ${qtree_mgmt.Vol_Name}
    Verify Text On Page    ${exp_mgmt.delegate_Qtree}
    ${loc}=    Substitute Name    ${xpaths.list_text}    ${exp_mgmt.delegate_Qtree}
    Click Element    ${loc}
	sleep    1s
    Click Button    modify org qtrees
    sleep    1s
    ${msg}=    Confirm Action
    sleep    1s
    Should Be Equal    ${msg}    ${org_mgmt.Assign_Success2}
    click link    home
    sleep    1s
    [Teardown]    Run Keywords    Delete Qtree    ${qtree_mgmt.Vol_Name}    ${exp_mgmt.delegate_Qtree}
    ...    AND    sleep    1s     
    ...    AND    Logout From Application
    ...    AND    Close Browser


TC_UI_TNT_QTREE_MGMT_01_04
    [Documentation]    Test for checking create qtree functionality.
    [Tags]    UI    QTREE
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Tenant}
    ...    AND    Login To Application By Tenant
    On Left Pane Navigate To    ${left_pane_links_tenant.Create_Qtree}
    Select from Drop Down    ${xpaths.vol_dd}      ${qtree_mgmt.Vol_Name}
    Input Text    ${xpaths.qtree_textbox}    ${qtree_mgmt.Qtree_Name}
    Click Button    create
    sleep    5s
    Verify Text On Element    ${xpaths.qtree_success}    Qtree "${qtree_mgmt.Qtree_Name}" created successfully.
    [Teardown]    Run Keywords     Delete Qtree    ${qtree_mgmt.Vol_Name}    ${qtree_mgmt.Qtree_Name}
    ...    AND    sleep    1s 
    ...    AND    Logout From Application
    ...    AND    Close Browser

TC_UI_TNT_QTREE_MGMT_01_05
    [Documentation]    Test for checking list qtree functionality.
    [Tags]    UI    QTREE
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Tenant}
    ...    AND    Login To Application By Tenant
    ...    AND    Create Qtree    ${qtree_mgmt.Vol_Name}    ${qtree_mgmt.Qtree_Name}
    On Left Pane Navigate To    ${left_pane_links_tenant.List_Qtree}
    sleep   1s
    Select from Drop Down    ${xpaths.vol_dd}      ${qtree_mgmt.Vol_Name}
    Click Button    submit
    Verify Text On Page    ${qtree_mgmt.Qtree_Name}
    [Teardown]    Run Keywords     Delete Qtree    ${qtree_mgmt.Vol_Name}    ${qtree_mgmt.Qtree_Name} 
    ...    AND    Logout From Application
    ...    AND    Close Browser

TC_UI_TNT_QTREE_MGMT_01_06
    [Documentation]    Test for checking delete qtree functionality.
    [Tags]    UI    QTREE
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Tenant}
    ...    AND    Login To Application By Tenant
    ...    AND    Create Qtree    ${qtree_mgmt.Vol_Name}    ${qtree_mgmt.Qtree_Name}
    On Left Pane Navigate To    ${left_pane_links_tenant.List_Qtree}
    sleep   1s
    Select from Drop Down    ${xpaths.vol_dd}      ${qtree_mgmt.Vol_Name}
    Click Button    submit
    ${loc}=    Substitute Name    ${xpaths.qtree_del_check}    ${qtree_mgmt.Qtree_Name}
    sleep    5s
    Click Element    ${loc}
    Click button    delete qtree(s)
    ${msg}=    Confirm Action
    Should Be Equal    ${msg}    Are you sure you want to delete the qtree ${qtree_mgmt.Qtree_Name}?
    sleep    8s
    #Wait Until Page Contains    Qtree "${qtree_mgmt.Qtree_Name}" successfully deleted    timeout=30
    Verify Text On Page    Qtree "${qtree_mgmt.Qtree_Name}" successfully deleted
    [Teardown]    Run Keywords     Logout From Application   
    ...    AND    Close Browser
    
TC_UI_TNT_QTREE_MGMT_01_07
    [Documentation]    Test for checking create quota functionality.
    [Tags]    UI    QUOTA
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Tenant}
    ...    AND    Login To Application By Tenant
    ...    AND    Create Qtree    ${qtree_mgmt.Vol_Name}    ${qouta_mgmt.Qtree_Name}
    On Left Pane Navigate To    ${left_pane_links_tenant.Create_Quota}
    sleep    2s
    Select from Drop Down    ${xpaths.vol_dd}      ${qtree_mgmt.Vol_Name}
    Select from Drop Down    ${xpaths.qtree_dd}      ${qouta_mgmt.Qtree_Name}
    Input Text    ${xpaths.quota_textbox}    100
    Select from Drop Down    ${xpaths.unit_dd}      ${volume_mgmt.Vol_Unit}
    Click Button    submit
    Wait Until Page Contains    Successfully assigned quota on qtree " ${qouta_mgmt.Qtree_Name}".    timeout=30
    [Teardown]    Run Keywords     Delete Qtree    ${qtree_mgmt.Vol_Name}    ${qouta_mgmt.Qtree_Name} 
    ...    AND    Logout From Application
    ...    AND    Close Browser
    
TC_UI_TNT_QTREE_MGMT_01_08
    [Documentation]    Test for checking list quota functionality.
    [Tags]    UI    QUOTA
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Tenant}
    ...    AND    Login To Application By Tenant
    ...    AND    Create Qtree    ${qtree_mgmt.Vol_Name}    ${qouta_mgmt.Qtree_Name}
    ...    AND    Create Quota    ${qtree_mgmt.Vol_Name}    ${qouta_mgmt.Qtree_Name}
    On Left Pane Navigate To    ${left_pane_links_tenant.List_Quota}
    sleep   1s
    Click Button    submit
    Wait Until Page Contains    /vol/${qtree_mgmt.Vol_Name}/${qouta_mgmt.Qtree_Name}    timeout=30
    ${loc}=    Substitute Name    ${xpaths.quota_val_verify}    ${qouta_mgmt.Qtree_Name}
    Wait Until Page Contains Element    ${loc}    timeout=30
    [Teardown]    Run Keywords     Delete Qtree    ${qtree_mgmt.Vol_Name}    ${qouta_mgmt.Qtree_Name} 
    ...    AND    Logout From Application
    ...    AND    Close Browser
    
TC_UI_TNT_QTREE_MGMT_01_09
    [Documentation]    Test for checking delete quota functionality.
    [Tags]    UI    QUOTA
    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Tenant}
    ...    AND    Login To Application By Tenant
    ...    AND    Create Qtree    ${qtree_mgmt.Vol_Name}    ${qouta_mgmt.Qtree_Name}
    ...    AND    Create Quota    ${qtree_mgmt.Vol_Name}    ${qouta_mgmt.Qtree_Name}
    On Left Pane Navigate To    ${left_pane_links_tenant.List_Quota}
    sleep   1s
    Click Button    submit
    ${loc}=    Substitute Name    ${xpaths.quota_del_check}    ${qouta_mgmt.Qtree_Name}
    sleep    5s
    Click Element    ${loc}
    Click button    delete quota(s)
    Wait Until Page Contains    Quota values of '${qouta_mgmt.Qtree_Name} (${qtree_mgmt.Vol_Name})' deleted successfully.    timeout=30
    [Teardown]    Run Keywords     Delete Qtree    ${qtree_mgmt.Vol_Name}    ${qouta_mgmt.Qtree_Name} 
    ...    AND    Logout From Application
    ...    AND    Close Browser

    
#TC_UI_TNT_QTREE_MGMT_01_07
#    [Documentation]    Test for checking create Export functionality.
#    [Tags]    UI    QTREE    tt3
#    [Setup]    Run Keywords    Open Browser To Login Page    ${Generic.SiteUrl_Tenant}
#    ...    AND    Login To Application By Tenant
#    ...    AND    Create Qtree    ${qtree_mgmt.Vol_Name}    ${exp_mgmt.Qtree_Name}
#    On Left Pane Navigate To    ${left_pane_links_tenant.Create_Exp}
#    sleep   1s
#    Select from Drop Down    ${xpaths.qtree_dd}      ${exp_mgmt.Qtree_Name}
#    sleep    5s
#    Input Text    ${xpaths.exp_textbox}    ${exp_mgmt.Exp_IP}
#    Click Button    create
#    Wait Until Page Contains    Qtree "${qouta_mgmt.Qtree_Name}" exported successfully.    timeout=30
#    [Teardown]    Run Keywords     Delete Qtree    ${qtree_mgmt.Vol_Name}    ${exp_mgmt.Qtree_Name} 
#    ...    AND    Logout From Application
#    ...    AND    Close Browser
    