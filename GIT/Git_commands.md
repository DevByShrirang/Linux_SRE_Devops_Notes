2️⃣ Checking Repo Status & Logs
git commands:-
git status:-Before committing anything, I always check what’s changed using git status.
            It shows me which files are modified, staged, or untracked.
git diff :- If I want to see what exactly changed in my code, I run git diff — this compares the current working directory with the last commit.
git log :- After a commit, I often use git log to review commit history — who made which commit and when.

git add <filename> // git add . ==>Once my code is ready, I stage it using git add <filename> or git add . to stage all changes.
                                 Then I use git commit -m "Meaningful message" to save that change in the local repository


git checkout develop --   develop branch having most up to date code from all previous features.
git pull origin develop - Pulling ensures I’m working on the latest code before creating my feature branch.
git checkout -b  feature/login-enhancement -- we created feature branch from develop branch.
git add .
git commit -m "meaningful message"
git push -u origin feature/login-enhancement  - pushing to remote
|
|
|
merge feature branch back to develop
git checkout develop
git pull origin develop
git merge feature/login-enhancement.
git push origin develop


deletion of feature branch
git branch -d feature/login-enhancement
git push origin --delete feature/login-enhancement.  --Once merged, the feature branch is no longer needed, so I delete it locally and remotely to keep the                                                        repository clean.


git reset - move head to previous commit

git reset --soft <commit-id> -- moved HEAD to earlier commit but keeps changes staged.
git reset --mixed <commit-id> -- moved HEAD to earlier commit but keeps changes in working directory.
git reset --hard <commit-id> --  moved HEAD to earlier commit and delete all changes(staging+working directory)


                            git reset is used to undo commits by moving the HEAD pointer to a previous commit.
                            It changes the commit history, so it’s usually used for local clean-up, not in shared branches.

git revert - safe way to undo changes.
             Instead of deleting the commit from history, it creates a new commit that reverses the changes of the given commit.
git  log --oneline
git revert abg123
git push origin develop

git stash - git stash temporarily saves my uncommitted changes so I can switch branches or pull updates without committing incomplete work.