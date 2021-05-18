({
    isLogged: function(component) {
        let action = component.get("c.getLogged");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let logged = response.getReturnValue();
                console.log("getLogged: " + logged);
                component.set("v.isLogged", logged);
            }
        });
        $A.enqueueAction(action);
    }
})