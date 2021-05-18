({
    getLogged: function(component) {
        let action = component.get("c.getLogged");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let logged = response.getReturnValue();
                component.set("v.isLogged", logged);
                if (logged) {
                    component.set("v.currentPage", "Homepage");
                } else {
                    component.set("v.currentPage", "Landing");
                }
                return logged;
            }
        });
        $A.enqueueAction(action);
    },
    addInventory: function(component, event){
        console.log("hit AppWrapper List");
        const eventInventory = event.getParam("inventory");
        const shoppingList = component.get("v.shoppingList");
        if(!shoppingList.some(inv => inv.Id === eventInventory.Id)){
         	eventInventory.iconName = 'utility:delete';
        	eventInventory.buttonName = 'Delete';
            eventInventory.iconClass = 'black'
        	shoppingList.push(eventInventory);
			component.set("v.shoppingList", shoppingList);
        }else{
            let toastEvent = $A.get("e.force:showToast");
        	toastEvent.setParams({
            	"title":"Error",
                "type":"error",
            	"message":"Item already added to Cart!"
        	});
        	toastEvent.fire();
    	}
    },
    setShoppingList:function(component, event){
        const shoppingList = event.getParam("shoppingList");
        component.set("v.shoppingList", shoppingList);
    }
    
})