({
	initialize : function(component) {
		const inventory = component.get("c.getFeaturedInventory");
        inventory.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                const featuredItems = response.getReturnValue();
                component.set("v.errorMessage", "")
                component.set("v.featuredItems", featuredItems);
            }else{
                component.set("v.errorMessage", "CAREFUL INVENTORY IS NOT UP TO DATE");
            }
        });
        $A.enqueueAction(inventory);
	}
})