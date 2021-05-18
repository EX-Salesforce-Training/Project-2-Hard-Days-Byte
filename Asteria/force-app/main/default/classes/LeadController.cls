public class LeadController {
    
    //method for creating lead component
    @AuraEnabled
    public static Id createLeadRecord(Lead leadInsert){
        upsert leadInsert;
        return leadInsert.id;
    }
    
    //method for retrieving list of leads
    @AuraEnabled
    public static List<Lead> getLeads() {
        Id userId = AccountController.getUserID();
        List<Lead> myLeads =
                [SELECT Id, Name, Phone, Email, Company FROM Lead WHERE ownerId = :userId];
        //Add isAccessible() check
        return myLeads;
    }
    
    //method for saving edited leads
    @AuraEnabled
    public static List<Lead> updateLeadEdit(List<Lead> editLeadList){
        //List<Lead> leads = [SELECT Id FROM  WHERE ]
        
       //for(List <Lead> i:editLeadList){
            //if(editLeadList[i].Name != null){
                //system.debug(editLeadList[i].Name);
            //}
        //}
        //system.debug('entered method');
        update editLeadList;
        system.debug('updated '+ editLeadList);
		        
        return editLeadList;
    }

}