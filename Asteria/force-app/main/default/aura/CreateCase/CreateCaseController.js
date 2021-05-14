({
    doInit: function(component, event, helper) {
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
    ShowModal: function(component, event, helper) {
        component.set("v.isOpen", true);
    },
    CloseModal: function(component, event, helper) {
        component.set("v.isOpen", false);
        component.set("v.newCase", {'sobjectType': 'Case',
                                                        'Origin': 'Web',
                                                        'Product__c': '',
                                                        'Type': '',
                                                        'Reason': '',
                                                        'Subject': '',
                                                        'Description': ''});
    },
    SaveModal: function(component, event, helper) {
        let validCase = component.find("caseForm").reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get("v.validity").valid;
        }, true);
        if(validCase) {
            let newCase = component.get("v.newCase");
            console.log("Create case: " + JSON.stringify(newCase));
            helper.createCase(component, newCase);
            component.set("v.isOpen", false);
            component.set("v.newCase", {'sobjectType': 'Case',
                                                        'Origin': 'Web',
                                                        'Product__c': '',
                                                        'Type': '',
                                                        'Reason': '',
                                                        'Subject': '',
                                                        'Description': ''});
        }
    },
})