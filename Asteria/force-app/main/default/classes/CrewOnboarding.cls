public class CrewOnboarding{
    
    
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
            c.Name = 'Armstrong';
            c.Designation__c = 'Security';
            c.Crew_List__c = squadAssignmentS;
            crewListS.add(c);
        }
        system.debug(crewListS);
		insert crewListS;
        List<Crew_Members__c> crewListS2 = [SELECT Name,Crew_Member_ID__c FROM Crew_Members__c 
                                            WHERE Name LIKE 'Aldri%'];
        for(Crew_Members__c c : crewListS2){
            c.Name = 'Armstrong ' + c.Crew_Member_ID__c;
        }
        update crewListS2;
	}
    
    
    
}