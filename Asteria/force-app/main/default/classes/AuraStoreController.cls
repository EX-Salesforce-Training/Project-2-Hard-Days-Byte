public without sharing class AuraStoreController {
    
    //return inventoryList based off no orders
    @AuraEnabled
    public static List<Inventory__c> getInventoryList(){
<<<<<<< HEAD
    	List<Inventory__c> availableInventoryList = [SELECT Id, Name, Mining_Site_List__c, Status__c, Mothership__r.Name, Ore_Type__c, Weight__c, Item_Price_Text__c 
                                                 FROM Inventory__c 
                                                 WHERE Status__c='Approved' 
                                                 AND Number_of_Orders__c = 0 
                                                 ORDER BY Item_Price__c 
                                                 DESC];
=======
    	List<Inventory__c> availableInventoryList = [SELECT Id, Name, Mining_Site_List__c, Status__c, Mothership__r.Name, Ore_Type__c, Weight__c, Item_Price_Text__c, Number_Of_Orders__c 
                                                 	FROM Inventory__c 
                                                 	WHERE Status__c='Approved' 
                                                 	AND Number_of_Orders__c = 0 
                                                 	ORDER BY Item_Price__c 
                                                 	DESC];
>>>>>>> 9ba4ec957e41326ceb235d967f3b7700f3cbeb5c
    	return availableInventoryList;
 	}
    
    //returns featured inventory
    @AuraEnabled
    public static List<Inventory__c> getFeaturedInventory(){
<<<<<<< HEAD
        List<Inventory__c> featuredInventoryList = [SELECT Id, Name, Featured__c, Mining_Site_List__c, Status__c, Mothership__r.Name, Ore_Type__c, Weight__c, Item_Price_Text__c 
                                                 FROM Inventory__c 
                                                 WHERE Status__c='Approved' 
                                                 AND Number_of_Orders__c = 0 
                                                 AND Featured__c = true
                                                 ORDER BY Item_Price__c 
                                                 DESC LIMIT 4];
=======
        List<Inventory__c> featuredInventoryList = [SELECT Id, Name, Featured__c, Mining_Site_List__c, Status__c, Mothership__r.Name, Ore_Type__c, Weight__c, Item_Price_Text__c, Number_Of_Orders__c 
                                                 	FROM Inventory__c 
                                                 	WHERE Status__c='Approved' 
                                                 	AND Number_of_Orders__c = 0 
                                                 	AND Featured__c = true
                                                 	ORDER BY Item_Price__c 
                                                 	DESC LIMIT 4];
>>>>>>> 9ba4ec957e41326ceb235d967f3b7700f3cbeb5c
    	return featuredInventoryList;
    }
    
    //Add InventoryListToCart
    @AuraEnabled
    public static List<Integer> addInventoryListToCart(List<Id> inventoryList){
        Id userAcct = getAccountId();
        List<Purchase_Orders__c> newOrders = new List<Purchase_Orders__c>();
        for(Id invId : inventoryList){
            //hardcoded Account until user implementation
<<<<<<< HEAD
            Purchase_Orders__c newOrder = new Purchase_Orders__c(Account__c = '0015e000005FvciAAC', Inventory__c = invId, Status__c='New');
            //Purchase_Orders__c newOrder = new Purchase_Orders__c(Account__c = userAcct, Inventory__c = invId, Status__c='New');
=======
            //Purchase_Orders__c newOrder = new Purchase_Orders__c(Account__c = '0015e000005FvciAAC', Inventory__c = invId, Status__c='New');
            Purchase_Orders__c newOrder = new Purchase_Orders__c(Account__c = userAcct, Inventory__c = invId, Status__c='New');
>>>>>>> 9ba4ec957e41326ceb235d967f3b7700f3cbeb5c
            newOrders.add(newOrder);
        }
		Database.SaveResult[] srList = Database.insert(newOrders, false);
        
        List<Integer> outOfStock = new List<Integer>();
        for(Integer i = 0; i < srList.size(); i++){
            if(!srList[i].isSuccess()){
               outOfStock.add(i);
            }
        }
        return outOfStock;
    }
    
    //orderType is the Status of the order and will return a mapped list for different uses based on location of component
    @AuraEnabled
    public static Map<String, List<Purchase_Orders__c>> getPurchaseOrdersByType(){
        Id userAcct = getAccountID();
<<<<<<< HEAD
        //HardCoded Account until User!!!!
        //String queryTemplate = 'SELECT Id, Name, Account__c, Inventory__c, Inventory_Type__c, Inventory_Weight__c, Status__c FROM Purchase_Orders__c WHERE Account__c = \'' + userAcct + '\'';
        String queryTemplate = 'SELECT Id, Name, Account__c, Inventory__c, Inventory_Type__c, Inventory_Weight__c, Status__c, Inventory__r.Item_Price_Text__c, Inventory__r.Mining_Site_List__c FROM Purchase_Orders__c WHERE Account__c = \'0015e000005FvciAAC\'';
        List<Purchase_Orders__c> queryOrders = Database.query(queryTemplate);
=======
        List<Purchase_Orders__c> queryOrders = [SELECT Id, Name, Account__c, Inventory__c, Inventory_Type__c, Inventory_Weight__c, Status__c FROM Purchase_Orders__c WHERE Account__c = :userAcct];
>>>>>>> 9ba4ec957e41326ceb235d967f3b7700f3cbeb5c
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
    
    @AuraEnabled
    public static void deletePurchaseOrder(Id order){
        
<<<<<<< HEAD
        //Id AccountId = getAccountId();
        Purchase_Orders__c orderToDelete = [SELECT id, Account__c FROM Purchase_Orders__c WHERE id = :order LIMIT 1];
        //if(orderToDelete.Account__c == AccountId){
        	delete orderToDelete;    
        //}
=======
        Id AccountId = getAccountId();
        Purchase_Orders__c orderToDelete = [SELECT id, Account__c FROM Purchase_Orders__c WHERE id = :order LIMIT 1];
        if(orderToDelete.Account__c == AccountId){
        	delete orderToDelete;    
        }
>>>>>>> 9ba4ec957e41326ceb235d967f3b7700f3cbeb5c
    }
    
    //get all pictures from Single Item
	
    //send New Orders
    @AuraEnabled
    public static void sendNewOrders(List<Id> newOrders){
        List<Purchase_Orders__c> pendingOrders = [SELECT status__c FROM Purchase_Orders__C WHERE id IN :newOrders];
        for(Purchase_Orders__c order: pendingOrders){
            order.Status__c = 'Pending';
        }
        update pendingOrders;
    }
    
    //returns id of current User
    @testVisible
    private static Id getAccountID(){
        Id userId = UserInfo.getUserId();
        Id userAcct = [SELECT accountId FROM User WHERE id=:userId].accountId;
        return userAcct;
    }
}