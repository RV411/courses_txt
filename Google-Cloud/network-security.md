- [1. Multiple VPC Networks](#1-multiple-vpc-networks)
  - [1.1. Create custom mode VPC networks with firewall rules](#11-create-custom-mode-vpc-networks-with-firewall-rules)
    - [1.1.1. Create the PrivateNet Network](#111-create-the-privatenet-network)
    - [1.1.2. Create the firewall rules for managementnet](#112-create-the-firewall-rules-for-managementnet)
    - [1.1.3. Create the firewall rules for privatenet](#113-create-the-firewall-rules-for-privatenet)
  - [1.2. Create VM instances](#12-create-vm-instances)
    - [1.2.1. Create the managementnet-us-vm instance](#121-create-the-managementnet-us-vm-instance)
    - [1.2.2. Create the privatenet-us-vm instance](#122-create-the-privatenet-us-vm-instance)
  - [1.3. Explore the connectivity between VM instances](#13-explore-the-connectivity-between-vm-instances)
    - [1.3.1. Ping the internal IP addresses](#131-ping-the-internal-ip-addresses)
  - [1.4. Create a VM instance with multiple network interfaces](#14-create-a-vm-instance-with-multiple-network-interfaces)
- [2. VPC Networks - Controlling Access](#2-vpc-networks---controlling-access)
  - [2.1. Create the web servers](#21-create-the-web-servers)
    - [2.1.1. Create the blue server](#211-create-the-blue-server)
    - [2.1.2. Create the green server](#212-create-the-green-server)
    - [2.1.3. Install nginx and customize the welcome page](#213-install-nginx-and-customize-the-welcome-page)
  - [2.2. Create the firewall rule](#22-create-the-firewall-rule)
    - [2.2.1. Create a test-vm](#221-create-a-test-vm)
    - [2.2.2. Test HTTP connectivity](#222-test-http-connectivity)
  - [2.3. Explore the Network and Security Admin roles](#23-explore-the-network-and-security-admin-roles)
    - [2.3.1. Create a service account](#231-create-a-service-account)
    - [2.3.2. Authorize test-vm and verify permissions](#232-authorize-test-vm-and-verify-permissions)
    - [2.3.3. Update service account and verify permissions](#233-update-service-account-and-verify-permissions)
- [3. HTTP Load Balancer with Cloud Armor](#3-http-load-balancer-with-cloud-armor)
  - [3.1. Configure HTTP and health check firewall rules](#31-configure-http-and-health-check-firewall-rules)
    - [3.1.1. Create the HTTP firewall rule](#311-create-the-http-firewall-rule)
    - [3.1.2. Create the health check firewall rules](#312-create-the-health-check-firewall-rules)
  - [3.2. Configure instance templates and create instance groups](#32-configure-instance-templates-and-create-instance-groups)
    - [3.2.1. Configure the instance templates](#321-configure-the-instance-templates)
    - [3.2.2. Create the managed instance groups](#322-create-the-managed-instance-groups)
    - [3.2.3. Verify the backends](#323-verify-the-backends)
  - [3.3. Configure the HTTP Load Balancer](#33-configure-the-http-load-balancer)
  - [3.4. Test the HTTP Load Balancer](#34-test-the-http-load-balancer)
    - [3.4.1. Access the HTTP Load Balancer](#341-access-the-http-load-balancer)
    - [3.4.2. Stress test the HTTP Load Balancer](#342-stress-test-the-http-load-balancer)
  - [3.5. Denylist the siege-vm](#35-denylist-the-siege-vm)
    - [3.5.1. Verify the security policy](#351-verify-the-security-policy)
- [4. Create an Internal Load Balancer](#4-create-an-internal-load-balancer)
  - [4.1. Configure HTTP and health check firewall rules](#41-configure-http-and-health-check-firewall-rules)
    - [4.1.1. Explore the my-internal-app network](#411-explore-the-my-internal-app-network)
    - [4.1.2. Create the HTTP firewall rule](#412-create-the-http-firewall-rule)
    - [4.1.3. Create the health check firewall rules](#413-create-the-health-check-firewall-rules)
  - [4.2. Configure instance templates and create instance groups](#42-configure-instance-templates-and-create-instance-groups)
    - [4.2.1. Configure the instance templates](#421-configure-the-instance-templates)
    - [4.2.2. Configure the next instance template](#422-configure-the-next-instance-template)
    - [4.2.3. Create the managed instance groups](#423-create-the-managed-instance-groups)
    - [4.2.4. Verify the backends](#424-verify-the-backends)
  - [4.3. Configure the Internal Load Balancer](#43-configure-the-internal-load-balancer)
  - [4.4. Test the Internal Load Balancer](#44-test-the-internal-load-balancer)
- [5. Cloud Monitoring](#5-cloud-monitoring)
  - [5.1. Create a Compute Engine instance](#51-create-a-compute-engine-instance)
  - [5.2. Add Apache2 HTTP Server to your instance](#52-add-apache2-http-server-to-your-instance)
    - [5.2.1. Create a Monitoring Metrics Scope](#521-create-a-monitoring-metrics-scope)
    - [5.2.2. Install the Ops agents](#522-install-the-ops-agents)
  - [5.3. Create an uptime check](#53-create-an-uptime-check)
  - [5.4. Create an alerting policy](#54-create-an-alerting-policy)
  - [5.5. Create a dashboard and chart](#55-create-a-dashboard-and-chart)
    - [5.5.1. Add the first chart](#551-add-the-first-chart)
  - [5.6. View your logs](#56-view-your-logs)
    - [5.6.1. Check out what happens when you start and stop the VM instance.](#561-check-out-what-happens-when-you-start-and-stop-the-vm-instance)
  - [5.7. Check the uptime check results and triggered alerts](#57-check-the-uptime-check-results-and-triggered-alerts)
    - [5.7.1. Check if alerts have been triggered](#571-check-if-alerts-have-been-triggered)
  - [5.8. (Optional) Remove your alerting policy](#58-optional-remove-your-alerting-policy)


# 1. Multiple VPC Networks 
    Create custom mode VPC networks with firewall rules
    Create VM instances using Compute Engine
    Explore the connectivity for VM instances across VPC networks
    Create a VM instance with multiple network interfaces

## 1.1. Create custom mode VPC networks with firewall rules
Create two custom networks managementnet and privatenet, along with firewall rules to allow SSH, ICMP, and RDP ingress traffic.

1. VPC networks.
2. Notice the default and mynetwork networks with their subnets
3. Each Google Cloud project starts with the default network. In addition, the mynetwork network has been premade as part of your network diagram.
4. Click Create VPC Network.
5. Set the Name to **managementnet**.
6. For **Subnet** creation mode, click **Custom**.
7. Set the following values, leave all other values at their defaults:

        Name 	managementsubnet-us
        Region 	us-east1
        IPv4 range 	10.130.0.0/20

10. EQUIVALENT COMMAND LINE.    
    1.  These commands illustrate that networks and subnets can be created using the Cloud Shell command line. You will create the privatenet network using these commands with similar parameters.
    
        gcloud compute networks create managementnet --project=qwiklabs-gcp-03-4e632de649ce --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional
        
        gcloud compute networks subnets create managementsubnet-us --project=qwiklabs-gcp-03-4e632de649ce --range=10.130.0.0/20 --stack-type=IPV4_ONLY --network=managementnet --region=us-east1


### 1.1.1. Create the PrivateNet Network
create the privatenet
> gcloud compute networks create privatenet --subnet-mode=custom

create the privatesubnet-us 
> gcloud compute networks subnets create privatesubnet-us --network=privatenet --region=us-east1 --range=172.16.0.0/24

create the privatesubnet-eu
> gcloud compute networks subnets create privatesubnet-eu --network=privatenet --region=europe-west4 --range=172.20.0.0/20

list the available VPC networks
> gcloud compute networks list

list the available VPC subnets
> gcloud compute networks subnets list --sort-by=NETWORK

VPC networks.

    You see that the same networks and subnets are listed in the Cloud Console.


### 1.1.2. Create the firewall rules for managementnet
Create firewall rules to allow SSH, ICMP, and RDP ingress traffic to VM instances on the managementnet network

navigate to Navigation **Firewall**

    Name 	managementnet-allow-icmp-ssh-rdp
    Network 	managementnet
    Targets 	All instances in the network
    Source filter 	IPv4 Ranges
    Source IPv4 ranges 	0.0.0.0/0
    Protocols and ports 	Specified protocols and ports, and then check tcp, type: 22, 3389; and check Other protocols, type: icmp.

Equivalent comand line
> gcloud compute --project=qwiklabs-gcp-03-4e632de649ce firewall-rules create managementnet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=managementnet --action=ALLOW --rules=tcp:22,tcp:3389,icmp --source-ranges=0.0.0.0/0

### 1.1.3. Create the firewall rules for privatenet
run the following command to create the privatenet-allow-icmp-ssh-rdp firewall rule
> gcloud compute firewall-rules create privatenet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=privatenet --action=ALLOW --rules=icmp,tcp:22,tcp:3389 --source-ranges=0.0.0.0/0

list all the firewall rules 
> gcloud compute firewall-rules list --sort-by=NETWORK

navigate to Navigation **Firewall**.

    You see that the same firewall rules are listed in the Cloud Console.

## 1.2. Create VM instances
managementnet-us-vm in managementsubnet-us
privatenet-us-vm in privatesubnet-us

### 1.2.1. Create the managementnet-us-vm instance
navigate to Navigation menu > Compute Engine > VM instances.

    Name 	managementnet-us-vm
    Region 	us-east1
    Zone 	us-east1-c
    Series 	E2
    Machine type 	e2-micro



1. Click Networking.
   1. For Network interfaces, click the dropdown to edit.

              Network 	managementnet
              Subnetwork 	managementsubnet-us

2. Click Done.

3. Equivalent command line
> gcloud compute instances create managementnet-us-vm --project=qwiklabs-gcp-03-4e632de649ce --zone=us-east1-c --machine-type=e2-micro --network-interface=network-tier=PREMIUM,subnet=default --network-interface=network-tier=PREMIUM,subnet=managementsubnet-us --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=35671345290-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --create-disk=auto-delete=yes,boot=yes,device-name=managementnet-us-vm,image=projects/debian-cloud/global/images/debian-11-bullseye-v20220822,mode=rw,size=10,type=projects/qwiklabs-gcp-03-4e632de649ce/zones/us-east1-c/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any

### 1.2.2. Create the privatenet-us-vm instance
create the privatenet-us-vm

> gcloud compute instances create privatenet-us-vm --zone="us-east1-c" --machine-type=e2-micro --subnet=privatesubnet-us

list all the VM instances 
> gcloud compute instances list --sort-by=ZONE

navigate to Navigation **VM instances**.

    You see that the VM instances are listed in the Cloud Console.

Click on Column display options, then select Network. Click Ok

## 1.3. Explore the connectivity between VM instances
Determine the effect of having VM instances in the same zone versus having instances in the same VPC network.

Ping the external IP addresses of the VM instances to determine if you can reach the instances from the public internet.


1. For **mynet-us-vm**, click SSH to launch a terminal and connect.

2. To test connectivity to mynet-eu-vm's external IP, run the following command, replacing mynet-eu-vm's external IP
> ping -c 3 34.147.36.157
> ping -c 3 34.75.238.115
> ping -c 3 34.74.230.167

### 1.3.1. Ping the internal IP addresses
1. SSH terminal for **mynet-us-vm**.
2. **mynet-eu-vm** internal IP
3. **managementnet-us-vm** 100% packet loss
4. **privatenet-us-vm** 100% packet loss

because they are in separate VPC networks from the source of the ping

## 1.4. Create a VM instance with multiple network interfaces
1. Create the VM instance with multiple network interfaces
   1. VM instances
   2. Name 	vm-appliance
   3. Region 	us-east1
   4. Zone 	
   5. Series 	E2
   6. Machine type 	e2-standard-4
2. Add network
   1. Network 	privatenet
   2. Subnetwork 	privatesubnet-us
   3. Network 	managementnet
   4. Subnetwork 	managementsubnet-us
   5. Network 	mynetwork
   6. Subnetwork 	mynetwork
3. Explore the network interface details
4. Click SSH on vm-appliance
   1. sudo ifconfig    list the network interfaces
   2. ip route         list the routes
   3. ping -c 3 <Enter privatenet-us-vm's internal IP here>     **WORKS!**
   4. ping -c 3 privatenet-us-vm
   5. ping -c 3 <Enter managementnet-us-vm's internal IP here>  **WORKS!**
   6. ping -c 3 <Enter mynet-us-vm's internal IP here>    **WORKS!**
   7. ping -c 3 <Enter mynet-eu-vm's internal IP here>    **ERROR**


# 2. VPC Networks - Controlling Access 

1. Create an nginx web server
2. Create tagged firewall rules
3. Create a service account with IAM roles
4. Explore permissions for the Network Admin and Security Admin roles

## 2.1. Create the web servers
Create the blue server with a network tag

### 2.1.1. Create the blue server
1. VM instances.
   1. Name 	blue
   2. Region 	us-central1 (Iowa)
   3. Zone 	us-central1-a
   4. Networking
      1. For Network tags, type web-server
   5. Create

### 2.1.2. Create the green server
1. VM instances.
   1. Name 	green
   2. Region 	us-central1 (Iowa)
   3. Zone 	us-central1-a

### 2.1.3. Install nginx and customize the welcome page
1. for **blue** or **green**, click SSH 
2. sudo apt-get install nginx-light -y
3. sudo nano /var/www/html/index.nginx-debian.html
4. Replace the <h1>Welcome to nginx!</h1> line with <h1>Welcome to the blue server!</h1>
5. cat /var/www/html/index.nginx-debian.html

## 2.2. Create the firewall rule
1. navigate to **Firewall**
2. Click Create **Firewall Rule**
   1. Name 	allow-http-web-server
   2. Network 	default
   3. Targets 	Specified target tags
   4. Target tags 	web-server
   5. Source filter 	IPv4 Ranges
   6. Source IPv4 ranges 	0.0.0.0/0
   7. Protocols and ports 	Specified protocols and ports, and then check tcp, type: 80; and check Other protocols, type: icmp.
3. Click Create

### 2.2.1. Create a test-vm
Create a test-vm instance, in the us-central1-a zone:
> gcloud compute instances create test-vm --machine-type=f1-micro --subnet=default --zone=us-central1-a

### 2.2.2. Test HTTP connectivity
From test-vm curl the internal and external IP addresses of blue and green

1. Navigate to **VM instances**
   1. For test-vm, click SSH
   2. curl <Enter blue's internal IP here>
   3. curl -c 3 <Enter green's internal IP here>
   4. curl <Enter blue's external IP here>
   5. curl -c 3 <Enter green's external IP here>    **not work!** 


## 2.3. Explore the Network and Security Admin roles


    Network Admin: Permissions to create, modify, and delete networking resources, except for firewall rules and SSL certificates.

    Security Admin: Permissions to create, modify, and delete firewall rules and SSL certificates.


SSH terminal of the test-vm
> gcloud compute firewall-rules list    This should not work!

Try to delete the allow-http-web-server firewall rule:
> gcloud compute firewall-rules delete allow-http-web-server  This should not work!

### 2.3.1. Create a service account

Create a service account and apply the Network Admin role.

1. In the Console, navigate to Navigation menu (Navigation menu icon) > IAM & admin > Service Accounts.

2. Notice the Compute Engine default service account.

3. Click Create service account.

4. Set the Service account name to Network-admin and click CREATE AND CONTINUE.

5. For Select a role, select Compute Engine > Compute Network Admin and click CONTINUE then click DONE.

6. After creating the service account 'Network-admin', click on the three dots at the right corner and click Manage Key in the dropdown, then click on Add Key and select Create new key from the dropdown. Click Create to download your JSON output.

7. Click Close.
8. Rename the JSON key file on your local machine to credentials.json

### 2.3.2. Authorize test-vm and verify permissions

1. SSH terminal of the **test-vm**
2. To upload credentials.json through the SSH VM terminal, click on the Upload file icon in the upper-right corner.
3. Authorize the VM with the credentials you just uploaded:
   1. gcloud auth activate-service-account --key-file credentials.json
4.  Try to list the available firewall **works**
5.  Try to delete the allow-http-web-server firewall rule **NOT  works**

### 2.3.3. Update service account and verify permissions

1. navigate to IAM
2. Click on the pencil icon for the Network-admin account
3. Change Role to Compute Engine > Compute Security Admin.
4. SSH terminal of the **test-vm**
4.  Try to list the available firewall **works**
5.  Try to delete the allow-http-web-server firewall rule **works**


#  3. HTTP Load Balancer with Cloud Armor 
Cloud Armor IP allowlist/denylist enable you to restrict or allow access to your HTTP(S) load balancer at the edge of the Google Cloud, as close as possible to the user and to malicious traffic. This prevents malicious users or traffic from consuming resources or entering your virtual private cloud (VPC) networks.



    Create HTTP and health check firewall rules

    Configure two instance templates

    Create two managed instance groups

    Configure an HTTP Load Balancer with IPv4 and IPv6

    Stress test an HTTP Load Balancer

    Denylist an IP address to restrict access to an HTTP Load Balancer

## 3.1. Configure HTTP and health check firewall rules
Configure firewall rules to allow HTTP traffic to the backends and TCP traffic from the Google Cloud health checker.

### 3.1.1. Create the HTTP firewall rule

1. navigate to **firewall**
2. Click **Create Firewall Rule**
   1. Name 	default-allow-http
   2. Network 	default
   3. Targets 	Specified target tags
   4. Target tags 	http-server
   5. Source filter 	IPv4 Ranges
   6. Source IPv4 ranges 	0.0.0.0/0
   7. Protocols and ports 	Specified protocols and ports, and then check tcp, type: 80
3. Create

### 3.1.2. Create the health check firewall rules
1. click **Create Firewall Rule**.
   1. Name 	default-allow-health-check
   2. Network 	default
   3. Targets 	Specified target tags
   4. Target tags 	http-server
   5. Source filter 	IPv4 Ranges
   6. Source IPv4 ranges 	130.211.0.0/22 35.191.0.0/16
   7. Protocols and ports 	Specified protocols and ports, and then check tcp
2. Create

## 3.2. Configure instance templates and create instance groups
A managed instance group uses an instance template to create a group of identical instances. Use these to create the backends of the HTTP Load Balancer.

### 3.2.1. Configure the instance templates

1. Navigate to **templates**, and then click **Create instance template**
2. For Name, type us-west3-b-template.
3. For Series, select E2
4. click advance
   1. Service accounts: Compute Engine default service account
   2. Accces scopes: Allow default access
5. Click the **Management** tab.
   1. Under **Metadata**, click + **ADD ITEM** and specify the following
   2. startup-script-url 	gs://cloud-training/gcpnet/httplb/startup.sh
6. Click **Networking**
   1. Network tags 	http-server
   2. Network 	default
   3. Subnetwork 	default(us-west3)
7. Done


8. Click on us-west3-template, and then click on the Copy
9. For Name, type europe-west1-template
10. **http-server** is added as a network tag
11. Subnetwork, select **default (europe-west1)**
12. Done
13. Create


### 3.2.2. Create the managed instance groups

us-west3
1. Compute Engine, click Instance groups
   1. Name 	us-west3-mig
   2. Instance template 	us-west3-template
   3. Location 	Multiple zones
   4. Region 	us-west3
   5. Minimum number of instances 	1
   6. Maximum number of instances 	5
   7. Autoscaling > Autoscaling metrics > Click dropdown > Metric type 	CPU utilization
      1. Target CPU utilization 	80, click Done.
      2. Cool-down period 	45
   
europe-west1
1. Name 	europe-west1-mig
2. Location 	Multiple zones
3. Region 	europe-west1
4. Instance template 	europe-west1-template
5. Autoscaling > Autoscaling metrics > Click dropdown > Metric
   1. type 	CPU utilization
   2. Target CPU utilization 	80, click Done.
6. Cool-down period 	45
7. Minimum number of instances 	1
8. Maximum number of instances 	5

### 3.2.3. Verify the backends

    identify the region of the backend
      Hostname
      Server Location

## 3.3. Configure the HTTP Load Balancer
Start the configuration
1. Navigate to Load balancing, and then click Create load balancer
2. Under HTTP(S) Load Balancing, click on Start configuration.
3. Select From Internet to my VMs or serverless services, and click Continue.
4. Set the Name to http-lb

Configure the backend
   1. Create a backend service
   2. Name 	http-backend
   3. Instance group 	us-west1-mig
   4. Port numbers 	80
   5. Balancing mode 	Rate
   6. Maximum RPS 	50
   7. Capacity 	100
   8. Done
5. Add backend
   1. Instance group 	europe-west1-mig
   2. Port numbers 	80
   3. Balancing mode 	Utilization
   4. Maximum backend utilization 	80
   5. Capacity 	100
   6. Done
6. Health Check, select Create a health check
   1. Name 	http-health-check
   2. Protocol 	TCP
   3. Port 	80
7. Save
8. Check the Enable Logging box Sample Rate to 1
9.  Create to create the backend service.

Configure the frontend
1. ipv4
   1. Protocol 	HTTP
   2. IP version 	IPv4
   3. IP address 	Ephemeral
   4. Port 	80
2. Add Frontend IP and port
3. ipv6
   1. Protocol 	HTTP
   2. IP version 	IPv6
   3. IP address 	Ephemeral
   4. Port 	80
4. Done
5. Review and create the HTTP Load Balancer
6. Click on Create.

## 3.4. Test the HTTP Load Balancer

### 3.4.1. Access the HTTP Load Balancer
http:// [LB_IP_v4]  replace [LB_IP_v4] with the IPv4 address of the load balancer

### 3.4.2. Stress test the HTTP Load Balancer
1. Navigate to VM instances.
2. create
   1. Name 	siege-vm
   2. Region 	us-central1
   3. Zone 	us-central1-a
   4. Series 	N1
   5. create
3. On SSh 
   1. sudo apt-get -y install siege
   2. export LB_IP=[LB_IP_v4]
   3. export LB_IP=34.136.73.52
   4. siege -c 250 -t150s http://$LB_IP
4. Navigate to Load balancing.
5. Navigate to Backends> http-backend> http-lb> **Monitoring**

## 3.5. Denylist the siege-vm
1. Navigate to **Cloud Armor**
2. create Create policy
   1. Name 	denylist-siege
   2. Default rule action 	Allow
3. Next step
4. Add rule
   1. Condition > Match 	Enter the external IP SIEGE
   2. Action 	Deny
   3. Deny status 	403 (Forbidden)
   4. Priority 	1000
5. Next step
6. Add Target
7. For Type, select **Load balancer backend service**
8. For Target, select **http-backend**
9. Create policy
  

### 3.5.1. Verify the security policy
1. Return to the SSH terminal of siege-vm.
2. curl http://$LB_IP       403 Forbidden error
3. siege -c 250 -t150s http://$LB_IP      deny rule
4. Navigate to **Cloud Armor**
5. click denylist-siege
6. Click Logs.
7. Click View policy logs.
   1. On the Logging page, make sure to clear all the text in the Query preview. Select resource to Cloud HTTP Load Balancer > http-lb-forwarding-rule > http-lb then click Add.
8. Now click Run Query.
9. Expand a log entry in Query results.
10. Expand httpRequest.
    1.  The request should be from the siege-vm IP address. If not, expand another log entry.
11. Expand jsonPayload.
12. Expand enforcedSecurityPolicy.

# 4. Create an Internal Load Balancer 
Google Cloud offers Internal Load Balancing for your TCP/UDP-based traffic. Internal Load Balancing enables you to run and scale your services behind a private load balancing IP address that is accessible only to your internal virtual machine instances.

    Create HTTP and health check firewall rules

    Configure two instance templates

    Create two managed instance groups

    Configure and test an internal load balancer

## 4.1. Configure HTTP and health check firewall rules

### 4.1.1. Explore the my-internal-app network
1. Navigate to VPC networks
2. Scroll down and notice the my-internal-app network with its subnets: subnet-a and subnet-b

### 4.1.2. Create the HTTP firewall rule

1. Still in VPC network, in the left pane click **Firewall**.
2. Click Create Firewall Rule
   1. Name 	app-allow-http
   2. Network 	my-internal-app
   3. Targets 	Specified target tags
   4. Target tags 	lb-backend
   5. Source filter 	IPv4 Ranges
   6. Source IPv4 ranges 	0.0.0.0/0
   7. Protocols and ports 	Specified protocols and ports, and then check tcp, type: 80
3. Create

### 4.1.3. Create the health check firewall rules
1. Click Create Firewall Rule
   1. Name 	app-allow-health-check
   2. Targets 	Specified target tags
   3. Target tags 	lb-backend
   4. Source filter 	IPv4 Ranges
   5. Source IPv4 ranges 	130.211.0.0/22 and 35.191.0.0/16
   6. Protocols and ports 	Specified protocols and ports, and then check tcp
2. Create

## 4.2. Configure instance templates and create instance groups

### 4.2.1. Configure the instance templates
1. Navigate to **Instance templates**
2. Create instance template.
   1. Name, type instance-template-1
   2. Series, select N1
   3. Network tags, specify lb-backend.
   4. Network interfaces
      1. Network 	my-internal-app
      2. Subnetwork 	subnet-a
      3. Done
   5. Click Management.
      1. Metadata
      2. startup-script-url 	gs://cloud-training/gcpnet/ilb/startup.sh
3. Create

### 4.2.2. Configure the next instance template
1. check the box next to instance-template-1, then click Copy
2. Named instance-template-2.
   1. Select subnet-b as the Subnetwork.
   2. Done
3. Create

### 4.2.3. Create the managed instance groups

1. Compute Engine, in the left pane click Instance groups, and then click Create Instance group
   1. Name 	instance-group-1
   2. Instance template 	instance-template-1
   3. Location 	Single-zone
   4. Region 	us-central1
   5. Zone 	us-central1-a
   6. Autoscaling > Minimum number of instances 	1
   7. Autoscaling > Maximum number of instances 	5
   8. Autoscaling > Autoscaling metrics (click the dropdown icon to edit) > Metric type 	CPU utilization
   9. Target CPU utilization 	80
   10. Cool-down period 	45
   11. Create
2.  again
    1.  Name 	instance-group-2
    2.  Instance template 	instance-template-2
    3.  Location 	Single-zone
    4.  Region 	us-central1
    5.  Zone 	us-central1-b
    6.  Autoscaling > Minimum number of instances 	1
    7.  Autoscaling > Maximum number of instances 	5
    8.  Autoscaling > Autoscaling metrics (click the dropdown icon to edit) > Metric type 	CPU utilization
    9.  Target CPU utilization 	80
    10. Cool-down period 	45

### 4.2.4. Verify the backends
1. VM instances.
2. Click Create instance
   1. Name 	utility-vm
   2. Region 	us-central1
   3. Zone 	us-central1-f
   4. Series 	N1
   5. Machine type 	f1-micro (1 shared vCPU)
   6. Network
      1. Network 	my-internal-app
      2. Subnetwork 	subnet-a
      3. Primary internal IP 	Ephemeral (Custom)
      4. Custom ephemeral IP address 	10.10.20.50
3. Done and then click Create
4. click SSH 
   1. curl 10.10.20.2
   2. curl 10.10.30.2

 identify the location of the backend

    Server Hostname
    Server Location

## 4.3. Configure the Internal Load Balancer

1. Navigate to Load balancing, and then click Create load balancer
2. **TCP Load Balancing**
3. For Internet facing or internal only, select Only between my VMs.
   1. Name, type my-ilb
   2. Region, select us-central1
   3. Network, select my-internal-app

Configure the regional backend service
1. Backend configuration
2. instance-group-1 (us-central1-a)
3. Add backend.
4. instance-group-2 (us-central1-b).
5. Health Check, select Create a health check.
   1. Name 	my-ilb-health-check
   2. Protocol 	TCP
   3. Port 	80
6. Click Save.
7. Click Done.

Configure the frontend
1. subnet-b
2. Internal IP 	Under IP address select Create IP address
   1. Name 	my-ilb-ip
   2. Static IP address 	Let me choose
   3. Custom IP address 	10.10.30.5
3. Click Reserve.
4. In Port number, type 80.
5. Click Done .

Review and create the Internal Load Balancer
1. Click on Create.

## 4.4. Test the Internal Load Balancer

Access the Internal Load Balancer
1. For utility-vm, click SSH
   1. curl 10.10.30.5


# 5. Cloud Monitoring

## 5.1. Create a Compute Engine instance
1. Navigate to VM instances, then click **Create instance**
   1. Name 	lamp-1-vm
   2. Region 	us-central1
   3. Zone 	us-central1-a
   4. Series 	N1
   5. Machine type 	n1-standard-2
   6. Boot disk 	Click Change. Select version Debian GNU/Linux 10 (buster) for Debian OS and click Select.
   7. Firewall 	check Allow HTTP traffic
2. Click Create.


## 5.2. Add Apache2 HTTP Server to your instance
1. click SSH 
2. Connect
   1. If prompted, click Connect without Identity-Aware Proxy
   2. sudo apt-get update
   3. sudo apt-get install apache2 php7.0
   4. sudo service apache2 restart
3. Return to the Cloud Console, on the VM instances page. Click the External IP
   
### 5.2.1. Create a Monitoring Metrics Scope
The following steps create a new account that has a free trial of Monitoring.

1. Navigate to  Monitoring

### 5.2.2. Install the Ops agents

1. Run the Monitoring agent install script command in the SSH terminal of your VM instance to install the Cloud Monitoring agent.
   1. curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
   2. sudo bash add-google-cloud-ops-agent-repo.sh --also-install
   3. Verify that the agent is working
      1. sudo systemctl status google-cloud-ops-agent"*"


## 5.3. Create an uptime check
1. In the Cloud Console, in the left menu, click Uptime checks, and then click +Create Uptime Check
   1. Title: Lamp Uptime Check, then click Next.
   2. Protocol: HTTP
   3. Resource Type: Instance
   4. Applies to: Single, lamp-1-vm
   5. Path: leave at default
   6. Check Frequency: 1 min
2. Click on Next to leave the other details to default and click Test to verify that your uptime check can connect to the resource.
3. When you see a green check mark everything can connect. Click **Create**.

## 5.4. Create an alerting policy
1. click Alerting, and then click +Create Policy
2. Click on Select a metric dropdown. Disable the **Show only active resources & metrics**
3.  Network traffic in filter by resource and metric name and click on VM instance > interface. Select **Network traffic** and click **Apply**
    1.  Click **Next**.
    2.  Set the Threshold position to Above threshold, Threshold value to **500** and Advanced Options > Retest window to **1 min**. Click **Next**.
    3.  Click on drop down arrow next to Notification Channels, then click on **Manage Notification Channels**.
        1.  ADD NEW for Email.
        2.  enter your personal email address in the **Email Address** field and a **Display name**. **SAVE**
    4. Go back to the previous Create alerting policy tab. Select the new and **ok**
    5. **Add a message** in documentation, which will be included in the emailed alert.
    6. Mention the Alert name as **Inbound Traffic Alert**.
    7. Click **Next**.
    8. Review the alert and click Create Policy


## 5.5. Create a dashboard and chart
1. In the left menu select Dashboards, and then +C**reate Dashboard**.
2. Name the dashboard **Cloud Monitoring LAMP Qwik Start Dashboard**


### 5.5.1. Add the first chart
1. Click **Line** option in Chart library.
2. Name the chart title **CPU Load**.
3. Click on **Resource & Metric** dropdown. Disable the **Show only active resources & metrics**.
4. **Type** CPU load (1m) in filter by resource and metric name and click on VM instance > Cpu. Select CPU load (1m) and click **Apply**.


## 5.6. View your logs
1. Select Navigation menu > Logging > Logs Explorer.
2. Select the logs you want to see, in this case, you select the logs for the lamp-1-vm instance you created at the start of this lab
3. Click on **Resource**
4. Select VM Instance > lamp-1-vm
   1. Click Apply.
   2. Leave the other fields with their default values.
   3. Click the Stream logs.


### 5.6.1. Check out what happens when you start and stop the VM instance.
To best see how Cloud Monitoring and Cloud Logging reflect VM instance changes

1. Open the Compute Engine window in a new browser window. Select Navigation menu > Compute Engine, right-click VM instances > Open link in new window.
2. Move the Logs Viewer browser window next to the Compute Engine window. This makes it easier to view how changes to the VM are reflected in the logs
3. In the Compute Engine window, select the lamp-1-vm instance, click the three vertical dots at the top of the screen and then click **Stop**, and then confirm to stop the instance
4. In the VM instance details window, click the three vertical dots at the top of the screen and then click Start/resume


## 5.7. Check the uptime check results and triggered alerts
1. Navigate to Uptime checks
   1. Since you have just restarted your instance, the regions are in a failed status. It may take up to 5 minutes for the regions to become active. Reload your browser window as necessary until the regions are active.
2. Click the name of the uptime check, Lamp Uptime Check


### 5.7.1. Check if alerts have been triggered

1. In the left menu, click Alerting.
2. You see incidents and events listed in the Alerting window
3. Check your email account. You should see Cloud Monitoring Alerts.


## 5.8. (Optional) Remove your alerting policy
If you set up an email alert as part of your alerting policy, there is a chance that you will receive a few emails about your resources even after the lab is completed.

To avoid this, remove the alerting policy before you complete your lab.










