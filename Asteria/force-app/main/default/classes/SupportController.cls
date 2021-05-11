public class SupportController {
	@AuraEnabled
    public static List<Case> getCases() {
        return [SELECT Id, IsClosed FROM Case LIMIT 4];
    }
    
    @AuraEnabled
    public static List<Support_FAQ__c> getFAQs() {
        return [SELECT Id, Name, Answer__c, Tags__c FROM Support_FAQ__c];
    }
}