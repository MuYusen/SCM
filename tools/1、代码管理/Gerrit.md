# Gerrit

## What is Gerrit Code Review?

Gerrit provides a framework you and your teams can use to review code before it becomes part of the code base. Gerrit works equally well in open source projects that limit the number of users who can approve changes (typical in open source software development) and in projects in which all contributors are trusted.

## What is Code Review?

Code reviews can identify mistakes before they’re found by customers. In a world of continuous integration, code must be tested before it’s submitted to the master branch to become part of the code base. Tests confirm that a product works (and continues to work) as intended by the developers.

`When code is reviewed, developers:`

+ Work carefully and consistently
+ Learn best practices and new techniques from other developers
+ Implement consistency and quality across the code base

`Code reviews typically turn up issues related to:`

+ Design: Is code well-designed and suited to the code base?
+ Functionality: Does code perform as intended and in a way that is good for users?
+ Complexity: Can other developers understand and use the code?
+ Naming: Does the code contain clear names for elements such as variables, classes, and methods?
+ Comments: Are comments specific and complete?

## How Gerrit Works

To learn how Gerrit fits into and complements the developer workflow, consider a typical project. The following project contains a central source repository (Authoritative Repository) that serves as the authoritative version of the project’s contents.

![intro-quick-central-repo](./res/intro-quick-central-repo.png)

`Figure 1. Central Source Repository`

When implemented, Gerrit becomes the central source repository and introduces an additional concept: a store of Pending Changes.

![intro-quick-central-gerrit](./res/intro-quick-central-gerrit.png)

`Figure 2. Gerrit as the Central Repository`

When Gerrit is configured as the central source repository, all code changes are sent to Pending Changes for others to review and discuss. When enough reviewers have approved a code change, you can submit the change to the code base.

In addition to the store of Pending Changes, Gerrit captures notes and comments made about each change. This enables you to review changes at your convenience or when a conversation about a change can’t happen in person. In addition, notes and comments provide a history of each change (what was changed and why and who reviewed the change).

Like any repository hosting product, Gerrit provides a powerful access control model, which enables you to fine-tune access to your repository.

