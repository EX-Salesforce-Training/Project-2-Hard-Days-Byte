trigger orderNewCrew on Crew_Members__c (after DELETE){
    orderNewCrewHandler handler = new orderNewCrewHandler();
    handler.triggerMethodM();
}