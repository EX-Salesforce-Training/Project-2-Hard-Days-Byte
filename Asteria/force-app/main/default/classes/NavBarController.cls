////////////////////////////////////////////////////
//
// Name: Asteria - Navigation Bar Controller
// Author: David J. Sellinger
// Created: 2021-05-13
// Updated: 2021-05-14
// Description: Simple controller for the navigation
//              bar.
//
////////////////////////////////////////////////////

public class NavBarController {
	
    @AuraEnabled
    public static boolean getLogged() {
        if (UserInfo.getUserType() != 'PowerPartner') {
            return False;
        }
        else {
            return True;
        }
    }
    
}