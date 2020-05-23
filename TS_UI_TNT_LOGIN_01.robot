*** Settings ***
Documentation     These tests are related to login functionality for Tenant user of the Application.
...               It covers Invalid login fuctionality.
...               These tests are data-driven by their nature.
Library           Selenium2Library    5    10
Library           CustomSeleniumLibrary
Library           Generic_UI
Variables         Variables_UI.yaml
Variables         Credentials_UI.yaml
Variables         ObjectRepository.yaml
Resource          Resource_UI.robot
Force Tags        UI    LOGIN
Suite Setup       Open Browser To Login Page    ${Generic.SiteUrl_Tenant}
Suite Teardown    Close Browser
Test Template     Login With Invalid Credentials Should Fail

*** Test Cases ***                       USER NAME            PASSWORD            ORGANIZATION            
TC_UI_LOGIN_01_INVALID_01                invalid              ${Tenant.PASSWORD}  ${Generic.Org_Name}
TC_UI_LOGIN_01_INVALID_02                ${Tenant.USERNAME}   invalid             ${Generic.Org_Name}
TC_UI_LOGIN_01_INVALID_03                invalid              whatever            ${Generic.Org_Name}


*** Keywords ***
Login With Invalid Credentials Should Fail
    [Arguments]    ${Tenant.USERNAME}    ${Tenant.PASSWORD}    ${Generic.Org_Name}
    Input Username    ${Tenant.USERNAME}
    Input Password    ${Tenant.PASSWORD}
    Input Organization    ${Generic.Org_Name}
    Submit Credentials
	sleep    2s
    Login Should Have Failed

Login Should Have Failed
    Page Should Contain    ${Generic.ErrorMsg2}
