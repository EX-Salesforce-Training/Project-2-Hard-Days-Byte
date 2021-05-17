public class LeadCreateController {
    
    @AuraEnabled
    public static Id createLeadRecord(Lead leadInsert){
        upsert leadInsert;
        return leadInsert.id;
    }

}