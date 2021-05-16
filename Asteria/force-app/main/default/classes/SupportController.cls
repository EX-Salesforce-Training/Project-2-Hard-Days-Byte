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
    
    @AuraEnabled
    public static List<String> getChat(String custQuery) {
        // Transform customer's query to uppercase and split into words and punctuation
        List<String> queryWords = custQuery.toUppercase().splitByCharacterType();
        
        // The tags are all singular, so convert customer inquiry to singular words
        // (future iteration: What if irregular plural??)
        List<String> sWordsList = new List<String>();
        for (String w: queryWords) {
            if (w.substring(w.length()-1) == 's'){
                sWordsList.add(w.substring(0,w.length()-1));
            } else {
                sWordsList.add(w);
            }
        }
        
        // Get list of tags
        Schema.DescribeFieldResult tagsFieldResult = Support_FAQ__c.Tags__c.getdescribe();
        List<Schema.PicklistEntry> tagsPicklistOptions = tagsFieldResult.getPicklistValues();
        List<String> validTags = new List<String>();
        for(Schema.PicklistEntry o: tagsPicklistOptions) {
            validTags.add(o.getValue().toUppercase());
        }
        
        // Run through all tags, and if a tag is contained in the search query,
        // add it to a list
        List<String> containList = new List<String>();
        for(String s: validTags) {
            if(sWordsList.contains(s)) {
                containList.add(s);
            }
        }
        
        // Grab the first tag contained in search result
        // (Future iteration: handle multiple tags in query)
        String searchString = containList[0];
        List<Support_FAQ__c> chatResults = [SELECT Name, Answer__c FROM Support_FAQ__c WHERE Tags__c includes (:searchString) LIMIT 3];
        
        // Give the .js helper something easy to split up
        List<String> parsedAnswers = new List<String>();
        for (Support_FAQ__c sf: chatResults) {
            String question = sf.Name;
            String answer = sf.Answer__c;
            parsedAnswers.add(question + '§' + answer);
        }
        
        // Return easily splittable question/answer pairs
        return parsedAnswers;
    }
    
    private static Id getConId() {
        Id userId = UserInfo.getUserId();
        Id userConId = [SELECT ContactID FROM User WHERE Id = :userId].ContactId;
        return userConId;
    }
}