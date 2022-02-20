all used command 
1.	
2.	
	git clone https://github.com/BorSerAl/sanbox_task.git
	cd /sanbox_task

3.	Create “Task1” folder in the master branch. Create and push ./Task1/README.md file.
	mkdir Task1
	echo "add readme to main brunch" > Task1/README.md
	git push -u origin dev
	git add .
	git commit -m "Create and push ./Task1/README.md"
	git push
	
4.	Create new branch dev. Create and push any test file.
	git checkout -b dev
	git branch
	echo "any test file" > Task1/test.txt
	git status
	git add .
	git commit -m "Create and push any test file"
	git status
	git push -u origin dev
	
5.	Create new branch %USERNAME-new_feature.
	git checkout -b Serbor-new_feature
	
6.	Add README.md file to your %USERNAME-new_feature branch
	echo "Add README.md file to Serbor-new_feature branch " > Task1/README.md

7.	Check your repo with git status command
	git status

8.	Add .gitignore file to ignore all files whose name begins “.”
	echo .* > Task1/.gitignore
	echo !.gitignore >> Task1/.gitignore

9.	Commit and push changes to github repo
	git add .
	git commit -m "branch %USERNAME-new_feature + .gitignore"
	git push origin Serbor-new_feature

10.	Create Pull Request to the dev branch.
11.	Merge your branch with the dev branch and create Pull Request to the master(main) branch. Merge dev with master(main).
	
12.	Checkout to %USERNAME-new_feature, make changes in README.md and commit them. Revert last commit in %USERNAME-new_feature branch.
	git checkout Serbor-new_feature
	git pull
	echo changes >> Task1/README.md
	git add .
	git commit -m "changes in README.md"
	git revert HEAD

13.	Check your repo with git log command, create log.txt file in master(main) branch and save “git log” output in it.
	git checkout main
	git pull
	git log > Task1/log.txt
	git add .
	git commit -m "git log  output in log.txt"
	git push	
	 
14.	Delete local and remote branch %USERNAME-new_feature
	git merge Serbor-new_feature
	git branch -d  Serbor-new_feature
	git push origin --delete Serbor-new_feature

15.	Add all used command to the git_commands.md file in the dev branch.
	git checkout dev
	echo all used command > Task1/git_commands.md
	git add .
	git commit -m "Add all used command to the git_commands.md file in the dev branch"
	git pull
	git push





















