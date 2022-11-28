
- [1. Create a Virtual Machine](#1-create-a-virtual-machine)
  - [1.1. Configure Name PROJECT_ID](#11-configure-name-project_id)
  - [1.2. Configure environment](#12-configure-environment)
  - [1.3. Setting environment variables](#13-setting-environment-variables)
  - [1.4. Creating a virtual machine with the gcloud tool](#14-creating-a-virtual-machine-with-the-gcloud-tool)
  - [1.5. GCloud commands](#15-gcloud-commands)
  - [1.6. Connecting to your VM instance](#16-connecting-to-your-vm-instance)
  - [1.7. View Logs](#17-view-logs)
- [2. App Engine: Python](#2-app-engine-python)
  - [2.1. Enable Google App Engine Admin API](#21-enable-google-app-engine-admin-api)
  - [2.2. Download the Hello World app](#22-download-the-hello-world-app)
  - [2.3. Test the application](#23-test-the-application)
  - [2.4. Make a change](#24-make-a-change)
  - [2.5. Deploy your app](#25-deploy-your-app)
  - [2.6. View your application](#26-view-your-application)
- [3. Cloud Functions: Command Line](#3-cloud-functions-command-line)
  - [3.1. Create a function](#31-create-a-function)
  - [3.2. Create a cloud storage bucket](#32-create-a-cloud-storage-bucket)
  - [3.3. Deploy your function](#33-deploy-your-function)
  - [3.4. Test the function](#34-test-the-function)
  - [3.5. View logs](#35-view-logs)
- [4. Kubernetes Engine](#4-kubernetes-engine)
  - [4.1. Set a default compute zone](#41-set-a-default-compute-zone)
  - [4.2. Create a GKE cluster](#42-create-a-gke-cluster)
  - [4.3. Get authentication credentials for the cluster](#43-get-authentication-credentials-for-the-cluster)
  - [4.4. Deploy an application to the cluster](#44-deploy-an-application-to-the-cluster)
  - [4.5. Deleting the cluster](#45-deleting-the-cluster)
- [5. Set Up Network and HTTP Load Balancers](#5-set-up-network-and-http-load-balancers)
  - [5.1. Configure Name PROJECT_ID](#51-configure-name-project_id)
  - [5.2. Configure environment](#52-configure-environment)
  - [5.3. Create multiple web server instances](#53-create-multiple-web-server-instances)
  - [5.4. Configure the load balancing service](#54-configure-the-load-balancing-service)
  - [5.5. Sending traffic to your instances](#55-sending-traffic-to-your-instances)
  - [5.6. Create an HTTP load balancer](#56-create-an-http-load-balancer)
  - [5.7. Testing traffic sent to your instances](#57-testing-traffic-sent-to-your-instances)

# 1. Create a Virtual Machine

## 1.1. Configure Name PROJECT_ID
copy name of GCI PROJECT_ID

list the active account name
> gcloud auth list

list the project ID 
> gcloud config list project

## 1.2. Configure environment

Region
> gcloud config set compute/region 
> 
> gcloud config get-value compute/region

Zone
> gcloud config set compute/zone 
> 
> gcloud config get-value compute/zone


## 1.3. Setting environment variables
Create an environment variable to store your Project ID:
> export PROJECT_ID=$(gcloud config get-value project)

Create an environment variable to store your Zone:
> export ZONE=$(gcloud config get-value compute/zone)

verify that your variables were set properly
> echo -e "PROJECT ID: $PROJECT_ID\nZONE: $ZONE"

## 1.4. Creating a virtual machine with the gcloud tool
create your VM
> gcloud compute instances create gcelab2 --machine-type e2-medium --zone $ZONE


## 1.5. GCloud commands

Help
> gcloud -h
> 
> gcloud config --help
> 
> gcloud help config

Enviroment configurations
> gcloud config list
> 
> gcloud config list --all
> 
> gcloud components list

Compute instance available in the projec
> gcloud compute instances list
> 
> gcloud compute instances list --filter="name=('gcelab2')"
> 
> gcloud compute firewall-rules list
> 
> gcloud compute firewall-rules list --filter="network='default'"
> 
> gcloud compute firewall-rules list --filter="NETWORK:'default' AND ALLOW:'icmp'"

## 1.6. Connecting to your VM instance

Connect to your VM with SSH
> gcloud compute ssh gcelab2 --zone $ZONE

type Y

Press Enter twice

The prompt now says something similar to: **sa_107021519685252337470@gcelab2**
- The reference **before** the @ indicates the account being used.
- **After** the @ sign indicates the host machine being accessed

Install nginx on VM
> sudo apt install -y nginx

exit


List the firewall rules for the project
> gcloud compute firewall-rules list

Add a tag to VM
> gcloud compute instances add-tags gcelab2 --tags http-server,https-server

Update the firewall rule to allow
> gcloud compute firewall-rules create default-allow-http --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=http-server

List the firewall rules
> gcloud compute firewall-rules list --filter=ALLOW:'80'

Verify communication 
> curl http://$(gcloud compute instances list --filter=name:gcelab2 --format='value(EXTERNAL_IP)')

## 1.7. View Logs
View the available logs 
> gcloud logging logs list

> gcloud logging logs list --filter="compute"

> gcloud logging read "resource.type=gce_instance" --limit 5

> gcloud logging read "resource.type=gce_instance AND labels.instance_name='gcelab2'" --limit 5

# 2. App Engine: Python

## 2.1. Enable Google App Engine Admin API

- 1- In the left Navigation menu, click APIs & Services > Library.
- Type "App Engine Admin API"
- Click Enable

## 2.2. Download the Hello World app

copy the Hello World sample app repository 
> git clone https://github.com/GoogleCloudPlatform/python-docs-samples.git

Go to the directory
> cd python-docs-samples/appengine/standard_python3/hello_world

## 2.3. Test the application
start the Google Cloud development server
> dev_appserver.py app.yaml

View the results by clicking the **Web preview** > Preview on port 8080

## 2.4. Make a change

> cd python-docs-samples/appengine/standard_python3/hello_world
> 
> nano main.py
> 
> Change "Hello World!" to "Hello, Cruel World!"

## 2.5. Deploy your app

where the app.yaml file is located run
> gcloud app deploy

If you receive an error as "Unable to retrieve P4SA" while deploying the app,**re-run the command**

## 2.6. View your application

> gcloud app browse

# 3. Cloud Functions: Command Line

## 3.1. Create a function

> mkdir gcf_hello_world
> 
> cd gcf_hello_world
> 
> nano index.js

## 3.2. Create a cloud storage bucket

> gsutil mb -p [PROJECT_ID] gs://[BUCKET_NAME]

## 3.3. Deploy your function
When deploying a new function, you must specify --trigger-topic, --trigger-bucket, or --trigger-http

> gcloud functions deploy helloWorld \
  --stage-bucket [BUCKET_NAME] \
  --trigger-topic hello_world \
  --runtime nodejs8

Verify the status of the function
> gcloud functions describe helloWorld

## 3.4. Test the function
Enter this command to create a message test of the function
> DATA=$(printf 'Hello World!'|base64) && gcloud functions call helloWorld --data '{"data":"'$DATA'"}'

## 3.5. View logs
> gcloud functions logs read helloWorld

# 4. Kubernetes Engine

## 4.1. Set a default compute zone

> gcloud config set compute/region us-west3
> 
> gcloud config set compute/zone us-west3-c

## 4.2. Create a GKE cluster

Create a cluster
> gcloud container clusters create --machine-type=e2-medium lab-cluster 

## 4.3. Get authentication credentials for the cluster

Authenticate with the cluster
> gcloud container clusters get-credentials lab-cluster 

## 4.4. Deploy an application to the cluster

create a new Deployment hello-server from the hello-app container image, run the following kubectl create command
> kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0

create a Kubernetes Service
> kubectl expose deployment hello-server --type=LoadBalancer --port 8080

inspect the hello-server
> kubectl get service

open a new tab and enter the following address, replacing [EXTERNAL IP] with the EXTERNAL-IP for hello-server
> http://[EXTERNAL-IP]:8080


## 4.5. Deleting the cluster
> gcloud container clusters delete lab-cluster 


# 5. Set Up Network and HTTP Load Balancers


## 5.1. Configure Name PROJECT_ID
copy name of GCI PROJECT_ID

list the active account name
> gcloud auth list

list the project ID 
> gcloud config list project

## 5.2. Configure environment

Region
> gcloud config set compute/region 
> 
> gcloud config get-value compute/region

Zone
> gcloud config set compute/zone 
> 
> gcloud config get-value compute/zone

## 5.3. Create multiple web server instances
Create a virtual machine www1 in your default zone.
> gcloud compute instances create www1 \
    --zone=us-central1-c \
    --tags=network-lb-tag \
    --machine-type=e2-medium \
    --image-family=debian-11 \
    --image-project=debian-cloud \
    --metadata=startup-script='#!/bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo "
<h3>Web Server: www1</h3>" | tee /var/www/html/index.html'

Create a virtual machine www2 in your default zone
>   gcloud compute instances create www2 \
    --zone=us-central1-c \
    --tags=network-lb-tag \
    --machine-type=e2-medium \
    --image-family=debian-11 \
    --image-project=debian-cloud \
    --metadata=startup-script='#!/bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo "
<h3>Web Server: www2</h3>" | tee /var/www/html/index.html'

Create a virtual machine www3 in your default zone.
> gcloud compute instances create www3 \
    --zone=us-central1-c \
    --tags=network-lb-tag \
    --machine-type=e2-medium \
    --image-family=debian-11 \
    --image-project=debian-cloud \
    --metadata=startup-script='#!/bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo "
<h3>Web Server: www3</h3>" | tee /var/www/html/index.html'


Create a firewall rule to allow external traffic to the VM instances:
> gcloud compute firewall-rules create www-firewall-network-lb \
    --target-tags network-lb-tag --allow tcp:80

Run the following to list your instances. You'll see their IP addresses in the EXTERNAL_IP
> gcloud compute instances list

Verify that each instance is running with curl, replacing [IP_ADDRESS] 
> curl http://[IP_ADDRESS]

## 5.4. Configure the load balancing service

Create a static external IP address for your load balancer:
> gcloud compute addresses create network-lb-ip-1 \
    --region us-central1 

Add a legacy HTTP health check resource:
> gcloud compute http-health-checks create basic-check


Create the target pool and use the health check, which is required for the service to function
> gcloud compute target-pools create www-pool \
    --region us-central1 --http-health-check basic-check

Add the instances to the pool:
> gcloud compute target-pools add-instances www-pool \
    --instances www1,www2,www3

forwarding rule
> gcloud compute forwarding-rules create www-rule \
    --region  us-central1 \
    --ports 80 \
    --address network-lb-ip-1 \
    --target-pool www-pool

## 5.5. Sending traffic to your instances

view the external IP address of the www-rule forwarding rule used by the load balancer
> gcloud compute forwarding-rules describe www-rule --region us-central1

Access the external IP address
> IPADDRESS=$(gcloud compute forwarding-rules describe www-rule --region us-central1 --format="json" | jq -r .IPAddress)

Show the external IP address
> echo $IPADDRESS

access the external IP address, replacing IP_ADDRESS with an external IP address from the previous command
> while true; do curl -m1 $IPADDRESS; done

## 5.6. Create an HTTP load balancer

create the load balancer template:
> gcloud compute instance-templates create lb-backend-template \
   --region=us-central1 \
   --network=default \
   --subnet=default \
   --tags=allow-health-check \
   --machine-type=e2-medium \
   --image-family=debian-11 \
   --image-project=debian-cloud \
   --metadata=startup-script='#!/bin/bash
     apt-get update
     apt-get install apache2 -y
     a2ensite default-ssl
     a2enmod ssl
     vm_hostname="$(curl -H "Metadata-Flavor:Google" \
     http://169.254.169.254/computeMetadata/v1/instance/name)"
     echo "Page served from: $vm_hostname" | \
     tee /var/www/html/index.html
     systemctl restart apache2'

managed instance group based on the template
> gcloud compute instance-groups managed create lb-backend-group \
   --template=lb-backend-template --size=2 --zone=us-central1-c 

Create the fw-allow-health-check firewall rule
> gcloud compute firewall-rules create fw-allow-health-check \
  --network=default \
  --action=allow \
  --direction=ingress \
  --source-ranges=130.211.0.0/22,35.191.0.0/16 \
  --target-tags=allow-health-check \
  --rules=tcp:80

set up a global static external IP address that your customers use to reach your load balancer
> gcloud compute addresses create lb-ipv4-1 \
  --ip-version=IPV4 \
  --global

Note the IPv4 address that was reserved
> gcloud compute addresses describe lb-ipv4-1 \
  --format="get(address)" \
  --global

Create a health check for the load balancer:
> gcloud compute health-checks create http http-basic-check \
  --port 80

Create a backend service
> gcloud compute backend-services create web-backend-service \
  --protocol=HTTP \
  --port-name=http \
  --health-checks=http-basic-check \
  --global

Add your instance group as the backend to the backend service
> gcloud compute backend-services add-backend web-backend-service \
  --instance-group=lb-backend-group \
  --instance-group-zone=us-central1-c \
  --global

Create a URL map to route the incoming requests to the default backend service:
> gcloud compute url-maps create web-map-http \
    --default-service web-backend-service

Create a target HTTP proxy to route requests to your URL map
> gcloud compute target-http-proxies create http-lb-proxy \
    --url-map web-map-http

Create a global forwarding rule to route incoming requests to the proxy
> gcloud compute forwarding-rules create http-content-rule \
    --address=lb-ipv4-1\
    --global \
    --target-http-proxy=http-lb-proxy \
    --ports=80

## 5.7. Testing traffic sent to your instances

1. Search  Load balancing
2. Click on the load balancer that you just created (web-map-http).
3. Backend section, click on the name of the backend and confirm that the VMs are Healthy.
4. When the VMs are healthy, test the load balancer using a web browser, going to http://IP_ADDRESS/, replacing IP_ADDRESS with the load balancer's IP address.



