({
	init: function (component, event, helper) {
        component.set('v.mycolumns', [
            //{ label: 'First Name', fieldName: 'FirstName', type: 'text', editable: true},
            //{ label: 'Last Name', fieldName: 'LastName', type: 'text', editable: true},
            { label: 'Lead Name', fieldName: 'Name', type: 'text', editable: true},
            { label: 'Company', fieldName: 'Company', type: 'text', editable: true},
            { label: 'Email', fieldName: 'Email', type: 'email', editable: true},
            { label: 'Phone', fieldName: 'Phone', type: 'phone', editable: true}
        ]);
        helper.getData(component);
    },
    handleSave: function (component, event, helper) {
        //component.set('v.saveDraftValues', event.getParam('draftValues'));
        //let draftValues = event.getParam('draftValues');
        helper.saveHelp(component, event);
    }
})