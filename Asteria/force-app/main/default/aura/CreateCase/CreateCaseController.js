({
    doInit: function(component, event, helper) {
        helper.handleInit(component);
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
        helper.handleSave(component);
    }
})