({
	payment : function(component, event, helper) {
        console.log("action called");
		let currentUser = component.get("c.runAsPartnerPayment");
        console.log(currentUser);
        currentUser.setCallback(this, function(response){
            console.log(response.getState());
            if(response.getState() == "SUCCESS"){
                console.log("successful response");
                component.set("v.AccountPaymentID", response.getReturnValue()); 
                component.set("v.gotPayment", "True");
                console.log(response.getReturnValue());
            }
        })
        $A.enqueueAction(currentUser);
        console.log("enqueued");
	}
})