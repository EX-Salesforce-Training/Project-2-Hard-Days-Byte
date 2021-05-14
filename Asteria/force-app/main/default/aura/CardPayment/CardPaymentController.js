({
	payment: function(component, event, helper) {
        console.log("action called");
		let currentUserPayment = component.get("c.getAccountPayment");
        console.log(currentUserPayment); 
        currentUserPayment.setCallback(this, function(response){
            console.log(response.getState());
            if(response.getState() == "SUCCESS"){
                console.log("successful response");
                component.set("v.AccountPaymentID", response.getReturnValue()); 
                component.set("v.gotPayment", "True");
                console.log(response.getReturnValue());
            }
        })
        $A.enqueueAction(currentUserPayment);
        console.log("enqueued");
	}
})