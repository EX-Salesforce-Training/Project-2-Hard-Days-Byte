({
	addInventory : function(component, event, helper) {
        console.log("Button hit event");
        const inventoryEvent = $A.get("e.c:AddInventory");
        const inventory = component.get("v.item");
        inventoryEvent.setParams({"inventory" : inventory});
        inventoryEvent.fire();
	}
})