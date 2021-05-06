trigger NoDuplicateOrder on Purchase_Orders__c(before insert, before update){/*
   
    public void method1(){
    Set<Purchase_Orders__c> orderSet=[SELECT ID,Inventory__c.ID,Inventory__c.Name 
                                      FROM Purchase_Orders__c IN :Trigger.new LIMIT 1];
    List<Purchase_Orders__c> orderList=[SELECT ID,Name FROM Purchase_Orders__c IN orderSet];
        
    }*/
}