@isTest
public class LeadControllerTest {
    
    @TestSetup
    static void testLead(){
      List<Lead> testLeads = new List<Lead>();
 
      for(Integer i = 0;i < 25; i++) {
         testLeads.add(new Lead(FirstName = 'tester'+i, LastName= 'testLead'+i, Company= 'testCompany'+i, Email='tester'+i+'@test.com', Phone='654684741'+i));
        
    	}
    }

	@isTest
    static void createLeadRecordSingleTest(){
        Lead testLead = new Lead(FirstName='The', LastName='Tester', Company='testingtesterinc', Email='thetester@test.com', Phone='6546354121');
        Id tL = LeadController.createLeadRecord(testLead);
        Lead assertLead = [SELECT Id, Name, Company, Email, Phone FROM Lead WHERE Id=:tL];
        system.assertEquals('The', assertLead.FirstName); 
        
    }
    
    @isTest
    static void getLeadsPositiveTest(){
        List <Lead> testList = new List<Lead>();
        testList = LeadController.getLeads();
        system.assertEquals('tester0 testLead', testList[0].Name);
        system.assertEquals(25, testList.size());
        
    }
    

}