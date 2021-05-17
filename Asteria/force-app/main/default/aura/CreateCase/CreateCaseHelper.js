({
    handleInit: function(component) {
        let action = component.get("c.getInitialValues");
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                let valuesMap = response.getReturnValue();
                component.set("v.userName",valuesMap["UserName"][0]);
                component.set("v.productValues",valuesMap["Product__c"]);
                component.set("v.typeValues",valuesMap["Type"]);
                component.set("v.reasonValues",valuesMap["Reason"]);
            }
        });
        $A.enqueueAction(action);
    },
    handleSave: function(component) {
        console.log("in helper.CREATECASE function");
        let validCase = component.find("caseForm").reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get("v.validity").valid;
        }, true);
        if(validCase) {
            let action = component.get("c.saveCase");
            let newCase = component.get("v.newCase");
            console.log("Create case: " + JSON.stringify(newCase));
            action.setParams({"newCase":newCase});
            action.setCallback(this, function(response){
                let state = response.getState();
                console.log(response);
                if (state === "SUCCESS") {
                    console.log("Success! New Case created: " + JSON.stringify(response.getReturnValue()));
                    component.set("v.isOpen", false);
                    component.set("v.newCase", {'sobjectType': 'Case',
                                                'Origin': 'Web',
                                                'Product__c': '',
                                                'Type': '',
                                                'Reason': '',
                                                'Subject': '',
                                                'Description': ''});
                }
            });
            $A.enqueueAction(action);
        }
    }
})