({
    isLogged: function(component) {
        let action = component.get("c.getLogged");
        action.setCallback(this, function(response) {
            let state = response.getState();
            console.log(state);
            if (state === "SUCCESS") {
               
                let logged = response.getReturnValue();
                component.set("v.isLogged", logged);
                console.log(logged);
            }
        });
        $A.enqueueAction(action);
    }
})