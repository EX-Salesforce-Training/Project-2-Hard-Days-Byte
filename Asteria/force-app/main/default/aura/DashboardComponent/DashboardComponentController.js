({
	myAction : function(component, event, helper) {
		console.log("action called");
		let currentUser = component.get("c.getDashboardID");
        console.log(currentUser);
        currentUser.setCallback(this, function(response){
            console.log(response.getState());
            if(response.getState() == "SUCCESS"){
                console.log("successful response");
                component.set("v.dashboardID", response.getReturnValue()); 
                component.set("v.gotDashboardID", "True");
                console.log(response.getReturnValue());
            }
        })
        $A.enqueueAction(currentUser);
        console.log("enqueued");
	}
})