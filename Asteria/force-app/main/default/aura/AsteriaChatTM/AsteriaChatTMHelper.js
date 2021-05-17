({
    getAnswers: function(component) {
        const userInput = component.get("v.userInput");
        console.log(userInput);
        
        let action = component.get("c.getChat");
        action.setParams({"custQuery":userInput});
        action.setCallback(this,function(response) {
            let state = response.getState();
            console.log(state);
            if(state === "SUCCESS") {
                let answers = response.getReturnValue();
                console.log(answers);
                component.set("v.spinner", true);
                
                let chatboxOld;
                setTimeout(function(){
                    component.set("v.spinner", false);
                    component.find("chatArea").getElement().innerHTML = "";
                    for (let x of answers) {
                        let pair = x.split('§');
                        
                        chatboxOld = component.find("chatArea").getElement().innerHTML;
                        component.find("chatArea").getElement().innerHTML = chatboxOld + "<tr><td class=\"qTD\">" + pair[0] + "</td></tr>" +
                            "<tr><td class=\"aTD\">" + pair[1] + "</td></tr>";
                    }},1500);
            }
        });
        $A.enqueueAction(action);
    }
})