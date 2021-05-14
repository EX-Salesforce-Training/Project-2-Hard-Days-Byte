public without sharing class AccountAddressesController {

    
    
  public ApexPages.StandardSetController AccountSetController {
        get {
            if(AccountSetController == null) {
                // User the user class to get the ID of the logged in user
                id userId = UserInfo.getUserId();
                // Use the Id to get AccountId from the actual user object
                User u = [SELECT AccountId, contactId FROM User WHERE id = :userId];
                id acct = u.AccountId;
                
                // Create a custom Set Controller for only specific Purchase Orders (New and Related to our account)
                AccountSetController = new ApexPages.StandardSetController(Database.getQueryLocator(
                    // User the account ID to get purchase orders related to the account
                    [SELECT Id, Name, BillingCountry, BillingPostalCode, BillingState, BillingCity, BillingStreet, BillingLatitude, BillingLongitude FROM Account WHERE id = :acct]
                ));
            }
            return AccountSetController;
        }
        set;
    }
    
  public List<Account> getAccount() {
        // Get method called with {!PurchaseOrders}
        return (List<Account>) AccountSetController.getRecords();
    }

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
                  [SELECT Id, Name, Account__c, Inventory__c, Inventory_Type__c, Inventory_Weight__c, Status__c FROM Purchase_Orders__c WHERE (Status__c = 'Pending'OR Status__c = 'Approved') AND Account__c = :acct]
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


}