@IsTest
public class NavBarControllerTest {
	
    @IsTest
    public static void PositiveTest() {
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
        
        System.runAs(partnerUser) {
            System.assertEquals(True, NavBarController.getLogged());
        }
    }
    
    @IsTest
    public static void NegativeTest() {
        System.assertEquals(False, NavBarController.getLogged());
    }
}