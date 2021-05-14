({
	initialize : function(component) {
		const inventory = component.get("c.getInventoryList");
        inventory.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                const inventoryList = response.getReturnValue();
                component.set("v.errorMessage", "");
                component.set("v.inventory", inventoryList);
            }else{
                component.set("v.errorMessage", "CAREFUL INVENTORY IS NOT UP TO DATE");
            }
        });
        $A.enqueueAction(inventory);
	}
})