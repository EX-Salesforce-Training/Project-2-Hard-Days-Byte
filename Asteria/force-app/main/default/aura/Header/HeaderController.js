({
	doInit : function(component, event, helper) {
		component.set("v.quote", helper.generateQuote());
	}
})