({
	doInit: function(component, event, helper) {
		let y = helper.getCopyright();
        component.set("v.year", y);
	}
})