public class orderNewCrewHandler{
    public void triggerMethodM(){
               
/*        List<Crew_Members__c> triggerList = new List<Crew_Members__c>();
          for(Crew_Members__c c :(List<Crew_Members__c>)Trigger.old){
            triggerList.add(c);}
       
        List<Crew_Members__c> triggerList2 = [SELECT ID,Name,Designation__c,Crew_List__c,DNA_Test__c 
                                              FROM Crew_Members__c WHERE ID IN :TriggerList];*/
                
        List<Crew_Members__c> insertList = new List<Crew_Members__c>();
        for(Crew_Members__c x :(List<Crew_Members__c>)Trigger.old){
            Crew_Members__c newCrew = New Crew_Members__c();
            newCrew.Designation__c = x.Designation__c;
            newCrew.Crew_List__c = x.Crew_List__c;
            newCrew.Name = 'Armstrong';
            newCrew.DNA_Test__c = FALSE;
            insertList.add(newCrew);
         }
        system.debug(insertList);
        insert insertList;
        
        List<Crew_Members__c> crewList2 = [SELECT Name,Crew_Member_ID__c FROM Crew_Members__c 
                                            ORDER BY CreatedDate DESC LIMIT 1];
        system.debug(crewList2);
        for(Crew_Members__c c : crewList2){
            c.Name = 'Armstrong ' + c.Crew_Member_ID__c;
        }
        update crewList2;	       
	}   
        
    
        

        
    
    
    
    
    
    
        //Map<String,Crew_Members__c> triggerMap = new Map<String,Crew_Members__c>();
    
    
    
        
        
        
        
        
        
        
        
       /*
      for(Crew_Members__c triggerVar : [SELECT ID,Name,Designation__c,Crew_List__c FROM Crew_Members__c WHERE ID IN :Trigger.old])
        {
            
            
        }
                                          
        


    
    
    //to use this code, Execute Anonymous the following:
    //	CrewOnboarding.orderMiningCrew(#,'SQUAD');    
    //Valid squadAssignmentM values: 'ALPHA','BETA','GAMMA','DELTA','EPSILON','ZETA'
    
    public static void orderMiningCrew(Integer numOfCrewM, String squadAssignmentM){
		List<Crew_Members__c> crewListM = new List<Crew_Members__c>();
        
    //Create # of Mining Crew Members equal to input
        for(Integer i = 1; i <= numOfCrewM; i++){
            Crew_Members__c c = new Crew_Members__c();
            c.Name = 'Armstrong';
            c.Designation__c = 'Mining';
            c.Crew_List__c = squadAssignmentM;
            crewListM.add(c);
        }
        system.debug(crewListM);
		insert crewListM;
        List<Crew_Members__c> crewListM2 = [SELECT Name,Crew_Member_ID__c FROM Crew_Members__c 
                                            WHERE Name LIKE 'Armstron%'];
        for(Crew_Members__c c : crewListM2){
            c.Name = 'Armstrong ' + c.Crew_Member_ID__c;
        }
        update crewListM2;
    }
    
    
    
    
    
    
    //to use this code, Execute Anonymous the following:
    //	CrewOnboarding.orderSecurityCrew(#,'SQUAD');
    
    //Valid squadAssignmentS values: 'ALPHA','BETA','GAMMA','DELTA','EPSILON','ZETA'
    
    public static void orderSecurityCrew(Integer numOfCrewS, String squadAssignmentS){
		List<Crew_Members__c> crewListS = new List<Crew_Members__c>();
        
    //Create # of Security Crew Members equal to input
        for(Integer i = 1; i <= numOfCrewS; i++){
            Crew_Members__c c = new Crew_Members__c();
            c.Name = 'Aldrin';
            c.Designation__c = 'Security';
            c.Crew_List__c = squadAssignmentS;
            crewListS.add(c);
        }
        system.debug(crewListS);
		insert crewListS;
        List<Crew_Members__c> crewListS2 = [SELECT Name,Crew_Member_ID__c FROM Crew_Members__c 
                                            WHERE Name LIKE 'Aldri%'];
        for(Crew_Members__c c : crewListS2){
            c.Name = 'Aldrin ' + c.Crew_Member_ID__c;
        }
        update crewListS2;
	}
  */  
}