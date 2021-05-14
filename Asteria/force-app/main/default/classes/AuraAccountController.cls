public class AuraAccountController {
    /**@AuraEnabled
    public static Id getUserID(){
        Id currentUserID = UserInfo.getUserId();
		return currentUserID;
    }**/
	@AuraEnabled
    public static Id getAccountID(){
        Id currentUserID = UserInfo.getUserId();
        System.debug('AccountCurrentUserID: '+ currentUserID);
        Id currentUserAccount = [SELECT accountId FROM User WHERE id=:currentUserID LIMIT 1].accountId;
        system.debug('Account user Account: '+ currentUserAccount);
        return currentUserAccount;
         
    } 
    /**
    @AuraEnabled
    public static Id getAccountPayment(){
        Id currentUserID = UserInfo.getUserId();
        Id currentUserAccount = [SELECT accountId FROM User WHERE id=:currentUserId].accountId;
        Id cardPayment = [SELECT id FROM CardPayment__c WHERE Account__c= :currentUserAccount].Id;
        return cardPayment;
    } **/
   @AuraEnabled
    public static Id runAsPartner(){
        try{
        User currentUserID = [SELECT id FROM User WHERE alias='nfill'];
        Id currentUserAccountID = [SELECT accountId FROM User WHERE id=:currentUserID.id].accountId;
        //Id currentUserID = '2F0055e0000027n';
        //Id AccountID= currentUserAccountID ;
      
       // system.debug(AccountID);
       system.debug(currentUserAccountID);
       return currentUserAccountID;
            
        }
        catch(exception e){
            system.debug(e);
        }
        
        return null;
        
    }
    /**
      @AuraEnabled
    public static Id runAsPartnerPayment(){
        
        User currentUserID = [SELECT id FROM User WHERE alias='nfill'];
        Id currentUserAccountID = [SELECT accountId FROM User WHERE id=:currentUserID.id].accountId;
		 Id cardPayment = [SELECT id FROM CardPayment__c WHERE Account__c= :currentUserAccountID].Id;
        return cardPayment;        
        
    }
    **/
     //Id currentUserID = '2F0055e0000027n';
        //Id AccountID= currentUserAccountID ;
       /** System.runAs(currentUserID){
            Id currentUserAccount =  getAccountID();
            AccountID = getAccountID();
            return currentUserAccount;
        }**/
       // system.debug(AccountID);
}