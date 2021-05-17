({
    getLogged: function(component) {
        let action = component.get("c.getLogged");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let logged = response.getReturnValue();
                component.set("v.isLogged", logged);
                if (logged) {
                    component.set("v.currentPage", "Homepage");
                } else {
                    component.set("v.currentPage", "Landing");
                }
                return logged;
            }
        });
        $A.enqueueAction(action);
    }
})