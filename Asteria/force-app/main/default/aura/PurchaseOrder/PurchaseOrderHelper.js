({
	initialize : function(component) {
		component.set("v.columns", [
          { hideDefaultActions:'true', label: 'Ore Type', fieldName:'Ore_Type__c'},
          { hideDefaultActions:'true', label: 'Mining Site', fieldName:'Mining_Site_List__c'},
          { hideDefaultActions:'true',  label: 'Weight', fieldName:'Weight__c', type:'number'},
          { hideDefaultActions:'true', label: 'Item Price', fieldName:'Item_Price_Text__c'},
          { type:'button-icon', fixedWidth: 40, cellAttributes:{class:{fieldName:'iconClass'}},typeAttributes:{iconName:{fieldName:'iconName'}, variant:'bare', name:{fieldName:'buttonName'}}}
      	]);
      	component.set("v.orderColumns", [
          { hideDefaultActions:'true', label: 'Ore Type', fieldName:'Inventory_Type__c'},
          { hideDefaultActions:'true', label: 'Mining Site', fieldName:'MiningSite'},
          { hideDefaultActions:'true', label: 'Weight', fieldName:'Inventory_Weight__c', type:'number'},
          { hideDefaultActions:'true', label: 'Item Price', fieldName:'ItemPrice'},
          { type:'button-icon', fixedWidth: 40, typeAttributes:{iconName:{fieldName:'iconName'}, variant:'bare', name:{fieldName:'buttonName'}}}
      	]);
      	const getPurchaseOrders = component.get("c.getPurchaseOrdersByType");
      	getPurchaseOrders.setCallback(this, function(response){
        	const state = response.getState();
            if(state === "SUCCESS"){
            	const orders = response.getReturnValue();
                if(orders.New){
                	orders.New = orders.New.map(item => {
                    	item.iconName =  "utility:delete";
                    	item.buttonName = "Delete";
                    	item.ItemPrice = item.Inventory__r.Item_Price_Text__c;
                    	item.MiningSite = item.Inventory__r.Mining_Site_List__c;
                    	return item;
                	});
                    component.set("v.new", orders.New);
                }else{
                    component.set("v.new", []);
                }
                if(orders.Pending){
                	orders.Pending = orders.Pending.map(item => {
                    	item.ItemPrice = item.Inventory__r.Item_Price_Text__c;
                    	item.MiningSite = item.Inventory__r.Mining_Site_List__c;
                    	return item;
                	});
                 	component.set("v.pending", orders.Pending);
                }else{
                    component.set("v.pending", []);
                }
                if(orders.Approved){
                	orders.Approved = orders.Approved.map(item => {
                    	item.ItemPrice = item.Inventory__r.Item_Price_Text__c;
                    	item.MiningSite = item.Inventory__r.Mining_Site_List__c;
                    	return item;
                	});
                    component.set("v.approved", orders.Approved); 
                }else{
                    component.set("v.approved", []);
                }             
            }
        })
      	$A.enqueueAction(getPurchaseOrders);
	},
    deleteCartItem : function(component, event){
        const shoppingList = component.get('v.shoppingList');
        const action = event.getParam('action');
        const row = event.getParam('row');
        if(row.buttonName === 'Delete'){
        	const filteredList = shoppingList.filter(inv => inv.Id !== row.Id);
            const updateList = $A.get("e.c:UpdateShoppingList");
            updateList.setParams({"shoppingList":filteredList});
            updateList.fire();
        	let toastEvent = $A.get("e.force:showToast");
        	toastEvent.setParams({
            	"title":"Success!",
            	"message":"Item Removed From Shopping Cart"
        	});
        	toastEvent.fire();
  
        }
    },
    saveOrder : function(component){
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
                    inv.iconClass = 'error';
                })
                const updateList = $A.get("e.c:UpdateShoppingList");
            	updateList.setParams({"shoppingList":shoppingList});
            	updateList.fire();
                const updateInventory = $A.get('e.c:UpdateInventory');
                updateInventory.fire();
                const updateReservations = component.getEvent("updateRes");
                updateReservations.fire();
                const updateFeatured = $A.get("e.c:UpdateFeaturedItems");
                updateFeatured.fire();
            }
        })
        $A.enqueueAction(newOrder);                        
    },
    
    deleteOrder : function(component, event){
    	const action = event.getParam('action');
        const row = event.getParam('row');
        const deleteOrder = component.get("c.deletePurchaseOrder");
        deleteOrder.setParams({"order":row.Id});
        deleteOrder.setCallback(this, function(response){
        	const state = response.getState();
        	if(state === "SUCCESS"){
        		let toastEvent = $A.get("e.force:showToast");
        		toastEvent.setParams({
           			"title":"Success!",
           			"message":"Order Removed From Reservations"
        		});
        		toastEvent.fire();
            	const updateReservations = component.getEvent("updateRes");
            	updateReservations.fire();
            	const updateInventory = $A.get('e.c:UpdateInventory');
            	updateInventory.fire();
            	const updateFeatured = $A.get("e.c:UpdateFeaturedItems");
            	updateFeatured.fire();
        	}    
    	});   
        $A.enqueueAction(deleteOrder);                     
    },
    placeOrder : function(component){
    	let newOrders = component.get("v.new");
        newOrders = newOrders.map(order => order.Id);
        const sendOrders = component.get("c.sendNewOrders");
        sendOrders.setParams({"newOrders" : newOrders});
        sendOrders.setCallback(this, function(response){
        	const state = response.getState();
            if(state === 'SUCCESS'){
            	let toastEvent = $A.get("e.force:showToast");
        		toastEvent.setParams({
            		"title":"Success!",
                    "type": "success",
            		"message":"Order Placed"
        		});
                toastEvent.fire();
                const updateReservations = component.getEvent("updateRes");
                updateReservations.fire();	
           	}
    	})
        $A.enqueueAction(sendOrders);                    
    }
})