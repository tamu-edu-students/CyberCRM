# CyberCRM

Client: John Romero, Texas A&M Cybersecurity Center

This is a CRM (Customer Relationship Management) system to use for tracking cybersecurity students so information could be easily accesible to program directors. The primary objective is the ability to pull up a profile page with information on any given student while also having the ability to add or update information on the student. The seconday objective is being able to run reports on given people or organizations with filters. This could include a list of all the students who have taken a certian certification or in a certain cybersecurity organization.

There will be Role-based access control (RBAC) and have three primary roles: Super User, Program Director, Student Worker. Program Directors could be assigned super user access and student workers have the least permissions with only the ability to add or read in certian specified areas. Program directors by defualt will only be able to view there program information with their students information.

Website: https://cybercrm-7ccb791b98d3.herokuapp.com/

Code Climate report: Pending

Below are guidelines on how contributions to the GitHub repository should be made.

## Branching

When developing locally, a new branch should be created so that you will able to develop without disturbing the main branch. 

Please use Snake Case for the naming convention of the branches (Ex: branch_name). Also, try to make the branch name descriptive as to what change is being made. 

Commands:

1. `git branch <branch-name>` - Create branch

2. `git checkout <branch-name>` - Switch to branch

## Commits and Pushing to Remote

When developing, you need to save your changes. Commits let you save changes in the repository. Pushing changes to remote sends a backup of your changes to the central repository. Although you can create as many commits as you'd like it is best to make good commits. This can be characterized by adequately describing what changes have been made as well as only making commits after significant additions, not every line of code

Creating Commits:

1. Get current changes:

    `git status`

2. Add necessary files:

   `git add <file-name>` - Adding one file

   `git add .` - Adding all files in your current directory

4. Committing changes:

    `git commit -m <commit message>` - Make a commit with a short commit message.

    `git commit` - Make a commit with a long commit message (Opens a text editor).

Pushing Changes to Remote:

1. When working in your own branch, you shouldn't have any interference. You should make sure to pull before you push just in case.

    `git pull`

2. When making the first push to a new branch:

    `git push -u origin <branch name>`

3. When making any other push to the branch:

    `git push`

Note: Make sure to resolve any merge conflicts before continuing.

## Creating Pull Requests

When creating a pull request, it is best to do so on GitHub rather than in the command line interface.

1. Go to the main repository page: https://github.com/tamu-edu-students/CyberCRM/tree/main.

2. Click on the branch drop-down and select your branch.

3. Click on the contribute dropdown and select `Open pull request`.

4. Notify another team member or the project manager of the pull request for review.

## How to run Rails

`bin/rails server`
