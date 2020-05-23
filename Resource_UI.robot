*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library    5    10
Library           CustomSeleniumLibrary
Library           Generic_UI
Variables         Variables_UI.yaml
Variables         Credentials_UI.yaml
Variables         ObjectRepository.yaml
Resource          Resource_UI.robot

*** Keywords ***
Open Browser To Login Page
    [Arguments]    ${arg}
    ${profile_path}=  Create Profile    ${Generic.Browser}
    Log    ${profile_path}
    #Open Browser    ${Generic.SiteUrl}    ${Generic.Browser}
    Open Browser    ${arg}    ${Generic.Browser}    ff_profile_dir=${profile_path}    desired_capabilities=${profile_path}
    Maximize Browser Window

#Open Browser To Login Page
#    [Arguments]    ${arg}
#    Open Browser    ${arg}    phantomjs
#	Maximize Browser Window

Input Username
    [Arguments]    ${arg}
    Input Text    username    ${arg}

Input Password
    [Arguments]    ${arg}
    Input Text    password    ${arg}

Input Organization
    [Arguments]    ${arg}
    Input Text    vorgname    ${arg}

Submit Credentials
    Click Button    submit

Assert Welcome Message
    [Arguments]    ${arg}
    Page Should Contain    ${arg}

Login To Application By Admin
    Go To    ${Generic.SiteUrl_Admin}
    Input Username    ${Admin.USERNAME}
    Input Password    ${Admin.PASSWORD}
    Submit Credentials
    Assert Welcome Message    ${Generic.WelcomeMsg_Admin}

Login To Application By Tenant
    Go To    ${Generic.SiteUrl_Tenant}
    Input Username    ${Tenant.USERNAME}
    Input Password    ${Tenant.PASSWORD}
    Input Organization    ${Generic.Org_Name}
    Submit Credentials
    Wait Until Page Contains    ${Generic.WelcomeMsg_Tenant}    timeout=30
    #Assert Welcome Message    ${Generic.WelcomeMsg_Tenant}

Login To Application By Vapp
    Go To     ${Generic.SiteUrl_Vapp}
    Input Username    ${Vapp.USERNAME}
    Input Password    ${Vapp.PASSWORD}
    Input Organization    ${Generic.Org_Name}
    Submit Credentials
    Wait Until Page Contains    ${Generic.WelcomeMsg_Vapp}    timeout=30
    #Assert Welcome Message    ${Generic.WelcomeMsg_Vapp}

Logout From Application
    Click Link    sign out
    Wait Until Page Contains Element    submit    timeout=10
    #Page Should Contain Button   submit
    
Create Volume
    [Arguments]    ${arg1}    ${arg2}    ${arg3}
    On Left Pane Navigate To    ${left_pane_links_admin.Create_New_Vol}
    Select from Drop Down    ${xpaths.filer_dd}      ${arg2}
    Input Text    ${xpaths.vol_name}    ${arg1}
    Input Text    ${xpaths.aggr_name}    ${arg3}
    Input Text    ${xpaths.size}    ${volume_mgmt.Vol_Size}
    Select from Drop Down    ${xpaths.unit_dd}      ${volume_mgmt.Vol_Unit}
	sleep    2s
    Click Button    create
    Verify Text On Page    Successfully created volume "${arg1}" on filer "${arg2}".
    sleep    2s
    
Delete Volume
    [Arguments]    ${arg1}    ${arg2}
    sleep    1s
    On Left Pane Navigate To    ${left_pane_links_admin.Manage_Vol}
    Select from Drop Down    ${xpaths.filer2_dd}      ${arg2}
    Click Button    submit
    ${loc}=    Substitute Name    ${xpaths.rows}    ${arg1}
    sleep   5s
    Click Element    ${loc}
    Click button    deletevolume
    ${msg}=    Confirm Action
    Wait Until Page Contains    Volume '${arg1}' deleted successfully.    timeout=20
    #Verify Text On Page    Volume '${arg1}' deleted successfully.
	
Assign Volume To Org
    [Arguments]    ${arg1_vol}
    On Left Pane Navigate To    ${left_pane_links_admin.Manage_Org_Vol}
    Select from Drop Down    ${xpaths.org_dd}      ${Generic.Org_Name}
    Select from Drop Down    ${xpaths.filer2_dd}      ${Generic.Filer_Name}
    Verify Text On Page    ${arg1_vol}
    ${loc}=    Substitute Name    ${xpaths.list_text}    ${arg1_vol}
    Click Element    ${loc}
	sleep    1s
    Click Button    modify Organization volumes
    sleep    1s
    ${msg}=    Confirm Action
    sleep    1s
    Should Be Equal    ${msg}    ${org_mgmt.Assign_Success}
    
Create Qtree
    [Arguments]    ${arg1}    ${arg2}
    On Left Pane Navigate To    ${left_pane_links_tenant.Create_Qtree}
    Select from Drop Down    ${xpaths.vol_dd}      ${arg1}
    Input Text    ${xpaths.qtree_textbox}    ${arg2}
    Click Button    create
    sleep    5s
    Verify Text On Element    ${xpaths.qtree_success}    Qtree "${arg2}" created successfully.
    
Delete Qtree
    [Arguments]    ${arg1}    ${arg2}
    On Left Pane Navigate To    ${left_pane_links_tenant.List_Qtree}
    sleep    1s
    Select from Drop Down    ${xpaths.vol_dd}      ${arg1}
    Click Button    submit
    ${loc}=    Substitute Name    ${xpaths.qtree_del_check}    ${arg2}
    sleep    5s
    Click Element    ${loc}
    Click button    delete qtree(s)
    ${msg}=    Confirm Action
    Should Be Equal    ${msg}    Are you sure you want to delete the qtree ${arg2}?
    sleep    8s
    Verify Text On Page    Qtree "${arg2}" successfully deleted
    
Create Quota
    [Arguments]    ${arg1_vol}    ${arg2_qtree}
    On Left Pane Navigate To    ${left_pane_links_tenant.Create_Quota}
    sleep   2s
    Select from Drop Down    ${xpaths.vol_dd}      ${arg1_vol}
    Select from Drop Down    ${xpaths.qtree_dd}      ${arg2_qtree}
    Input Text    ${xpaths.quota_textbox}    100
    Select from Drop Down    ${xpaths.unit_dd}      ${volume_mgmt.Vol_Unit}
    Click Button    submit
    Wait Until Page Contains    Successfully assigned quota on qtree " ${arg2_qtree}".    timeout=30
 
 Delete Quota
    [Arguments]    ${arg1_vol}    ${arg2_qtree}
    On Left Pane Navigate To    ${left_pane_links_tenant.List_Quota}
    sleep   1s
    Click Button    submit
    ${loc}=    Substitute Name    ${xpaths.quota_del_check}    ${arg2_qtree}
    sleep    5s
    Click Element    ${loc}
    Click button    delete quota(s)
    Wait Until Page Contains    Quota values of '${arg2_qtree} (${arg1_vol})' deleted successfully.    timeout=30
    
    