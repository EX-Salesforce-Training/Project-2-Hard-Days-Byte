({
	createCase: function(component, newCase) {
        console.log("in helper.CREATECASE function");
		let action = component.get("c.saveCase");
        action.setParams({"newCase":newCase});
        action.setCallback(this, function(response){
            let state = response.getState();
            console.log(response);
            if (state === "SUCCESS") {
                console.log("Success! New Case created: " + JSON.stringify(newCase));
            }
        });
        $A.enqueueAction(action);
	}
})