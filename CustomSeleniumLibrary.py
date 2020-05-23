import os
from robot.libraries.BuiltIn import BuiltIn
from selenium import webdriver

class CustomSeleniumLibrary(object):
    '''
    Custom python selenium library class to create browser profile.
    '''
    
    sel2lib = BuiltIn().get_library_instance('Selenium2Library')

    def create_profile(self, browser):
        ''' setting up the profile for browser '''
        if browser == "Firefox":
            fp = webdriver.FirefoxProfile()
            fp.accept_untrusted_certs = True
            fp.set_preference("browser.download.folderList",2)
            fp.set_preference("browser.download.manager.showWhenStarting",False)
            fp.set_preference("browser.download.dir", os.getcwd())
            fp.set_preference("browser.helperApps.neverAsk.saveToDisk",'application/csv')
            fp.update_preferences()
            return fp.path
        elif browser == "Chrome":
            options = webdriver.ChromeOptions()
            options.add_argument('--ignore-certificate-errors')
        elif browser == "IE":
            capabilities = webdriver.DesiredCapabilities().INTERNETEXPLORER
            capabilities['acceptSslCerts'] = True
            return capabilities


