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
})