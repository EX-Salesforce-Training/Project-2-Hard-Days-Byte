({
	FetchCases: function(component) {
		let action = component.get("c.getCases");
        action.setCallback(this, function(response){
           let state = response.getState(); 
            if (state === "SUCCESS") {
                component.set("v.caseList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	},
    FetchAllCases: function(component) {
		let action = component.get("c.getAllCases");
        action.setCallback(this, function(response){
           let state = response.getState(); 
            if (state === "SUCCESS") {
                component.set("v.allCases", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	},
})