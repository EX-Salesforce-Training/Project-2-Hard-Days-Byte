({
	myAction : function(component, event, helper) {
        console.log("action called");
		let currentUser = component.get("c.runAsPartner");
        console.log(currentUser);
        currentUser.setCallback(this, function(response){
            console.log(response.getState());
            if(response.getState() == "SUCCESS"){
                console.log("successful response");
                component.set("v.AccountID", response.getReturnValue()); 
                component.set("v.gotAccount", "True");
                console.log(response.getReturnValue());
            }
        })
        $A.enqueueAction(currentUser);
        console.log("enqueued");
	}
})