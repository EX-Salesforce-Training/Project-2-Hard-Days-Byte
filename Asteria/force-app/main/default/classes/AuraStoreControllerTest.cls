@isTest
public class AuraStoreControllerTest {
    

    @TestSetup
    static void testSetup(){
        
        List<Inventory__c> testInventory = new List<Inventory__c>();
        
        for(Integer i = 0;  i < 50; i++){
            Inventory__c testSingle = new Inventory__c();
            if(i < 25){
                testSingle.Status__c = 'New';
                testSingle.Mining_Site_List__c = 'Astyanax (1871)';
                testSingle.Ore_Type__c = 'Gold';
            	testSingle.Weight__c = 2.5;
                testInventory.add(testSingle);
            }else{
                testSingle.Status__c = 'Approved';
                testSingle.Mining_Site_List__c = 'Astyanax (1871)';
                testSingle.Ore_Type__c = 'Gold';
                testSingle.Weight__c = 2.5;
                testInventory.add(testSingle);
            }
        }
        
        Database.insert(testInventory);

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
    }
    
    @isTest
    static void getInventoryReturnsInventory(){
       
       List<Inventory__c> approvedItems = AuraStoreController.getInventoryList();
        System.assertEquals(25, approvedItems.size());
        for(Inventory__c item:approvedItems){
            System.assertEquals('Approved', item.status__c);
        }
        
    }
    
    @isTest 
    static void getAccountReturnsAccount(){
		Id accountId = [SELECT id FROM ACCOUNT WHERE NAME='Partner'].Id;
        User partnerUser = [SELECT id, name FROM User WHERE alias='Hath'];
        System.runAs(partnerUser){
           Id partnerAccountId = AuraStoreController.getAccountId();
           System.assertEquals(accountId, partnerAccountId);
        }  
    }
    
    @isTest
    static void addInventoryAddsToCart(){
        User partnerUser = [SELECT id, name FROM User WHERE alias='Hath'];
        Id accountId = [SELECT id FROM ACCOUNT WHERE NAME='Partner'Limit 1].Id;
        List<Inventory__c> addPurchaseOrder = [SELECT id, Ore_Type__c FROM Inventory__c WHERE status__c = 'Approved'];
        List<Purchase_Orders__c> OrdersToAdd = new List<Purchase_Orders__c>();
        for(Integer i = 0; i < addPurchaseOrder.size(); i++){
            if(Math.mod(i, 2) != 0){
            OrdersToAdd.add(new Purchase_Orders__c(Account__c = accountId, Inventory__c=addPurchaseOrder[i].Id, status__c = 'New'));
            }
        }
        insert OrdersToAdd;
        List<Inventory__c> inventoryList = [SELECT id FROM Inventory__C WHERE status__c = 'Approved'];
        List<Id> InventoryToAdd = new List<Id>();
        
        for(Inventory__c item:inventoryList){
             InventoryToAdd.add(item.Id);
       	}

        System.runAs(partnerUser){
            Test.startTest();
        	List<Integer> outOfStock = auraStoreController.addInventoryListToCart(inventoryToAdd);
            Test.stopTest();
            List<Purchase_Orders__c> newOrders = [SELECT id, Name FROM Purchase_Orders__c WHERE Account__c=:accountId];
        	system.debug(newOrders);
            system.assertEquals(12, newOrders.size());
            system.assertEquals(12, outOfStock.size());
            
            for(Integer i : outOfStock){
                system.assert(Math.mod(i, 2) != 0);
            }
        }
        
        
    }
    
    @isTest
    static void getPurchaseOrdersByTypeTest(){
        Id accountId = [SELECT id FROM ACCOUNT WHERE NAME='partner'].Id;
        User partnerUser = [SELECT id, name FROM User WHERE alias='Hath'];
        List<Inventory__c> inv = [SELECT id FROM Inventory__c WHERE Status__c='Approved'];
        List<Purchase_Orders__c> orderList = new List<Purchase_Orders__C>();
        for(Integer i = 0; i < 25; i++){
            //FIX FOR ACCOUNT WHEN LIVE
        	Purchase_Orders__c newOrder = new Purchase_Orders__c(Account__c = '0015e000005FvciAAC', Inventory__c = inv[i].id);    
            //Purchase_Orders__c newOrder = new Purchase_Orders__c(Account__c = accountId, Inventory__c = inv[i].id);    
            if(i < 8){
                newOrder.status__c = 'New';
            }
            else if(i < 16){
                newOrder.status__c = 'Pending';
            }else{
                newOrder.status__c = 'Approved';
            }
            orderList.add(newOrder);
        }
        Database.insert(orderList);
        
        System.runAs(partnerUser){
            
            Test.startTest();
            Map<String, List<Purchase_Orders__c>> orders = auraStoreController.getPurchaseOrdersByType();
            system.debug(orders);
            List<Purchase_Orders__c> newOrders = orders.get('New');
            List<Purchase_Orders__c> pendingOrders = orders.get('Pending');
        	List<Purchase_Orders__c> approvedOrders = orders.get('Approved');
            Test.stopTest();
            
            System.assertEquals(8, newOrders.size());
            System.assertEquals(8, pendingOrders.size());
            System.assertEquals(9, approvedOrders.size());        
        }
    }
    
    @isTest
    static void deletePurchaseOrderDeletes(){
        Id accountId = [SELECT id FROM ACCOUNT WHERE NAME='partner'].Id;
        User partnerUser = [SELECT id, name FROM User WHERE alias='Hath'];
        Id inv = [SELECT id FROM Inventory__c WHERE Status__c='Approved' Limit 1].Id;
        Purchase_Orders__c newOrder = new Purchase_Orders__c(Account__c = accountId, Inventory__c = inv, Status__c = 'New');
        
        System.runAs(partnerUser){
            insert newOrder;
            List<Purchase_Orders__c> newOrders = [SELECT id FROM Purchase_Orders__c];
            system.assertEquals(1, newOrders.size());
            auraStoreController.deletePurchaseOrder(newOrder.id);
            List<Purchase_Orders__c> deletedOrders = [SELECT id FROM Purchase_Orders__c];
            system.assertEquals(0, deletedOrders.size());
            
        }
        
   
        
    }
    
}