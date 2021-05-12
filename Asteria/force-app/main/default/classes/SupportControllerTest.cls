@IsTest
public class SupportControllerTest {
    
    @IsTest
    static void testPositive() {
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
        System.debug('partnerUser.ContactId: ' + partnerUser.ContactId);
        System.debug('partnerContact.Id: ' + partnerContact.Id);
        System.debug('PartnerUser Profile Id: ' + partnerUser.ProfileId);
        
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
        System.debug('testCaseList: ' + testCaseList);
        List<Case> explicitCaseList = [SELECT Id, CaseNumber, Reason, Product__c, IsClosed FROM Case WHERE ContactId = :partnerConId LIMIT 3];
        System.debug('explicitCaseList: ' + explicitCaseList);
        insert testFAQList;
        System.debug('testFAQList: ' + testFAQList);
        List<Support_FAQ__c> explicitFAQList = [SELECT Id, Name, Answer__c, Tags__c, Shown__c FROM Support_FAQ__c WHERE Shown__c = True];
        System.debug('explicitFAQList: ' + explicitFAQList);
        List<Support_FAQ__c> listFAQs1 = SupportController.getFAQs();
        System.debug('listFAQs1: ' + listFAQs1);
        
        System.runAs(partnerUser) {
            List<Case> listCases = SupportController.getCases();
            List<Support_FAQ__c> listFAQs = SupportController.getFAQs();
            System.debug('listCases: ' + listCases);
            System.debug('listFAQs: ' + listFAQs);
            
            System.assertEquals(listCases.size(), 3);
            System.assert(listFAQs.size() > 0);
        }
    }
    
}