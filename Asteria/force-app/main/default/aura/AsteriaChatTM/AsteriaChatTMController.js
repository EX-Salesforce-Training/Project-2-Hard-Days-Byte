({
	handleSubmit: function(component, event, helper) {
		console.log("component.getElements(): ", component.getElements());
        // access the DOM in c:domLocker
        let chatboxOld = component.find("chatArea").getElement().innerHTML;
        console.log(component.find("chatArea").getElement().innerHTML);
        component.find("chatArea").getElement().innerHTML = chatboxOld + "<tr><td class=\"qTD\">Sample Question</td></tr>" +
            "<tr><td class=\"aTD\">Sample Answer</td></tr>";
	}
})