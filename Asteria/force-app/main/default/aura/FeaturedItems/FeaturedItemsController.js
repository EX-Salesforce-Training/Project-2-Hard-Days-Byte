({
	doInit : function(component, event, helper) {
		const inventory = component.get("c.getFeaturedInventory");
        inventory.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                const featuredItems = response.getReturnValue();
                component.set("v.featuredItems", featuredItems);
            }else{
                console.log("Test Failed");
            }
        });
        $A.enqueueAction(inventory);
	}
})