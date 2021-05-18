public class AccountController {
    @AuraEnabled
    public static Id getUserID(){
        Id currentUserID = UserInfo.getUserId();
		return currentUserID;
    }
	//@AuraEnabled
    //public static Id getAccountID(){
    //    Id currentUserID = UserInfo.getUserId();
    //    Id currentUserAccount = [SELECT accountId FROM User WHERE id=:currentUserId].accountId;
    //    return currentUserAccount;
    //}
    
}