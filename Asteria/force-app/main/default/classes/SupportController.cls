public class SupportController {
	@AuraEnabled
    public static List<Case> getCases() {
        Id userConId = getConId();
        return [SELECT Id, CaseNumber, Reason, Product__c, IsClosed FROM Case WHERE ContactId = :userConId LIMIT 3];
        // return [SELECT Id, CaseNumber, Reason, Product__c, IsClosed FROM Case LIMIT 3];
    }
    
    @AuraEnabled
    public static List<Support_FAQ__c> getFAQs() {
        return [SELECT Id, Name, Answer__c, Tags__c, Shown__c FROM Support_FAQ__c WHERE Shown__c = True];
    }
    
    private static Id getConId() {
        Id userId = UserInfo.getUserId();
        Id userConId = [SELECT ContactID FROM User WHERE Id = :userId].ContactId;
        return userConId;
    }
}