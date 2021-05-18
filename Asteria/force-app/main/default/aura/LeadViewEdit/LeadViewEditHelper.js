({
	getData : function(component) {
        let method = component.get('c.getLeads');
        method.setCallback(this,function(response) {
           if(response.getState()=="SUCCESS"){
                component.set('v.mydata', response.getReturnValue());
            } else if (response.getState() === "ERROR") {
                var errors = response.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(method);
    },
    
    /*saveHelp : function(component, event){
        let draftValues = event.getParam('draftValues');
        console.log(draftValues);
        let method = component.get('c.updateLeadEdit');
        method.setParams({"editLeadList":draftValues});
        method.setCallback(this,function(response) {
           console.log(response.getState());
            if(response.getState()=="SUCCESS"){
               let res = response.getReturnValue();
               console.log(res);
               $A.get('e.force:refreshView').fire();
               alert('Updated Successfully!');
               //component.set('v.mydata', response.getReturnValue());
            } else if (response.getState() === "ERROR") {
                var errors = response.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(method);
    }*/
});