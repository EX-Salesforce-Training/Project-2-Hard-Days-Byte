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