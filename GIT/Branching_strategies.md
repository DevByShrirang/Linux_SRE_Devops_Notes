
-------------------------================----------------------------==============================-------------------------===========================
We have three main branches in our Git workflow:

The main (or master) branch, which is used for every production release.

The staging branch, which acts as a pre-production environment — it’s almost identical to the master branch but is used for final testing and validation before release.
The development (dev) branch, where active development happens on a daily basis.
At the end of each sprint or release cycle, the development branch is merged into the staging branch for testing. Once testing is complete and everything is verified, the staging branch is merged into the main (master) branch for production release.”

if any bug notified then what developer will do?
If a bug is identified in our application, the developer first creates a new branch from the development branch to work on that fix.
The developer then fixes the issue in that branch, tests it locally, and raises a Pull Request (PR) against the development branch.
         The PR is reviewed by a senior developer or team lead — they check the code quality, logic, and ensure it doesn’t break existing functionality.
           Once the PR is approved, it gets merged back into the development branch.
              After merging, the updated code is automatically built and deployed to the staging environment for testing and validation.
                 Once verified, it eventually moves to the main (or master) branch during the next release cycle.”



how often do you release your product?'
we release every week. we release dev branch first then deployed into dev environment after that we deploy it to stage then we deploy it to production




