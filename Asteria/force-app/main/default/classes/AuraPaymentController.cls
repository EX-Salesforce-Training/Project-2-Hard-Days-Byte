public class AuraPaymentController {
     @AuraEnabled
    public static Id getAccountPayment(){
        Id currentUserID = UserInfo.getUserId();
        system.debug('CurrentUserID: '+ currentUserID);
        Id currentUserAccount = [SELECT accountId FROM User WHERE id=:currentUserId LIMIT 1].accountId;
        system.debug('currentUserAccount: '+ currentUserAccount);
        Id cardPayment = [SELECT id FROM CardPayment__c WHERE Account__c= :currentUserAccount LIMIT 1].Id;
        System.debug('Card Payment: '+cardPayment);
        return cardPayment;
    } 

}