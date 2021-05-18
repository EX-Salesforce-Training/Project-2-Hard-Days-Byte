({
	HandleSubmit: function(component, event, helper) {
        component.find("chatArea").getElement().innerHTML = "";
        helper.GetAnswers(component);
    }
    /*future iteration: handle multiple keywords*/
})