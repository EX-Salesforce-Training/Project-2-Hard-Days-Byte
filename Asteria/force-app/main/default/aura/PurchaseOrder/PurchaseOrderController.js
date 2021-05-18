({
    doInit: function(component, event, helper){
      console.log(component.get("v.shoppingList"));
      helper.initialize(component);
    },
    
	addInventory : function(component, event, helper) {
       helper.addInventory(component, event);
    },
                                                
   	handleDelete : function(component, event, helper){
    	helper.deleteCartItem(component, event);
    },
    
    saveInventory : function(component, event, helper){
        helper.saveOrder(component);
    },
                    
    handleDeleteOrder : function(component, event, helper){
     	helper.deleteOrder(component, event);           
    },
    
   	sendOrder : function(component, event, helper){
   		helper.placeOrder(component);
    }
})