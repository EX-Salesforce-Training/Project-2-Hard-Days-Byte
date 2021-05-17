({
	FetchFAQs: function(component) {
		let action = component.get("c.getFAQs");
        action.setCallback(this, function(response){
           let state = response.getState(); 
            if (state === "SUCCESS") {
                component.set("v.faqList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	},
})