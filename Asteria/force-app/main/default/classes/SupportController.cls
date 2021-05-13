public class SupportController {
    @AuraEnabled
    public static Map<String,List<String>> getInitialValues() {
        // Get Username, Product__c, Type, Reason
        Map<String,List<String>> initialValueMap = new Map<String,List<String>>();
        
        List<String> userNameList = new List<String>();
        userNameList.add(UserInfo.getName());
        initialValueMap.put('UserName',userNameList);
        
        Schema.DescribeFieldResult productFieldResult = case.Product__c.getdescribe();
        List<Schema.PicklistEntry> productPicklistOptions = productFieldResult.getPicklistValues();
        List<String> productPicklistValues = new List<String>();
        for(Schema.PicklistEntry o: productPicklistOptions) {
            productPicklistValues.add(o.getValue());
        }
        initialValueMap.put('Product__c', productPicklistValues);
        
        Schema.DescribeFieldResult typeFieldResult = case.Type.getdescribe();
        List<Schema.PicklistEntry> typePicklistOptions = typeFieldResult.getPicklistValues();
        List<String> typePicklistValues = new List<String>();
        for(Schema.PicklistEntry o: typePicklistOptions) {
            typePicklistValues.add(o.getValue());
        }
        initialValueMap.put('Type', typePicklistValues);
        
        Schema.DescribeFieldResult reasonFieldResult = case.Reason.getdescribe();
        List<Schema.PicklistEntry> reasonPicklistOptions = reasonFieldResult.getPicklistValues();
        List<String> reasonPicklistValues = new List<String>();
        for(Schema.PicklistEntry o: reasonPicklistOptions) {
            reasonPicklistValues.add(o.getValue());
        }
        initialValueMap.put('Reason', reasonPicklistValues);
        
        return initialValueMap;
    }
    
    @AuraEnabled
    public static List<Case> getCases() {
        String[] fieldsToCheck = new String[]{'Id', 'CaseNumber', 'Subject', 'Product__c', 'IsClosed'};
        Map<String,Schema.SObjectField> fieldDescribeTokens = Schema.SObjectType.Case.fields.getMap();
        
        for(String field: fieldsToCheck) {
            if(!fieldDescribetokens.get(field).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }
        }
        
        Id userConId = getConId();
        return [SELECT Id, CaseNumber, Subject, Product__c, IsClosed FROM Case WHERE ContactId = :userConId ORDER BY CaseNumber DESC LIMIT 3];
		//return [SELECT Id, CaseNumber, Subject, Product__c, IsClosed FROM Case ORDER BY CaseNumber DESC LIMIT 3];
    }
    
    @AuraEnabled
    public static void saveCase(Case newCase) {
        newCase.ContactId = getConId();
        insert newCase;
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