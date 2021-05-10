({
	save : function(component) {
        let method = component.get("c.createLeadRecord");
        method.setParams({"leadInsert":component.get("v.leadInsert")});
        method.setCallback(this,function(response){
            if(response.getState()=="SUCCESS"){
                component.set("v.isShow", false);
                let leadInsertId = response.getReturnValue();
                alert('Lead Insert ID: '+ leadInsertId);
            }
        })
        $A.enqueueAction(method);
		
	}
})