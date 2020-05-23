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

*** Test Cases ***
TC_UI_LOGIN_01_01
    [Documentation]    Test for valid login.
    [Tags]    UI    LOGIN    VALID
    [Setup]    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    Input Username    ${Admin.USERNAME}
    Input Password    ${Admin.PASSWORD}
    Submit Credentials
    Assert Welcome Message    ${Generic.WelcomeMsg_Admin}
    Logout From Application
    [Teardown]    Close Browser

TC_UI_LOGIN_01_02
    [Documentation]    Test for checking NFS version.
    [Tags]    UI    LOGIN
    [Setup]    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    Page Should Contain    ${Generic.NFS_Version}
    Input Username    ${Admin.USERNAME}
    Input Password    ${Admin.PASSWORD}
    Submit Credentials
    Page Should Contain    ${Generic.NFS_Version}
    Logout From Application
    [Teardown]    Close Browser
    
TC_UI_LOGIN_01_03
    [Documentation]    Test for checking Login with Case sesitive credentials.
    [Tags]    UI    LOGIN
    [Setup]    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    ${str1}=    Convert To Uppercase    ${Admin.USERNAME}
    ${str2}=    Convert To Uppercase    ${Admin.PASSWORD}
    Input Username    ${str1}
    Input Password    ${str2}
    Submit Credentials
    Page Should Contain    ${Generic.ErrorMsg1}
    [Teardown]    Close Browser
    
TC_UI_LOGIN_01_04
    [Documentation]    Test for checking help page link on login page.
    [Tags]    UI    LOGIN
    [Setup]    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    click Link    NFS Portal Help Guide
    ${text1}=    Get Alert Message    dismiss=True
    Should Be Equal    ${text1}    ${Generic.Alert_Msg_Login_help}
    
TC_UI_LOGIN_01_05
    [Documentation]    Test for checking functionality on home link.
    [Tags]    UI    LOGIN
    [Setup]    Open Browser To Login Page    ${Generic.SiteUrl_Admin}
    Input Username    ${Admin.USERNAME}
    Input Password    ${Admin.PASSWORD}
    Submit Credentials
    On Left Pane Navigate To    ${left_pane_links_admin.Filers_List}
    click link    home
    Assert Welcome Message    ${Generic.WelcomeMsg_Admin}
    Logout From Application
    [Teardown]    Close Browser

