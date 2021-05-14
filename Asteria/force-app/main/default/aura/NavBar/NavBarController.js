({
	doInit: function(component, event, helper) {
		component.set("v.isLogged", helper.isLogged(component));
	},
    handleClick: function(component, event, helper) {
        let source = event.target.innerHTML;
        let logged = helper.isLogged(component);
        if (source == "Home" && logged) {
            source = "Homepage";
        } else if (source == "Home" && !logged) {
            source = "Landing";
        }
        let createEvent = component.getEvent("SendCurrentPage");
        createEvent.setParams({"currentPage": source});
        createEvent.fire();
    }
})