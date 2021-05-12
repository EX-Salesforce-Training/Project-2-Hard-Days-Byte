public without sharing class AuraStoreController {
    
    //return inventoryList based off no orders
    @AuraEnabled
    public static List<Inventory__c> getInventoryList(){
    	List<Inventory__c> availableInventoryList = [SELECT Id, Name, Mining_Site_List__c, Status__c, Mothership__r.Name, Ore_Type__c, Weight__c, Item_Price_Text__c 
                                                 FROM Inventory__c 
                                                 WHERE Status__c='Approved' 
                                                 AND Number_of_Orders__c = 0 
                                                 ORDER BY Item_Price__c 
                                                 ASC];
    	return availableInventoryList;
 	}
    
    //Add InventoryListToCart
    @AuraEnabled
    public static void addInventoryListToCart(List<Id> inventoryList){
        Id userAcct = getAccountId();
        List<Purchase_Orders__c> newOrders = new List<Purchase_Orders__c>();
        for(Id invId : inventoryList){
            Purchase_Orders__c newOrder = new Purchase_Orders__c(Account__c = userAcct, Inventory__c = invId, Status__c='New');
            newOrders.add(newOrder);
        }
        system.debug(newOrders);
		Database.SaveResult[] srList = Database.insert(newOrders, false);
        for(Database.SaveResult sr : srList){
            system.debug(sr.isSuccess());
            system.debug(sr.getId());
        }
    }
    
    //orderType is the Status of the order and will return a mapped list for different uses based on location of component
    //FIGURE OUT HOW TO ADD PHOTOS!!!!
    @AuraEnabled
    public static Map<String, List<Purchase_Orders__c>> getPurchaseOrdersByType(String orderType){
        Id userAcct = getAccountID();
        String queryTemplate = 'SELECT Id, Name, Account__c, Inventory__c, Inventory_Type__c, Inventory_Weight__c, Status__c FROM Purchase_Orders__c WHERE '+ orderType +' AND Account__c = \'' + userAcct + '\'';
        List<Purchase_Orders__c> queryOrders = Database.query(queryTemplate);
        Map<String, List<Purchase_Orders__c>> ordersByType = new Map<String, List<Purchase_Orders__c>>();
        for(Purchase_Orders__c order:queryOrders){
            if(ordersByType.containskey(order.Status__c)){
                ordersByType.get(order.Status__c).add(order);
            }else{
                List<Purchase_Orders__C> newList = new List<Purchase_Orders__c>{order};
                ordersByType.put(order.Status__c, newList);
            }
        }
        return ordersByType;             
    }
    
    //get all pictures from Single Item

    
    //returns id of current User
    @testVisible
    private static Id getAccountID(){
        Id userId = UserInfo.getUserId();
        Id userAcct = [SELECT accountId FROM User WHERE id=:userId].accountId;
        return userAcct;
    }
}