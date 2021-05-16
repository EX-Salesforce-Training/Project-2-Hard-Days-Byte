@IsTest
public class SupportControllerTest {
    
    @IsTest
    static void TestPositive() {
        Account partnerAccount = new Account();
        partnerAccount.Name = 'Partner';
        Database.insert(partnerAccount);
        
        partnerAccount.isPartner = true;
        Database.update(partnerAccount);
        
        Contact partnerContact = new Contact();
        partnerContact.LastName = 'Test';
        partnerContact.AccountId = partnerAccount.Id;
        System.debug('partnerAccount.Id' + partnerAccount.Id);
        Database.insert(partnerContact);
        
        Id partnerProfileId = [SELECT Id FROM Profile WHERE Name = 'Asteria Partner' LIMIT 1].Id;
        Id partnerRoleId = [SELECT Id FROM UserRole WHERE PortalType = 'None' LIMIT 1].Id;
        
        User partnerUser = new User(
            ProfileId = partnerProfileId,
            Username = System.now().millisecond() + System.now().millisecond() + 'test2@test' + System.now().millisecond() + '.com',
            Alias = 'kjanew',
            Email = 'kathryn.janeway@mgail.com',
            EmailEncodingKey = 'UTF-8',
            Firstname = 'Kathryn',
            Lastname = 'Janeway',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/Chicago',
            ContactId = partnerContact.Id
        );
        
        Database.insert(partnerUser);
        Id partnerConId = partnerUser.ContactId;
        
        List<Case> testCaseList = new List<Case>();
        List<Support_FAQ__c> testFAQList = new List<Support_FAQ__c>();
        
        for(Integer i = 0; i < 20; i++) {
            Case c = new Case();
            Support_FAQ__c f = new Support_FAQ__c();
            
            c.ContactId = partnerConId;
            testCaseList.add(c);
            
            f.Name = 'Rawr?' + i;
            f.Answer__c = 'rawr' + i;
            f.Shown__c = True;
            f.Tags__c = 'Asteria';
            testFAQList.add(f);
        }
        
        insert testCaseList;
        insert testFAQList;
        
        System.runAs(partnerUser) {
            List<Case> listCases = SupportController.getCases();
            List<Support_FAQ__c> listFAQs = SupportController.getFAQs();
            System.debug('listCases: ' + listCases);
            System.debug('listFAQs: ' + listFAQs);
            
            Map<String,List<String>> testMap = SupportController.getInitialValues();
            System.assertEquals(UserInfo.getName(),testMap.get('UserName').get(0));
            
            Case newCase = new Case();
            SupportController.saveCase(newCase);
             
            System.assertEquals(3, listCases.size());
            System.assert(listFAQs.size() > 0);
            
            String custQuery = '.Where Asteria rocks?';
            List<String> testChat = SupportController.getChat(custQuery);
            
            System.assert(testChat.size() == 3);
            System.debug(testChat);
        }
    }
    
    @IsTest
    static void TestNegative() {
        Id otherProfileId = [SELECT Id FROM Profile WHERE Name = 'Chatter External User' LIMIT 1].Id;
        Id otherRoleId = [SELECT Id FROM UserRole WHERE PortalType = 'None' LIMIT 1].Id;
        
        User otherUser = new User(
            ProfileId = otherProfileId,
            Username = System.now().millisecond() + System.now().millisecond() + 'test2@test' + System.now().millisecond() + '.com',
            Alias = 'kjanew',
            Email = 'kathryn.janeway@mgail.com',
            EmailEncodingKey = 'UTF-8',
            Firstname = 'Kathryn',
            Lastname = 'Janeway',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/Chicago'
        );
        
        Database.insert(otherUser);
       
        List<Case> testCaseList = new List<Case>();
        List<Support_FAQ__c> testFAQList = new List<Support_FAQ__c>();
        
        for(Integer i = 0; i < 20; i++) {
            Case c = new Case();
            Support_FAQ__c f = new Support_FAQ__c();
            
            testCaseList.add(c);
            
            f.Name = 'Rawr?' + i;
            f.Answer__c = 'rawr' + i;
            f.Shown__c = True;
            f.Tags__c = 'Asteria';
            testFAQList.add(f);
        }
        
        insert testCaseList;
        insert testFAQList;
        
        System.runAs(otherUser) {
            try {
                List<Case> listCases = SupportController.getCases();
            } catch(System.NoAccessException e) {
                System.debug('The following exception has occurred: ' + e.getMessage());
            }
            
        }
        
    }
    
}