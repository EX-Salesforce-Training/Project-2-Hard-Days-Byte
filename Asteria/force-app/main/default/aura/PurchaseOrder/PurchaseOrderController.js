({
    doInit: function(component, event, helper){
      component.set("v.columns", [
          { hideDefaultActions:'true', fixedWidth: 85, label: 'Ore Type', fieldName:'Ore_Type__c'},
          { hideDefaultActions:'true', fixedWidth: 120, label: 'Mining Site', fieldName:'Mining_Site_List__c'},
          { hideDefaultActions:'true', fixedWidth: 70, label: 'Weight', fieldName:'Weight__c', type:'number'},
          { hideDefaultActions:'true', fixedWidth: 95, label: 'Item Price', fieldName:'Item_Price_Text__c'},
          { type:'button-icon', fixedWidth: 40, cellAttributes:{class:{fieldName:'iconClass'}},typeAttributes:{iconName:{fieldName:'iconName'}, variant:'bare', name:{fieldName:'buttonName'}}}
      ]);
      component.set("v.orderColumns", [
          { hideDefaultActions:'true', fixedWidth: 85, label: 'Ore Type', fieldName:'Inventory_Type__c'},
          { hideDefaultActions:'true', fixedWidth: 120, label: 'Mining Site', fieldName:'MiningSite'},
          { hideDefaultActions:'true', fixedWidth: 70, label: 'Weight', fieldName:'Inventory_Weight__c', type:'number'},
          { hideDefaultActions:'true', fixedWidth: 95, label: 'Item Price', fieldName:'ItemPrice'},
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
                	})
                    component.set("v.new", orders.New);
                }else{
                    component.set("v.new", []);
                }
                if(orders.Pending){
                	orders.Pending = orders.Pending.map(item => {
                    	item.ItemPrice = item.Inventory__r.Item_Price_Text__c;
                    	item.MiningSite = item.Inventory__r.Mining_Site_List__c;
                    	return item;
                	})
                 	component.set("v.pending", orders.Pending);
                }else{
                    component.set("v.pending", []);
                }
                if(orders.Approved){
                	orders.Approved = orders.Approved.map(item => {
                    	item.ItemPrice = item.Inventory__r.Item_Price_Text__c;
                    	item.MiningSite = item.Inventory__r.Mining_Site_List__c;
                    	return item;
                	})
                    component.set("v.approved", orders.Approved); 
                }else{
                    component.set("v.approved", []);
                }             
            }
        })
      	$A.enqueueAction(getPurchaseOrders);

    },
    
	addInventory : function(component, event, helper) {
        const eventInventory = event.getParam("inventory");
        const shoppingList = component.get("v.shoppingList");
        if(!shoppingList.some(inv => inv.Id === eventInventory.Id)){
         	eventInventory.iconName = 'utility:delete';
        	eventInventory.buttonName = 'Delete';
            eventInventory.iconClass = 'slds-current-color'
        	shoppingList.push(eventInventory);
        	component.set("v.shoppingList", shoppingList);
        }
    },
                                                
   	handleDelete : function(component, event, helper){
        console.log('hit');
    	const shoppingList = component.get('v.shoppingList');
        const action = event.getParam('action');
        const row = event.getParam('row');
        if(row.buttonName === 'Delete'){
        console.log("Hit");
        const filteredList = shoppingList.filter(inv => inv.Id !== row.Id);
        component.set('v.shoppingList', filteredList);
        let toastEvent = $A.get("e.force:showToast");
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
                    inv.iconClass = 'error';
                })
                component.set("v.shoppingList", shoppingList);
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
                    
    handleDeleteOrder : function(component, event, helper){
        console.log('hit');
     	const action = event.getParam('action');
        const row = event.getParam('row');
        console.log(action);
        console.log(row.Id);
            console.log("hit again");
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
                
            })
            $A.enqueueAction(deleteOrder);            
    },
    
   	sendOrder : function(component, event, helper){
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
            		"message":"Order Placed"
        			});
                	const updateReservations = component.getEvent("updateRes");
                    updateReservations.fire();	
           	}
    	})
        $A.enqueueAction(sendOrders);
    }
})