({
	save : function(component) {
        let method = component.get("c.createLeadRecord");
        method.setParams({"leadInsert":component.get("v.leadInsert")});
        method.setCallback(this,function(response){
            if(response.getState()=="SUCCESS"){
                component.set("v.isShow", false);
                let leadInsertId = response.getReturnValue();
                alert('Lead Insert ID: '+ leadInsertId);
                
                component.set("v.leadInsert.FirstName", "");
                component.set("v.leadInsert.LastName", "");
                component.set("v.leadInsert.Company", "");
                component.set("v.leadInsert.Email", "");
                component.set("v.leadInsert.Phone", "");
            }
        })
        $A.enqueueAction(method);
        
		
	}
})