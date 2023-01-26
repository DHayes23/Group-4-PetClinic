# **Team Magenta Group 4 - Petclinic Automated Cloud Solution**


# **Introduction**
 
This project aims to deliver a fully functional, cloud based version of the Petclinic application. As per the project brief, in delivering on these aims we are to use the tools and workflows covered during our training to achieve the final goal.

We are additionally required to document our work to a high standard and to present the final deliverable to an audience of stakeholders and assessors.

# **Team Members**
* Josip Kules
* Maggie Walsh
* Godspower Olasupo
* Niall O'Keeffe
* Denis Hayes

​
# **Table of Contents**


  * [Introduction](#introduction)
  * [Key Deliverables](#key-deliverables)
  * [User Stories](#user-stories)
  * [Risk Assessment - Sample](#risk-assessment)
  * [Choice of Tools and Services](#choice-of-tools-and-services)
  * [Planned Infrastructure](#planned-infrastructure)
  * [Availability of Application](#availability-of-application)
  * [Auto Scaling of Resources](#auto-scaling-of-resources)
  * [Cost Analysis](#cost-analysis)
  * [Acknowledgements](#acknowledgements)
  * [Application Testing](#application-testing)

​​
# **Key Deliverables**
​
The Key Deliverables for this project are outlined in the following document:
[Key Deliverables](/key_deliverables.md)


Throughout this project, every attempt has been made to adhere to these requirements.
​

# **User Stories**

## **Owner:**
As an owner:

* I want an easy to use, cost-effective solution.
* I want my application to be accessible to my customers at all times.
* I want it to be easy for my developers and engineers to work on the codebase, should changes be required.
* I want all of the data passing through my application and stored in my database to be safe from intrusion.
* I want all of the valuable data collected by the application to be backed-up to ensure that, in the event of a disaster, the data is retained.
## **Developer:**
As a developer:
* I want to have a development environment which is separate from the production environment, so that I can make experimental changes without affecting the customer experience.
* I want to ensure that the databases are fully functional so they can store, add and delete information.
* I want a new pipeline to automatically initiate every time I make a deployment.
* I want the pipeline to produce logs to assist me in debugging the application.
## **Engineer:**
As an engineer:
* I want to ensure that the application runs smoothly, regardless of the amount of traffic.
* I want the application to be easy to understand and replicate so it can be reproduced again when needed.
* I want to have a detailed set of logs to monitor and review the application for management and maintenance.


# **Risk Assessment**
A comprehensive Risk Assessment was carried out and updated throughout the project. 

Please find the full Risk Assessment within this repository.

A sample of the Risk Assessment is available below:

![Risk Assessment Sample](Risk_Assessment_Sample_Image.png)





# **Choice of Tools and Services**

Throughout this project, we have had to make several decisions regarding which tools and services to use. Many of the different stages of our solution could be achieved using a number of similar tools; we were required to select the tool that would serve our needs best. We have listed a number of these decisions and their rationale below, with an aim to provide clarity on alternative options and our reasoning.

---

## **Version Control System (VCS)**
### Competing Options:
 * ### GitHub/Git
 * ### CodeCommit by AWS
---
A version control system is used to store and organise the source code of a solution/application within a 'repository'. Using the same repository allows any number of developers to work together on the same code base, having a 'single source of truth' to ensure that everyone is clear on the current state of the code.

While initially we planned to use CodeCommit, we quickly realised that due to the access controls in place on our AWS accounts that the team would not be able to collaborate with one another, thereby eliminating the AWS offering from contention. 

Being unable to use CodeCommit pushed us towards the use of GitHub. Thankfully, as a team we are very familiar with GitHub. 

The tools offered by GitHub, such as easily adding collaborators to a repository and a simplified branching system, allowed us to start our work together quickly and efficiently.

Additionally, GitHub integrates nicely with AWS, being a selectable option in all services where one can specify a VCS.

### Choice: **GitHub**

---

## **Kanban Software**
### Competing Options:
 * ### Trello
 * ### Jira
---
In order to effectively track our product and sprint backlogs, we required a suite of Kanban tools. Kanban is a framework used within Agile to visually represent the work that must be done, is being done and has been done on a 'Kanban Board'. Using this method, a team can easily keep track of all of a project's major tasks.

There are several software based solutions available to teams wanting to implement Kanban. The two with which our team were most familiar were Jira and Trello.

Jira arguably offers the most complete and rich set of Kanban tools, providing a level of granularity which other suites do not. In the view of our team, these extra features were not necessary on a project with such a short time-frame as this one, and could actually impede progress.

Trello, on the other hand is a more lightweight offering. The reduced offering from Trello in this case is actually its greatest strength. As a team with basic task tracking needs, Trello was easy to set up and easy to maintain. Within 10 minutes we were able to configure the software and add everyone to the workspace.

### Choice: **Trello**

---

## **Containerisation Tool**
### Competing Options:
 * ### Docker
---
To successfully build our solution, we were required to successfully run a pipeline. Running this pipeline required us to containerise the different elements of the Petclinic application. 

Docker allowed us to containerise the elements of the Petclinic application and push them to AWS' Elastic Container Registry.

Docker Compose and Docker Swarm allowed us to manage the orchestration of multiple containers, meaning that we were able to have several containers on different EC2 instances communicating with each other.

As our training has covered Docker, and not yet an alternative option such as Kubernetes, we were limited in our options for which service to use. As such, Docker was the sole candidate for use in this project.

### Choice: **Docker**

---

## **Ifrastructure as Code (IaC) Tools**
### Competing Options:
* ### Terraform
* ### CloudFormation
---
In order to provide a working solution, we were required to create AWS infrastructure to host our containers. There are a number of tools which allow a user to bypass the manual creation step and to programmatically implement the provisioning of resources. This approach is known as 'Infrastructure as Code'.

We have had training in the use of both Terraform and CloudFormation(AWS' IaC offering), and so we were required to make a decision on which tool to use for this project.

CloudFormation is an AWS specific IaC tool, meaning that it can only be used with the AWS cloud and its services. As a result of its narrow focus, CloudFormation is heavily integrated with other AWS services. The high quality documentation produced by Amazon also improves the engineering experience. 

Terraform is a platform-agnostic IaC tool, meaning that it can be used with most cloud providers, including AWS. Due to this tool's multi-cloud capabilities, it is not as closely integrated with the one-note Cloudformation.

To achieve our solution, we planned have planned to use exclusively AWS provided resources. Taking this fact into consideration, coupled with the ease of use of CloudFormation, and our decision was clear.

### Choice: **Cloudformation**

---

## **Pipeline Tool**
### Competing Options:
* ### Jenkins
* ### CodePipeline
---

In order to create a fully enclosed CI/CD pipeline, we were required to choose a service which could perform the required tasks that this calls for. By creating a pipeline, a user can automate their releases upon a push being made to a code repository. This simplifies the overall deployment process and ensures that key build tasks are completed every time new code is pushed.

CodePipeline is an AWS offering which has full integration with other AWS services. This fully managed service is operated through the AWS GUI or the AWS CLI, and is designed to guide the user through the steps required to utilise the pipeline.

Jenkins is a an alternative, open source automation server. In the same way as AWS CodePipeline, Jenkins guides the user through the pipeline setup process. 

In general, we have tried to stick to using AWS services thorughout this project, and due to its built-in integration with AWS services, we chose to use CodePipeline.

### Choice: **CodePipeline**

# **Planned Infrastructure**

Revisions to our infrastructure have led to a reduced number of resources being provisioned as compared with our initial plan. 

The following image represents the original planned infrastructure for each AZ:

While initially the plan was to deploy 4 separate EC2 instances, this decision was later revised. The existing solution requires 3 linked EC2 instances.

If the client so chooses, a further 3 instances could be provisioned in the same AWS Region, but in a different AZ in order to increase the availability of the application. 

Taking such an approach would incur additional costs, for the benefit of a more robust solution.

# **Availability of Application**
When discussing cloud-based applications, a key concern is that of 'Availability'. 

Availability, in the context of a web application, can be reductively defined as 'The percentage of time during which the application is assessible and reachable by its intended audience.

This metric is of great importance to the business owner and their customer; a site that is not accessible is not providing any value. As such, it is very important that any cloud solution which is implemented must ensure high-availability. We can achieve this by designing an infrastructure which is resilient in the face of adversity.  

One of the techniques used to achieve high-availability when using AWS is to provision resources in different Availability Zones. These AZs represent geographically separate data centers. Each AZ is completely independent, and so can continue its operations even if another AZ experiences an outage or is destroyed.

Further redundancy can be implemented by duplicating an application's resources across different Regions. Each Region is a wider-scoped geographical location, containing at least two AZs. By replicating an application's infrastructure across multiple Regions, the application is protected even in the case of a catastrophic incident which would destroy the data centers in an entire Region.

Additionally, provisioning resources in multiple Regions can reduce the time it takes for the end user to connect to the application. This homogenises the user experience, regardless of which Region they are accessing the application from.

In order to best serve the expected needs and use-cases of the Petclinic application, Team 4 decided to opt for a multi-AZ approach to availability.

We have provisioned replicated resources in two AZs within the same region, thereby protecting the application from outages or disasters in a single data center. We are of the opinion that this is the correct level of availability to apply to the Petclinic application, as the chances of both AZs being disabled is acceptably low. 

Provisioning resources on a Regional scale would, in this case, is not necessary. As the application manages the bookings of a local veterinary clinic, reaching a global audience  is not a major concern. 

In order to provide the solution with the greatest cost-benefit efficiency, we have determined that a two AZ approach is optimal. For further information on costing, please see the Cost Analysis section.

# **Auto-Scaling of Resources**

Auto-Scaling refers to the dynamic adjustment of computational resources in response to increasing or decreasing load. 

AWS simplifies the process of automatically provisioning new resources when they are needed, through the use of Auto-Scaling groups and Launch Templates. These tools allow an engineer to configure resources as appropriate for the application in question.

Due to the size and nature of the Petclinic application and its expected userbase, we have determined that including auto-scaling features in this solution is not necessary. Through the use of a multi AZ setup with duplicated resources, the application should have more than sufficient compute power in its base configuration.

# **Cost Analysis**

We have approached this project with the overall cost to the client firmly in mind. 

As with almost all cloud-based solutions, the solution that we have presented will cost the client significantly less to run than it would the same resources on premises. 

Utilising cloud technology allows for a number of cost based advantages. Our client can avail of on-demand billing (only paying for what you use), trading of capital expenditure for operational expenditure and the price benefits that come from the massive economies of scale associated with cloud solutions.

Based on our estimations, the client will require at least 3 EC2 Instances within a single Availability Zone. If the client wishes to improve the availability of their application, they could double the provisioned resources.

An additional small charge exists per (Active) pipeline.

We have used other resources provided by AWS, however they are, in these use cases, free to use and so will not incur any additional charge.

We have based our projections on the client operating their application 24/7, which we feel is appropriate as their users may need to access the application at any time.

We would recommend that the client utilises Reserved EC2 instances in this case, as they have a predictable, long-term workload.

All costs in USD($).

Monthly Cost Per (Active) Pipeline: 
* 1.00

Reserved EC2 T.2 Micro Hourly Cost:
* 0.0036

Daily Cost Per T.2 Micro Instance:
* 0.0864

Annual Cost Per T.2 Micro Instance:
* 31.4496

Total Annual Cost for 3 Instances:
* 94.3488

Total Annual Cost for 6 Instances(Improved Availability Option): 
* 188.6976

# **Application Testing**

Following our successful running of the application, we ran the application tests.

The tests covered the majority of the codebase, testing each element of the application thoroughly. 

![Application Test 1](TestingScreenshot1.png)

43 of the tests passed, presenting no failures.

![Application Test 2](TestingScreenshot2.png)
Once all of the tests ran successfully, we were able to access the application using a web-browser.

![Application Test 3](TestingScreenshot3.png)

# **Acknowledgements**

We would like to thank **Deloitte** and the members of the Cloud Engineering team for their support, and for kindly hosting us on various occasions throughout our training.

We would like to thank **AMS** and the team there for their constant support and guidance.

We would like to thank **QA** and the training team for providing us with the skills required to complete this project.