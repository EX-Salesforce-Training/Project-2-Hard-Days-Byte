({
	handleCurrentPage: function(component, event, helper) {
        let currentPage = event.getParam("currentPage");
        component.set("v.currentPage", currentPage);
	}
})