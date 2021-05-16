public class AuraPaymentController {
    @AuraEnabled
    public static Id getAccountPayment(){
       	Id currentUserID = UserInfo.getUserId();
        system.debug('CurrentUserID: '+ currentUserID);
        Id currentUserAccount = [SELECT accountId FROM User WHERE id=:currentUserID LIMIT 1].accountId;
        system.debug('currentUserAccount: '+ currentUserAccount);
        CardPayment__c cardPayment = [SELECT id FROM CardPayment__c WHERE Account__c= :currentUserAccount LIMIT 1];
        //CardPayment__c cardPayment = [SELECT id FROM CardPayment__c WHERE Account__c= '0015e000004xiA9AAI' LIMIT 1];
        System.debug('Card Payment: '+cardPayment.id);
        return cardPayment.id;
    } 

}