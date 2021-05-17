({
    handleSubmit: function(component, event, helper) {
        component.find("chatArea").getElement().innerHTML = "";
        helper.getAnswers(component);
    }
    /*future iteration: handle multiple keywords*/
})