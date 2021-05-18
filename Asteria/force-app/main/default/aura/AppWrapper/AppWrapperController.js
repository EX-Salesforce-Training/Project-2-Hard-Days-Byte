({
    doInit: function(component, event, helper) {
        helper.getLogged(component);
    },
	handleCurrentPage: function(component, event, helper) {
        let currentPage = event.getParam("currentPage");
        component.set("v.currentPage", currentPage);
	},
    addToShoppingList: function(component, event, helper){
        helper.addInventory(component, event);
    },
    updateShoppingList: function(component, event, helper){
        helper.setShoppingList(component, event);
    }
})