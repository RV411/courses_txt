- [1. Cloud Storage: CLI/SDK](#1-cloud-storage-clisdk)
  - [1.1. Create a bucket](#11-create-a-bucket)
  - [1.2. Upload an object into your bucket](#12-upload-an-object-into-your-bucket)
  - [1.3. Download an object from your bucket](#13-download-an-object-from-your-bucket)
  - [1.4. Copy an object to a folder in the bucket](#14-copy-an-object-to-a-folder-in-the-bucket)
  - [1.5. List contents of a bucket or folder](#15-list-contents-of-a-bucket-or-folder)
  - [1.6. List details for an object](#16-list-details-for-an-object)
  - [1.7. Make your object publicly accessible](#17-make-your-object-publicly-accessible)
  - [1.8. Remove public access](#18-remove-public-access)
- [2. Create a Cloud SQL instance](#2-create-a-cloud-sql-instance)
  - [2.1. Connect to your instance using the mysql client in Cloud Shell](#21-connect-to-your-instance-using-the-mysql-client-in-cloud-shell)
  - [2.2. Create a database and upload data](#22-create-a-database-and-upload-data)
- [3. Cloud Endpoints](#3-cloud-endpoints)
  - [3.1. Getting the sample code](#31-getting-the-sample-code)
  - [3.2. Deploying the Endpoints configuration](#32-deploying-the-endpoints-configuration)
  - [3.3. Deploying the API backend](#33-deploying-the-api-backend)
  - [3.4. Sending requests to the API](#34-sending-requests-to-the-api)
  - [3.5. Tracking API activity](#35-tracking-api-activity)
  - [3.6. Add a quota to the API](#36-add-a-quota-to-the-api)
- [4. Google Cloud Pub/Sub: Python](#4-google-cloud-pubsub-python)
  - [4.1. Create a virtual environment](#41-create-a-virtual-environment)
  - [4.2. Install the client library](#42-install-the-client-library)
  - [4.3. Pub/Sub - the Basics](#43-pubsub---the-basics)
  - [4.4. Create a topic](#44-create-a-topic)
  - [4.5. Create a subscription](#45-create-a-subscription)
  - [4.6. Publish messages](#46-publish-messages)
  - [4.7. View messages](#47-view-messages)
- [5. User Authentication: Identity-Aware Proxy](#5-user-authentication-identity-aware-proxy)
  - [5.1. Download the code](#51-download-the-code)
  - [5.2. Deploy the application and protect it with IAP](#52-deploy-the-application-and-protect-it-with-iap)
  - [5.3. Deploy to App Engine](#53-deploy-to-app-engine)
  - [5.4. Restrict access with IAP](#54-restrict-access-with-iap)
  - [5.5. Test that IAP is turned on](#55-test-that-iap-is-turned-on)
  - [5.6. Access user identity information](#56-access-user-identity-information)
  - [5.7. Turn off IAP](#57-turn-off-iap)
  - [5.8. Use Cryptographic Verification](#58-use-cryptographic-verification)
  - [5.9. Examine the application files](#59-examine-the-application-files)
- [6. Cloud IAM](#6-cloud-iam)
  - [6.1. Now switch to the Username 1](#61-now-switch-to-the-username-1)
  - [6.2. Now switch to the Username 2](#62-now-switch-to-the-username-2)
  - [6.3. Prepare a resource for access testing](#63-prepare-a-resource-for-access-testing)
  - [6.4. Remove project access](#64-remove-project-access)
  - [6.5. Add Storage permissions](#65-add-storage-permissions)
  - [6.6. Verify access](#66-verify-access)

# 1. Cloud Storage: CLI/SDK 

how to create a storage bucket, upload objects to it, create folders and subfolders in it, and make objects publicly accessible using the Google Cloud command line.

## 1.1. Create a bucket

1. Navigation menu > Cloud Storage > Buckets. Click CREATE BUCKET.
2. Name your bucket
3. Click CONTINUE.
4. Location type to **Multi-region**
5. Location to **us (multiple regions in United States)**
6. CONTINUE
7. Default Storage class to **Standard**
8. CONTINUE
9. If needed, uncheck Enforce public access prevention on this bucket under Prevent public access
10. check Fine-grained under Access Control.
11. CONTINUE
12. Scroll to the bottom and click CREATE

## 1.2. Upload an object into your bucket

download this image (ada.jpg) into your bucket, enter this command into Cloud Shell:
> curl https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Ada_Lovelace_portrait.jpg/800px-Ada_Lovelace_portrait.jpg --output ada.jpg

Use the gsutil cp command to upload the image from the location where you saved it to the bucket you created:
> gsutil cp ada.jpg gs://first-bucket-rv411

Now remove the downloaded image:
> rm ada.jpg

##  1.3. Download an object from your bucket
Use the gsutil cp command to download the image you stored in your bucket to Cloud Shell:
> gsutil cp -r gs://first-bucket-rv411/ada.jpg .

## 1.4. Copy an object to a folder in the bucket

> gsutil cp gs://first-bucket-rv411/ada.jpg gs://first-bucket-rv411/image-folder/



## 1.5. List contents of a bucket or folder

> gsutil ls gs://first-bucket-rv411

## 1.6. List details for an object

> gsutil ls -l gs://first-bucket-rv411/ada.jpg


## 1.7. Make your object publicly accessible

> gsutil acl ch -u AllUsers:R gs://first-bucket-rv411/ada.jpg

## 1.8. Remove public access

> gsutil acl ch -d AllUsers gs://first-bucket-rv411/ada.jpg

# 2. Create a Cloud SQL instance

1. click on SQL
2. Click Create Instance
   1. Click choose MySQL
   2. Type "myinstance" for Instance ID
   3. In the password field click on the Generate link and the eye icon to see the password. Save the password to use in the next section. `Rx(2,gH9&U1IP;7
   4. Leave all other fields at the default values.
3. Click Create Instance.

## 2.1. Connect to your instance using the mysql client in Cloud Shell
> gcloud sql connect myinstance --user=root

## 2.2. Create a database and upload data
> CREATE DATABASE guestbook;
> 
> USE guestbook;
> 
> CREATE TABLE entries (guestName VARCHAR(255), content VARCHAR(255),
    entryID INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(entryID));
    INSERT INTO entries (guestName, content) values ("first guest", "I got here!");
INSERT INTO entries (guestName, content) values ("second guest", "Me too!");
>
> SELECT * FROM entries;


# 3. Cloud Endpoints

## 3.1. Getting the sample code
Get the sample API and scripts:
> gsutil cp gs://spls/gsp164/endpoints-quickstart.zip .
unzip endpoints-quickstart.zip

> cd endpoints-quickstart

## 3.2. Deploying the Endpoints configuration
The lab's sample API comes with a pre-configured OpenAPI file called openapi.yaml.

To use Endpoints to manage an API, you deploy the API's OpenAPI configuration to Service Management.

In the endpoints-qwikstart 
> cd scripts

> ./deploy_api.sh

## 3.3. Deploying the API backend
To deploy the API backend, make sure you are in the endpoints-quickstart/scripts directory.
> ./deploy_app.sh
(The script runs the following command to create an App Engine flexible environment in the us-central region: gcloud app create --region="$REGION")

## 3.4. Sending requests to the API
After deploying the sample API,
> ./query_api.sh

To test
> ./query_api.sh JFK

## 3.5. Tracking API activity
Run this traffic generation script in Cloud Shell to populate the graphs and logs
> ./generate_traffic.sh


    In the Console, click on Endpoints in the Tools section to look at the activity graphs for your API. It may take a few moments for the requests to be reflected in the graphs. You can do this while you wait for data to be displayed:

    If the Permissions side panel is not open, click +Permissions. The Permissions panel allows you to control who has access to your API and the level of access.

    Click the Deployment history tab. This tab displays a history of your API deployments, including the deployment time and who deployed the change.

    Click the Overview tab. Here you'll see the traffic coming in. After the traffic generation script has been running for a minute, scroll down to see the three lines on the Total latency graph (50th, 95th, and 98th percentiles). This data provides a quick estimate of response times.

    At the bottom of the Endpoints graphs, under Method, click the View all logs link for GET/airportName. The Logs Viewer page displays the request logs for the API.

    Enter CTRL+C in Cloud Shell to stop the script.




## 3.6. Add a quota to the API
    Cloud Endpoints lets you set quotas so you can control the rate at which applications can call your API. Quotas can be used to protect your API from excessive usage by a single client.

> ./deploy_api.sh ../openapi_with_ratelimit.yaml

Redeploy your app to use the new Endpoints configuration 
> ./deploy_app.sh

In the Console, navigate to Navigation menu > API & Services > Credentials.

Click Create credentials and choose API key. A new API key is displayed on the screen.
> AIzaSyAKKElHs9FjWc8KRiu4BbPBTaKwIPlEZLk

Click the double rectangle icon to copy it to your clipboard.

In Cloud Shell, type the following. Replace YOUR-API-KEY with the API key you just created:
> export API_KEY=AIzaSyAKKElHs9FjWc8KRiu4BbPBTaKwIPlEZLk


Send your API a request using the API key variable you just created
> ./query_api_with_key.sh $API_KEY

The API now has a limit of 5 requests per second. Run the following command to send traffic to the API and trigger the quota limit:
> ./generate_traffic_with_key.sh $API_KEY

After running the script for 5-10 seconds, enter CTRL+C in Cloud Shell to stop the script.

Send another authenticated request to the API:
> ./query_api_with_key.sh $API_KEY


# 4. Google Cloud Pub/Sub: Python


##  4.1. Create a virtual environment
> apt-get install -y virtualenv

> python3 -m venv venv

> source venv/bin/activate


## 4.2. Install the client library
> pip install --upgrade google-cloud-pubsub

> git clone https://github.com/googleapis/python-pubsub.git

> cd python-pubsub/samples/snippets

## 4.3. Pub/Sub - the Basics
    In sum, a publisher creates and sends messages to a topic and a subscriber creates a subscription to a topic to receive messages from it.

Pub/Sub comes preinstalled in the Cloud Shell, so there are no installations or configurations required to get started with this service.

## 4.4. Create a topic

> echo $GOOGLE_CLOUD_PROJECT

publisher.py is a script that demonstrates how to perform basic operations on topics with the Cloud Pub/Sub API. View the content of publisher script:
> cat publisher.py

For information about the publisher script:
> python publisher.py -h

Run the publisher script to create Pub/Sub Topic
> python publisher.py $GOOGLE_CLOUD_PROJECT create MyTopic

This command returns a list of all Pub/Sub topics in a given project:
> python publisher.py $GOOGLE_CLOUD_PROJECT list

Navigate to Navigation menu > Pub/Sub > Topics


## 4.5. Create a subscription
Create a Pub/Sub subscription for topic with subscriber.py script
> python subscriber.py $GOOGLE_CLOUD_PROJECT create MyTopic MySub

This command returns a list of subscribers in given project:
> python subscriber.py $GOOGLE_CLOUD_PROJECT list-in-project

For information about the subscriber script
> python subscriber.py -h

## 4.6. Publish messages
Publish the message "Hello" to MyTopic
> gcloud pubsub topics publish MyTopic --message "Hello"

Publish a few more messages to MyTopic—run the following commands (replacing <YOUR NAME> with your name and <FOOD> with a food you like to eat)
> gcloud pubsub topics publish MyTopic --message "Publisher's name is <YOUR NAME>"
> 
> gcloud pubsub topics publish MyTopic --message "Publisher likes to eat <FOOD>"
> 
> gcloud pubsub topics publish MyTopic --message "Publisher thinks Pub/Sub is awesome"

## 4.7. View messages

Use MySub to pull the message from MyTopic:
> python subscriber.py $GOOGLE_CLOUD_PROJECT receive MySub


#  5. User Authentication: Identity-Aware Proxy

If you only need to restrict access to selected users there are no changes necessary to the application. Should the application need to know the user's identity (such as for keeping user preferences server-side) Identity-Aware Proxy can provide that with minimal application code.

Identity-Aware Proxy (IAP) is a Google Cloud service that intercepts web requests sent to your application, authenticates the user making the request using the Google Identity Service, and only lets the requests through if they come from a user you authorize. In addition, it can modify the request headers to include information about the authenticated user.

## 5.1. Download the code
> gsutil cp gs://spls/gsp499/user-authentication-with-iap.zip .
> 
> unzip user-authentication-with-iap.zip
> 
> cd user-authentication-with-iap


## 5.2. Deploy the application and protect it with IAP

> cd 1-HelloWorld

> cat main.py

## 5.3. Deploy to App Engine
> gcloud app deploy

> gcloud app browse

## 5.4. Restrict access with IAP



1. In the cloud console window, click the Navigation menu Navigation menu icon > Security > Identity-Aware Proxy.
2. Click ENABLE API.
3. Click GO TO IDENTITY-AWARE PROXY.
4. Click CONFIGURE CONSENT SCREEN.
5. Select Internal under User Type and click Create.
6. Fill in the required blanks with appropriate values:

App name

    IAP Example

    User support email    Select your lab student email address from the dropdown.

    Application home page       The URL you used to view your app. You can find this again by running the gcloud app browse command in cloud shell again.

    Application privacy Policy link       The privacy page link in the app, same as the homepage link with /privacy added to the end

    Authorized domains       Click + ADD DOMAINThe hostname portion of the application's URL, e.g. iap-example-999999.appspot.com. You can see this in the address bar of the Hello World web page you previously opened. Do not include the starting https:// or trailing / from that URL.

    Developer Contact Information      Enter at least one email

7. Click SAVE AND CONTINUE.
8. For Scopes, click SAVE AND CONTINUE.
9. For Summary, click BACK TO DASHBOARD.
10. In Cloud Shell, run this command to disable the Flex API:
> gcloud services disable appengineflex.googleapis.com

11. Click TURN ON


## 5.5. Test that IAP is turned on

1. Click ADD PRINCIPAL.
2. Enter your Student email address.
3. Then, pick the Cloud IAP > IAP-Secured Web App User role to assign to that address.

## 5.6. Access user identity information

In Cloud Shell, change to the folder for this step:
> cd ~/user-authentication-with-iap/2-HelloUser

Since deployment takes a few minutes, start by deploying the app to the App Engine Standard environment for Python:
> gcloud app deploy

## 5.7. Turn off IAP

Since the application is now unprotected, a user could send a web request that appeared to have passed through IAP.
> curl -X GET https://qwiklabs-gcp-00-b4ad5af09f86.uw.r.appspot.com/ -H "X-Goog-Authenticated-User-Email: totally fake email"


## 5.8. Use Cryptographic Verification

> cd ~/user-authentication-with-iap/3-HelloVerifiedUser
> 
> gcloud app deploy

## 5.9. Examine the application files

The new functionality is primarily in the user() function:
>
    def user():
    assertion = request.headers.get('X-Goog-IAP-JWT-Assertion')
    if assertion is None:
        return None, None
    info = jwt.decode(
        assertion,
        keys(),
        algorithms=['ES256'],
        audience=audience()
    )
    return info['email'], info['sub']

> gcloud app browse


# 6. Cloud IAM
In this hands-on lab you learn how to assign a role to a second user and remove assigned roles associated with Cloud IAM. More specifically, you sign in with 2 different sets of credentials to experience how granting and revoking permissions works from Google Cloud Project Owner and Viewer roles.

## 6.1. Now switch to the Username 1

1. Return to the Username 1 Cloud Console page.
2. Select Navigation menu > IAM & Admin > IAM. You are now in the "IAM & Admin" console.
3. Click +ADD button at the top of the page
4. Scroll down to Basic and mouse over.

roles/viewer

    Permissions for read-only actions that do not affect state, such as viewing (but not modifying) existing resources or data.

roles/editor

    All viewer permissions, plus permissions for actions that modify state, such as changing existing resources.

roles/owner

    All editor permissions and permissions for the following actions:
    - Manage roles and permissions for a project and all resources within the project.
    - Set up billing for a project.

roles/browser

    Read access to browse the hierarchy for a project, including the folder, organization, and Cloud IAM policy. This role doesn't include permission to view resources in the project. 

5. Since you are able to manage roles and permissions for this project, Username 1 has Project owner permissions.
6. Click CANCEL to exit out of the "Add principal" panel.


## 6.2. Now switch to the Username 2 
 

1. Navigate to the IAM & Admin console, select Navigation menu > IAM & Admin > IAM.
2. Search through the table to find Username 1 and Username 2 and examine the roles they are granted. The Username 1 and Username 2 roles are listed inline and to the right of each user.
You should see:

    Username 2 has the "Viewer" role granted to it.
    The +ADD button at the top is grayed out—if you try to click on it you get the message, "You need permissions for this action. Required permission(s): resource manager.projects.setIamPolicy".

3. This is one example of how IAM roles affect what you can and cannot do in Google Cloud.
4. Switch back to the Username 1 console for the next step

## 6.3. Prepare a resource for access testing

1. Create a bucket

Update the following fields, leave all others at their default values:

    Property  Value
    Name: globally unique name (create it yourself!) and click CONTINUE.
    Location Type:  Multi-Region

2. Upload a sample file
   1.  On the Bucket Details page click UPLOAD FILES.
   2.  Browse your computer to find a file to use. Any text or html file will do.
   3.  Click on the three dots at the end of the line containing the file and click Rename.
   4.  Rename the file ‘sample.txt'.


## 6.4. Remove project access
Switch to the Username 1 console

1. Select Navigation menu > IAM & Admin > IAM. Then click the pencil icon inline and to the right of Username 2.
2. Remove Project Viewer access for Username 2 by clicking the trashcan icon next to the role name. Then click SAVE.

## 6.5. Add Storage permissions
1. Copy Username 2 name from the Lab Connection panel.
2. Switch to Username 1 console. Ensure that you are still signed in with Username 1's credentials. If you are signed out, sign in back with the proper credentials.
3. In the Console, select Navigation menu > IAM & Admin > IAM.
4. Click + ADD button and paste the Username 2 name into the New principals field.
5. In the Select a role field, select Cloud Storage > Storage Object Viewer from the drop-down menu.
6. Click SAVE.

## 6.6. Verify access
Switch to the Username 2 console
> gsutil ls gs://iam-example


