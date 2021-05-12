public class SupportController {
	@AuraEnabled
    public static List<Case> getCases() {
        return [SELECT Id, CaseNumber, Reason, Product__c, IsClosed FROM Case LIMIT 3];
    }
    
    @AuraEnabled
    public static List<Support_FAQ__c> getFAQs() {
        return [SELECT Id, Name, Answer__c, Tags__c FROM Support_FAQ__c WHERE Shown__c = True];
    }
    
    private static Id getAccountId() {
        Id userId = UserInfo.getUserId();
        Id userAcctId = [SELECT AccountID FROM User WHERE Id = :userId].accountId;
        return userAcctId;
    }
}