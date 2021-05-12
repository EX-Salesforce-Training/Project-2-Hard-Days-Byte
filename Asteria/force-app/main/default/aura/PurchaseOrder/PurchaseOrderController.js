({
    doInit: function(component, event, helper){
      component.set("v.columns", [
          { hideDefaultActions:'true', fixedWidth: 100, label: 'Ore Type', fieldName:'Ore_Type__c'},
          { hideDefaultActions:'true', fixedWidth: 150, label: 'Mining Site', fieldName:'Mining_Site_List__c'},
          { hideDefaultActions:'true', fixedWidth: 90, label: 'Weight', fieldName:'Weight__c', type:'number'},
          { hideDefaultActions:'true', fixedWidth: 115, label: 'Item Price', fieldName:'Item_Price_Text__c'},
          { type:'button-icon', fixedWidth: 40, typeAttributes:{iconName:{fieldName:'iconName'}, variant:'bare', name:{fieldName:'buttonName'}}}
      ]);
      component.set("v.orderColumns", [
          { hideDefaultActions:'true', fixedWidth: 100, label: 'Ore Type', fieldName:'Ore_Type__c'},
          { hideDefaultActions:'true', fixedWidth: 150, label: 'Mining Site', fieldName:'Mining_Site_List__c'},
          { hideDefaultActions:'true', fixedWidth: 90, label: 'Weight', fieldName:'Weight__c', type:'number'},
          { hideDefaultActions:'true', fixedWidth: 115, label: 'Item Price', fieldName:'Item_Price_Text__c'},
          { type:'button-icon', fixedWidth: 40, typeAttributes:{iconName:{fieldName:'iconName'}, variant:'bare', name:{fieldName:'buttonName'}}}
      ]);
      const columns = component.get("v.columns");
      component.set("v.shoppingList", []);
      component.set("v.new", []);
 	  component.set("v.pending", []);
 	  component.set("v.approved", []);

    },
    
	addInventory : function(component, event, helper) {
        const eventInventory = event.getParam("inventory");
        const shoppingList = component.get("v.shoppingList");
        if(!shoppingList.some(inv => inv.Id === eventInventory.Id)){
         	eventInventory.iconName = 'utility:delete';
        	eventInventory.buttonName = 'Delete';
        	shoppingList.push(eventInventory);
        	console.log(shoppingList[0].Ore_Type__c);
        	component.set("v.shoppingList", shoppingList);
        }
    },
                                                
   	handleDelete : function(component, event, helper){
    	const shoppingList = component.get('v.shoppingList');
        console.log(shoppingList);
        const action = event.getParam('action');
        const row = event.getParam('row');
        if(action.Name === 'Delete'){
        const filteredList = shoppingList.filter(inv => inv.Id !== row.Id);
        component.set('v.shoppingList', filteredList);
        let toastEvent = $A.get("e.force:showToast");
        console.log(toastEvent);
        toastEvent.setParams({
            "title":"Success!",
            "message":"Item Removed From Shopping Cart"
        });
        toastEvent.fire();
        }
    },
    
    saveInventory : function(component, event, helper){
        let shoppingList = component.get("v.shoppingList");
        const cartIds = component.get("v.shoppingList").map(inv=>inv.Id);
        const newOrder = component.get("c.addInventoryListToCart");
        newOrder.setParams({"inventoryList":cartIds});
        
        newOrder.setCallback(this, function(response){
            const state = response.getState();
            console.log(state);
            if(state === "SUCCESS"){
                const outOfStock = response.getReturnValue();
                shoppingList = shoppingList.filter((inv, idx) => outOfStock.includes(idx));
                shoppingList.forEach(inv => {
                    inv.iconName = 'utility:error';
                	inv.buttonName = 'Error';
                })
                component.set("v.shoppingList", shoppingList);
                    const updateInventory = $A.get('e.c:UpdateInventory');
                updateInventory.fire();
            }
        })
        $A.enqueueAction(newOrder);
    }
})