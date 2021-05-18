@isTest
public class LeadControllerTest {
    
    @TestSetup
    static void testLead(){
      	Account partnerAccount = new Account();
        partnerAccount.Name ='partner';
        
        Database.insert(partnerAccount);
        
        partnerAccount.isPartner = true;
        
        Database.update(partnerAccount);
        
        Contact partnerContact = new Contact();
        partnerContact.LastName = 'test';
        partnerContact.AccountId = partnerAccount.Id;
        
        Database.insert(partnerContact);
        
        Id partnerProfileId = [SELECT id FROM Profile WHERE name='Asteria Partner' Limit 1].id;
        Id partnerRoleId = [Select Id From UserRole Where PortalType = 'None' Limit 1].id;
        
        User partnerUser = new User(
            ProfileId = partnerProfileId,
            Username = System.now().millisecond() + 'test42@test.com',
            Alias = 'Hath',
            Email='Hath.Annaway@mgail.com',
            EmailEncodingKey='UTF-8',
            Firstname='Hath',
            Lastname='Annaway',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            TimeZoneSidKey='America/Chicago',
            ContactId = partnerContact.id
        );
        
        Database.insert(partnerUser);
      List<Lead> testLeads = new List<Lead>();
 
      for(Integer i = 0;i < 25; i++) {
         testLeads.add(new Lead(FirstName = 'tester'+i, LastName= 'testLead'+i, Company= 'testCompany'+i, Email='tester'+i+'@test.com', Phone='654684741'+i));
      }
        system.runAs(partnerUser){
            insert testLeads;
        }
    }

	@isTest
    static void createLeadRecordSingleTest(){
        Lead testLead = new Lead(FirstName='The', LastName='Tester', Company='testingtesterinc', Email='thetester@test.com', Phone='6546354121');
        Id tL = LeadController.createLeadRecord(testLead);
        Lead assertLead = [SELECT Id, Name, Company, Email, Phone, FirstName FROM Lead WHERE Id=:tL];
        system.assertEquals('The', assertLead.FirstName);   
    }
    
    @isTest
    static void getLeadsPositiveTest(){
        
        User partnerUser = [SELECT id FROM User WHERE alias='Hath'];
        
        List <Lead> testList = new List<Lead>();
        system.runAs(partnerUser){
        	testList = LeadController.getLeads();
        }
        system.assertEquals(25, testList.size());
        
    }
    

}