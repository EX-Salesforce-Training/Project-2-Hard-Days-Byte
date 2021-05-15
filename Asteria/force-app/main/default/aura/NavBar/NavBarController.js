({
	doInit: function(component, event, helper) {
		helper.isLogged(component);
	},
    handleClick: function(component, event, helper) {
        let source = event.target.innerHTML;
        let logged = component.get("v.isLogged");
        console.log("handleClick - logged: " + logged);
        if (source == "Home" && logged) {
            source = "Homepage";
        } else if (source == "Home" && !logged) {
            source = "Landing";
        }
        console.log("handleClick - source: " + source);
        let createEvent = component.getEvent("SendCurrentPage");
        createEvent.setParams({"currentPage": source});
        createEvent.fire();
    }
})