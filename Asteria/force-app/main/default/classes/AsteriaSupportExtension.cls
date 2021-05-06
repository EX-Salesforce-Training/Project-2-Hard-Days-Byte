/*Extension for controller for cases. Save button doesnt take to new record and instead takes back to the page.
Abdulloh Yoldoshev
5/4/2021
*/
public class AsteriaSupportExtension {
    private ApexPages.StandardController sc;
    public AsteriaSupportExtension(ApexPages.StandardController sc) {
        this.sc = sc;
    }
    public PageReference save() {
        
        this.sc.save();
        PageReference newPage = New PageReference('/apex/supportpage?core.apexpages.request.devconsole=1');
        newPage.getParameters().put('id',ApexPages.currentPage().getParameters().get('id'));
        newPage.setRedirect(true);


        return newPage;
    }

   /* public PageReference cancel() {
        this.sc.cancel();
        PageReference newPage = New PageReference('/apex/SingupHomePage?core.apexpages.request.de');
        newPage.getParameters().put('id',ApexPages.currentPage().getParameters().get('id'));
        newPage.setRedirect(true);
        return newPage;
    }*/
}