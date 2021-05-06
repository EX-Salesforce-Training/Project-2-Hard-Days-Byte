///////////////////////////////////////////////////////////////
//
// Name: PurchaseOrderCheckoutController
// Author: Nate Farrey
// Created: 04/30/2021
// Updated: 05/04/2021
// Description: On the checkout page, users will review their cart and submit items for purchase
//
///////////////////////////////////////////////////////////////

public without sharing class PurchaseOrderCheckoutController {
    
    public ApexPages.StandardSetController purchaseOrderSetController {
        get {
            if(purchaseOrderSetController == null) {
                // User the user class to get the ID of the logged in user
                id userId = UserInfo.getUserId();
                // Use the Id to get AccountId from the actual user object
                User u = [SELECT AccountId, contactId FROM User WHERE id = :userId];
                id acct = u.AccountId;
                
                // Create a custom Set Controller for only specific Purchase Orders (New and Related to our account)
                purchaseOrderSetController = new ApexPages.StandardSetController(Database.getQueryLocator(
                    // User the account ID to get purchase orders related to the account
                    [SELECT Id, Name, Account__c, Inventory__c, Inventory_Type__c, Inventory_Weight__c, Status__c FROM Purchase_Orders__c WHERE Status__c = 'New'AND Account__c = :acct ]
                ));
            }
            return purchaseOrderSetController;
        }
        set;
    }

    public List<Purchase_Orders__c> getPurchaseOrders() {
        // Get method called with {!PurchaseOrders}
        return (List<Purchase_Orders__c>) purchaseOrderSetController.getRecords();
    }

    public PageReference submitOrder(){
        // Retrieve New purchase orders
        List<Purchase_Orders__c> updateList = purchaseOrderSetController.getRecords();

        // Change Purchase order status to pending, a manager will approve in the org
        for(Purchase_Orders__c o: updateList){
            o.status__c = 'Pending';
        }

        // Update adjusted Purchase order records
        update updateList;

        // Redirect to account orders page
        PageReference page = System.Page.AccountViewEdit;
        page.setRedirect(true);
        return page;

    }
}