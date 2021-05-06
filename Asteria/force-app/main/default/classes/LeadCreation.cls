public with sharing class LeadCreation {
    private ApexPages.StandardController sc;
    public LeadCreation(ApexPages.StandardController sc) {
        this.sc = sc;
    }
    public PageReference save() {
        this.sc.save();
        PageReference newPage = New PageReference('/apex/SingupHomePage?core.apexpages.request.de');
        newPage.getParameters().put('id',ApexPages.currentPage().getParameters().get('id'));
        newPage.setRedirect(true);
        return newPage;
    }
    
    public PageReference cancel() {
        this.sc.cancel();
        PageReference newPage = New PageReference('/apex/SingupHomePage?core.apexpages.request.de');
        newPage.getParameters().put('id',ApexPages.currentPage().getParameters().get('id'));
        newPage.setRedirect(true);
        return newPage;
    }
}