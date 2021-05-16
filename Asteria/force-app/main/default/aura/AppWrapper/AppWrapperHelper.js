({
    initialize:function(component){
        const currentPage =component.get("c.getLogged");
        currentPage.setCallback(this,function(response){
            const state = response.getState();
            console.log(state);
            if(state=="SUCCESS"){
                const isLogged = response.getReturnValue();
                
                if(isLogged){
                    component.set("v.currentPage", "Homepage");
                } 
                else{
                    component.set("v.currentPage", "Landing");
                }
            }
            
        });
        $A.enqueueAction(currentPage);
        
    },
	helperMethod : function() {
		
	}
})