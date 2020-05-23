Web_UI_Automation:
==================
Test automation framework used for web based application. 

This framework is based on robotframework test automation and Generic browser profiles settings in used in this framework.

Technologies:
=============

> Language: **python**

> Test automation framework: **robotframework**

> Library: **Selenium2library**

Pre-requsite:
=============

1. These tests will execute on Windows systems.
2. Robot framework should be installed on the system.
3. install selenium library (pip install selenium)
3. Browser driver (.exe) needs to be downloaded and it's path should be added in system path variable.
   e.g for executing tests on firefox browser, Firefox driver (geckodriver.exe) needs to be downloaded and it should be added in system path variable.
        
    
Configration:
=============

- There are two configration files Variables_UI.yaml and Credentails_UI.yaml
- You can set the system Credentails in Credentails_UI.yaml file
- You can change the Web UI parameters from Variables_UI.yaml file
  e.g Browser, Site URL etc

Execution:
==========

robot {Test_suite_file_name}

or

robot -i {tag_name}  {Test_suite_file_name}

Conclusion:
===========

This is the reference automation framework for any WEB UI based application. It uses the custom selenium libraries to create browser profile and to implement robot keywords for testcases. Object repository concept is also used in this, along with config data in yaml files.
