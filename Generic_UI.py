from robot.libraries.BuiltIn import BuiltIn
from selenium.common.exceptions import WebDriverException
import re

class Generic_UI(object):
    '''
    Generic class to implement useful selenium library keywords based on testcases.
    '''
    
    sellib = BuiltIn().get_library_instance('Selenium2Library')
    
    def handle_prompt(self, text="", locator=""):
        ''' Handles web based prompts '''
        alert = None
        try:
            alert = self.sellib._current_browser().switch_to_alert()
            alert.accept()
        except WebDriverException:
            raise RuntimeError('There were no alerts')
        
    def on_left_pane_navigate_to(self, link):
        ''' Navigate to specific link on left pane ''' 
        self.sellib.click_link(link)
        
    def verify_text_on_page(self, text):
        ''' Verify the given text on web page '''
        self.sellib.page_should_contain(text)
               
    def verify_text_on_element(self, locator, text):
        ''' Verify the given text on the specific web element '''
        self.sellib.element_should_contain(locator, text)
        
    def select_from_drop_down(self, locator, text):
        ''' selects the specific filer from drop down '''
        loc= self.substitute_name(locator, text)
        self.sellib._log(loc)
        self.sellib.click_element(loc)
        
    def enter_text_in_search_box(self, locator, text):
        ''' writes specific text in the input textbox '''
        self.sellib.input_text(locator, text)
        
    def substitute_name(self, locator, text):
        ''' replaces name value in locator '''
        loc = re.sub('TEXT', text, locator)
        return loc
        
    def select_delete_checkbox_for_volume(self, row_loc, del_loc, volname):
        ''' select specific row with volume name for delete '''
#         ele = self.sellib.find_elements_by_xpath(row_loc)
#             for e in ele:
#                 for td in e.find_elements_by_xpath(".//td"):
#                     td.text      
#         table =  driver.find_element_by_xpath("//table[@class='datadisplaytable']")
#         for row in table.find_elements_by_xpath(".//tr"):
#             print([td.text for td in row.find_elements_by_xpath(".//td[@class='dddefault'][text()]")
         