@isTest public with sharing class ShopAsteriaControllerTest {
    @isTest (SeeAllData=true) public static void ShopAsteriaControllerTest() {
        User testUser = [SELECT Id, AccountId FROM User WHERE alias = 'ayoun'];

        
        Inventory__c inventory = new Inventory__c(
            Ore_Type__c = 'Gold',
            Weight__c = 300,
            Mining_Site_List__c = 'Helicaon (30942)',
            Status__c ='Approved');

            insert inventory;

            // Retrieve the newly created inventory item
            Inventory__c newItem = [SELECT id FROM Inventory__c WHERE Ore_Type__c = 'Gold' AND Weight__c = 300 AND Status__c = 'Approved' LIMIT 1];

            Purchase_Orders__c testAgainst = new Purchase_Orders__c(
            Account__c = testUser.AccountId,
            Inventory__c= newItem.id
        );

        System.runAs(testUser){
            ShopAsteriaController controller = new ShopAsteriaController();
            String id = controller.setInvItem(newItem.id);
            PageReference page = controller.addToCart();
            system.debug(id);
            system.debug(testAgainst);
            PurchaseOrderCheckoutController purchaseOrderController = new PurchaseOrderCheckoutController();
            List<Purchase_Orders__c> testThis = purchaseOrderController.getPurchaseOrders();
            
            system.debug(testThis);
            system.assertEquals(testAgainst.Inventory__c,testThis[0].Inventory__c);
        }
    }
}