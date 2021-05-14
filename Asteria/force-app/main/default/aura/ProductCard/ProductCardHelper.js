({
	addInventory : function(component) {
        const inventoryEvent = $A.get("e.c:AddInventory");
        const inventory = component.get("v.item");
        inventoryEvent.setParams({"inventory" : inventory});
        inventoryEvent.fire();
	}
})