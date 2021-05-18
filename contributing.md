# Contributing to Project-2

> - Please Read All Instructions to contribute to the project.
> - No project should be submitting a pull request to the main branch.

# How To Set Up Computer for use with local development

- Download Node.js [here](https://nodejs.org/en/)
- Download VSCode(Or other favorite Text Editor)


# Clone Main Branch
 
 - run git clone git@github.com:EX-Salesforce-Training/
Project-2-Hard-Days-Byte.git in terminal

# Branch on Local

 - run "git checkout -b {name-of-business}" to create a new branch on your local repository

# Push Branch to Remote

 - run "git push origin {name-of-business}" to create a new branch on the remote repository on Github

# Working with Salesforce Developer Experience
 - Download sfdx CLI [here](https://developer.salesforce.com/tools/sfdxcli)
 - Authorize your production org by running "sfdx auth:web:login -a {your-name}" in Asteria project
 - Login to your org with proper username and password(Might have to get proper credentials from org)

# Deploy Main to Playground Org
 - Make sure your org is the default org for the project. 
 - Using sfdx in command line(or command palette) "sfdx force:org:deploy -x ./manifest/package.xml" 
 - Confirm deployment succeeded

# Work in org or on Visual Studio Code
 - While working on project in Visual Studio Code, consistently commit changes to branch
 - If working in the org, frequently retrieve data with "sfdx force:org:retrieve -x ./manifest/package.xml" for entire package or "sfdx force:org:retrieve -x ./manifest/Individual-Manifest.xml" for specific extraction of your edited files and commit to branch
   push to repository frequently to track progress

# Pull Request
 - Confirm all changes are ready for deployment
 - Clean up Commit History 
 - Submit Pull Request
 - Get somebody to pull your branch and check for issues
 - merge pull request


