({
    isLogged: function(component) {
        let action = component.get("c.getLogged");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let logged = response.getReturnValue();
                return logged;
            }
        });
        $A.enqueueAction(action);
    }
})