*** Settings ***
Documentation     These tests are related to login functionality of the Application.
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
Suite Setup       Open Browser To Login Page    ${Generic.SiteUrl_Admin}
Suite Teardown    Close Browser
Test Template     Login With Invalid Credentials Should Fail

*** Test Cases ***                       USER NAME        PASSWORD
TC_UI_LOGIN_01_INVALID_01                   invalid          ${Admin.PASSWORD}
TC_UI_LOGIN_01_INVALID_02                   ${Admin.USERNAME}      invalid
TC_UI_LOGIN_01_INVALID_03                   invalid          whatever


*** Keywords ***
Login With Invalid Credentials Should Fail
    [Arguments]    ${Admin.USERNAME}    ${Admin.PASSWORD}
    Input Username    ${Admin.USERNAME}
    Input Password    ${Admin.PASSWORD}
    Submit Credentials
	sleep    2s
    Login Should Have Failed

Login Should Have Failed
    Page Should Contain    ${Generic.ErrorMsg1}
