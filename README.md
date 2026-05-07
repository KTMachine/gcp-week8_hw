# gcp_week8_hw


# Q & A
1. What is the difference between high availability and fault tolerance? Which is best to strive for?

High availability is meant to remain available majority of the time, by making itself accessible in multiple zones in a region. For example, if you have a VPC in us-central1 Region, and you have 3 subnets, your subnets will be in us-central1-a, us-central1-b, and us-central1c. With High availability, there will be disruptions but it will recover your systems quickly. Fault Tolerance makes sure that your system continues to work without interruption or downtime, therefore, there will be no interruptions to your system. Fault tolerance is more expensive than High Availability, so depending on what is needed, then that would be best to strive for.

2. Explain the difference between autoscaling and elasticity. What is vertical and horizontal autoscaling? Is one better? Are they feasible on prem?

Elasticity is when you're able to scale a resource up or down, out, and/or in. Autoscaling is the means in which you are able to do, by your systems protocol, by certain means (such as timing, percentage, schedule, request count, etc.). Vertical scaling is when a resource is scaled up or down (from a t3.micro to t5.large or r8g.2xlarge to r8g.medium). Horizontal scaling is increasing, or decreasing, a resource of the same size (1 t3.large to adding 4 more t3.large instances). Both are feasible on-prem, neither is better than the other, it only depends on what is needed.

3. Explain the difference between managed and unmanged instance groups?

Managed Instance Groups are used for High availability production for your VM's. MIG's provide autoscaling, autohealing, automated updates, regional coverage, and it's great for stateful workloads. Unmanaged Instance Groups, is quite the opposite. The user must do everything manually as it does not offer any of the features mentioned previously.

4. Explain the different use cases for health checks used by applications (in instance groups) and health checks used by load balancers. Can they be the same? Are they different API calls? Should they be the same? 

Health checks used by instance groups will determine whether or not a VM is good enough to keep running or not. If the VM, or instance, is not good enough, then it will be deleted. With a Load Balancer, a health check will determine if the instance should receive traffic, if it fails, the Load Balancer stops routing but the instance will keep running. They are both very different, as a health check for an instance group is for cycling the function of a VM, while a health check for a load balancer is about routing traffic. They have similarities, it's just that they have different configurations to make them work.

5. Explain in a few sentences what the 3-tier architecture is and how it relates to what you are learning.

The 3-tier architecture builds an application in 3 parts. The first will be the frontend, which is what users will interact with. The backend, where each request will be processed. Then the databases. Each tier is secured independently, however they work interdependently, which helps me figure out how to implement each tier to work together for the entire project to work as one. Like making sure each part of your internal organs work separately in their own way, but makes sure that the entire body still functions.


# Runbook
### Goal
- Deploy a Managed Instance Group in GCP using the User Interface. The MIG will have autoscaling, autohealing, and will distribute instances across multiple zones in us-central1.

## Prerequisites 
- Your own GCP Project
- A working instance template
- An HTTP firewall rule allowing port 80
- Use of the default VPC in your GCP project

## Steps
1. Create an Instance Template
```
- On your home screen in GCP, click the Navigation Menu on the top left > Compute Engine > Instance Template > Create Instance Template
- Or click the search icon and type "Instance Template" > Create Instance Template

- Name: "instance-template-1" (or whatever you want)
- Location: Regional
- Machine Type: Any type you want, but I am choosing N1
- Boot Disk: Debian
- Advance Options: 
- Click the arrow pointing down > Networking > Networking interfaces > Click on arrow pointing down > Edit network interface > You don't have to change anything here because the default VPC is being used, but this is how you will add your own VPC when you do it.
- Management > Automation > Copy and Paste your Startup script there
- Click Create
```

2. Create the Managed Instance Group
```
- Back to the Navigation Menu > Compute Engine > Instance Groups > Create Instance Group > Select Managed Instance Group

- Or click on your newly created Instance Template > In top center you will see "Create Instance Group" > click it

- Name: "instance-group-1" (Or whatever you want)
- Description: Whatever you want
- Instance template: choose the instance template you just created
- Location: Multiple Zones
- Regions: us-central1
- Zones: Choose the Zones, or leave as is
- Autoscaling
- Min instances: 2
- Max instances: Whatever you want, it is suggested to never go above 10... I will choose 4
```

3. Configure Autoscaling
```
- Stay on the same page

- Autoscaling signals: Signal type > CPU utilization > Target CPU utilization > 60

- Autoscaling schedules > Initialization Period > 60 seconds
```

4. Configure Autohealing
```
- Stay on the same page
- Autohealing > Health Check > Create a health check

- Name: "health-check-1" (or whatever you want)
- Description: (Whatever you want)
- Protocol: HTTP
- Port: 80
- Request Path: /
- Health Criteria
- Check interval: 10 seconds
- Timeout: 5 seconds
- Healthy threshold: 2
- Unhealthy threshold: 3
- Click Save
- Initial Delay: 120 seconds
- Create
```

5. Verify Multi-Zone Distribution
```
- Once the instance group is created, click on it
- Scroll down to the "VM instances" and see that your instances have been created
- Click on the "Details" section, scroll down to "Location", see the Zones that you have chosen
```

6. Verify Autoscaling and Autohealing are Active
```
- On the same page, scroll down to "Autoscaling" > See that Autoscaling mode is on
- For Autohealing, scroll down slightly to "VM instance lifecycle"  it will show your health check name, initial delay, "on failed health check", etc.
```