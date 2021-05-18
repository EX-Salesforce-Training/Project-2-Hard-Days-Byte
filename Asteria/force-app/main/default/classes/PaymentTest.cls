@isTest
public class PaymentTest {

    @isTest
    public static void AccountTest(){
        Account partnerAccount = new Account();
        partnerAccount.Name ='partner';
        partnerAccount.Phone ='1231231234';
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
            Username = System.now().millisecond() + 'test2@test.com',
            Alias = 'NatFil',
            Email='nathan.fillion@mgail.com',
            EmailEncodingKey='UTF-8',
            Firstname='Nathan',
            Lastname='Fillion',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            TimeZoneSidKey='America/Chicago',
            ContactId = partnerContact.id
        );
        
        Database.insert(partnerUser); 
        System.runAs(partnerUser){
            //Id currentUserAccount = AuraAccountController.getAccountPayment();
           // Id currentUserID = UserInfo.getUserId();
       		//Id currentUserAccountid = [SELECT accountId FROM User WHERE id=:currentUserId].accountId;
           //System.assertEquals(currentUserAccountid, currentUserAccount);
           
        }
    }

}