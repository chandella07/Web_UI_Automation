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
    [Documentation]    Test for valid login for Tenant user.
    [Tags]    UI    TENANT    LOGIN    VALID
    [Setup]    Open Browser To Login Page    ${Generic.SiteUrl_Tenant}
    Input Username    ${Tenant.USERNAME}
    Input Password    ${Tenant.PASSWORD}
    Input Organization    ${Generic.Org_Name}
    Submit Credentials
    ${str1}=    Convert To Lowercase    ${Generic.Org_Name}
    Wait Until Page Contains    ${str1}    timeout=30
    Wait Until Page Contains    ${Tenant.USERNAME}    timeout=5
    Wait Until Page Contains    ${Generic.WelcomeMsg_Tenant}    timeout=5
    Logout From Application
    [Teardown]    Close Browser
    
TC_UI_LOGIN_01_02
    [Documentation]    Test for checking Tenant user home page.
    [Tags]    UI    TENANT    LOGIN
    [Setup]    Open Browser To Login Page    ${Generic.SiteUrl_Tenant}
    Input Username    ${Tenant.USERNAME}
    Input Password    ${Tenant.PASSWORD}
    Input Organization    ${Generic.Org_Name}
    Submit Credentials
    Wait Until Page Contains    ${Generic.WelcomeMsg_Tenant}    timeout=30
    Wait Until Page Contains    qtree-list    timeout=5
    Wait Until Page Contains    qtree-manage    timeout=5
    Wait Until Page Contains    qtree-del    timeout=5
    Wait Until Page Contains    quota-list    timeout=5
    Wait Until Page Contains    quota-manage    timeout=5
    Wait Until Page Contains    quota-del    timeout=5
    Wait Until Page Contains    export-list    timeout=5
    Wait Until Page Contains    export-manage    timeout=5
    Wait Until Page Contains    export-remove    timeout=5
    Logout From Application
    [Teardown]    Close Browser    

TC_UI_LOGIN_01_03
    [Documentation]    Test for checking login functionality for Tenant user with ignore case of organization name.
    [Tags]    UI    TENANT    LOGIN
    [Setup]    Open Browser To Login Page    ${Generic.SiteUrl_Tenant}
    Input Username    ${Tenant.USERNAME}
    Input Password    ${Tenant.PASSWORD}
    ${str1}=    Convert To Uppercase    ${Generic.Org_Name}
    Input Organization    ${str1}
    Submit Credentials
    Wait Until Page Contains    ${Generic.WelcomeMsg_Tenant}    timeout=30
    Logout From Application
    [Teardown]    Close Browser

