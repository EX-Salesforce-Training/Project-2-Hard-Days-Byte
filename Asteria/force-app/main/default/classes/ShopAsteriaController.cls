public without sharing class ShopAsteriaController{
    
  // The extension constructor initializes the private member
  // variable inv by using the getRecord method from the standard controller
  public id invItem {get;set;}
  
  public id setInvItem(id newId){
      this.invItem = newId;
      return this.invItem;
  }
  
  private final Inventory__c inv;
  public ShopAsteriaController(){
      getInventoryList();
  }
  
  //When you click the Inventory item name (auto-number) in the ShopAsteria page, this code gathers
  //the record ID of the item you clicked, as well as the Account ID of the context user, and passes them
  //to the CheckoutPage
  public PageReference addToCart(){       
      id userId = UserInfo.getUserId();
      User u = [SELECT AccountId, contactId FROM User WHERE id = :userId];
      id acct = u.accountId;
      Purchase_Orders__c pOrder = new Purchase_Orders__c(
          Account__c = acct,
          Inventory__c = this.invItem);
      insert pOrder;                
      PageReference page = System.Page.checkoutPage;
      page.setRedirect(true);
      return page;
  }
  
  // This code selects fields and creates a list from Inventory__c items where:
  // The Inventory record has been approved &
  // There are no pending purchase orders on the item.
  public static List<Inventory__c> getInventoryList(){
      List<Inventory__c> availableInventoryList = 
          [SELECT Name,Ore_Type__c,Weight__c,Item_Price_Text__c FROM Inventory__c 
           WHERE Status__c='Approved' AND Number_of_Orders__c=0 ORDER BY Item_Price__c ASC];
      return availableInventoryList;
  }
  
  
  
  
  
  // * This code is supposed to dynamically pass in the image for 
  // * each item in the ShopAsteria inventory list;
  // * I never got it to work.
  // 
  /*	public static String getItemImg(Inventory__c item){
string itemImg = apexpages.currentpage().getparameters().get('myParam'); 
String itemImg = '';           
if(item.Ore_Type__c=='Gold'){
itemImg ='Gold_Ore.png';
}else if(item.Ore_Type__c=='Diamond'){
itemImg ='Diamond_Ore.png';
}else if(item.Ore_Type__c=='Silver'){
itemImg ='Silver_Ore.png';
}else if(item.Ore_Type__c=='Iridium'){
itemImg ='Iridium_Ore.png';
}else if(item.Ore_Type__c=='Platinum'){
itemImg ='Platinum_Ore.png';
}else if(item.Ore_Type__c=='Palladium'){
itemImg ='Palladium_Ore.png';
}else{
itemImg ='Rhodium_Ore.png';
}
return ItemImg;
}
*/
}

/*
public Component.Apex.Image getItemImg(){  
        System.debug(var1);
        String itemImg = '';  
          Component.Apex.Image returnItemImg = new Component.Apex.Image();
      returnItemImg.value = itemImg;            
            if(var1=='Gold'){
      itemImg ='Gold_Ore.png';
      }else if(var1=='Diamond'){
            itemImg ='Diamond_Ore.png';
      }else if(var1=='Silver'){
      itemImg ='Silver_Ore.png';
      }else if(var1=='Iridium'){
      itemImg ='Iridium_Ore.png';
      }else if(var1=='Platinum'){
      itemImg ='Platinum_Ore.png';
      }else if(var1=='Palladium'){
      itemImg ='Palladium_Ore.png';
      }else{
      itemImg ='Rhodium_Ore.png';
      }
              return returnItemImg;
      }	
*/