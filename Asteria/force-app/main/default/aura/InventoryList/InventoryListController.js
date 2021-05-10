({
	doInit : function(component, event, helper) {
		const inventory = component.get("c.getInventoryList");
        inventory.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                const inventoryList = response.getReturnValue();
                component.set("v.inventory", inventoryList);
                console.log(component.get("v.inventory"));
            }else{
                console.log("Test Failed");
            }
        });
        $A.enqueueAction(inventory);
	}
})