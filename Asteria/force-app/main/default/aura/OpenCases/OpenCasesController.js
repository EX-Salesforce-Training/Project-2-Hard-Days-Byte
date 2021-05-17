({
	DoInit: function(component, event, helper) {
		helper.FetchCases(component);
        helper.FetchAllCases(component);
	},
    ShowModal: function(component, event, helper) {
        component.set("v.isOpen", true);
    },
    CloseModal: function(component, event, helper) {
        component.set("v.isOpen", false);
    },
    UpdateCases: function(component, event, helper) {
        helper.FetchCases(component);
        helper.FetchAllCases(component);
    }
})