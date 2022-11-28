- [1. Apache Spark and Apache Hadoop](#1-apache-spark-and-apache-hadoop)
  - [1.1. Submit a job](#11-submit-a-job)
  - [1.2. View the job output](#12-view-the-job-output)
  - [1.3. Update a cluster](#13-update-a-cluster)
- [2. Dataproc: Command Line](#2-dataproc-command-line)
  - [2.1. Create a cluster](#21-create-a-cluster)
  - [2.2. Submit a job](#22-submit-a-job)
  - [2.3. Update a cluster](#23-update-a-cluster)
- [3. Dataflow: Templates](#3-dataflow-templates)
  - [3.1. Create a Cloud BigQuery dataset and table Using Cloud Shell](#31-create-a-cloud-bigquery-dataset-and-table-using-cloud-shell)
    - [3.1.1. Create a storage bucket](#311-create-a-storage-bucket)
  - [3.2. Create a Cloud BigQuery dataset and table using the Cloud Console](#32-create-a-cloud-bigquery-dataset-and-table-using-the-cloud-console)
    - [3.2.1. Create a storage bucket](#321-create-a-storage-bucket)
  - [3.3. Run the pipeline](#33-run-the-pipeline)
  - [3.4. Submit a query](#34-submit-a-query)
- [4. Dataflow: Python](#4-dataflow-python)
  - [4.1. Create a Cloud Storage bucket](#41-create-a-cloud-storage-bucket)
  - [4.2. Install pip and the Cloud Dataflow SDK](#42-install-pip-and-the-cloud-dataflow-sdk)
  - [4.3. Run an example pipeline remotely](#43-run-an-example-pipeline-remotely)
  - [4.4. Check that your job succeeded](#44-check-that-your-job-succeeded)
- [5. Dataprep](#5-dataprep)
  - [5.1. Create a Cloud Storage bucket in your project](#51-create-a-cloud-storage-bucket-in-your-project)
  - [5.2. Initialize Cloud Dataprep](#52-initialize-cloud-dataprep)
  - [5.3. Create a flow](#53-create-a-flow)
- [6. Vertex AI Workbench Notebook](#6-vertex-ai-workbench-notebook)
  - [6.1. Launch Vertex AI Workbench notebook](#61-launch-vertex-ai-workbench-notebook)
  - [6.2. Clone the example repo within your Workbench instance](#62-clone-the-example-repo-within-your-workbench-instance)
    - [6.2.1. Navigate to the example notebook](#621-navigate-to-the-example-notebook)
- [7. Cloud Natural Language API](#7-cloud-natural-language-api)
  - [7.1. Create an API Key](#71-create-an-api-key)
  - [7.2. Make an Entity Analysis Request](#72-make-an-entity-analysis-request)
- [8. Google Cloud Speech API](#8-google-cloud-speech-api)
  - [8.1. Create an API key](#81-create-an-api-key)
  - [8.2. Create your Speech API request](#82-create-your-speech-api-request)
  - [8.3. Call the Speech API](#83-call-the-speech-api)
- [9. Video Intelligence](#9-video-intelligence)
  - [9.1. Enable the Video Intelligence API](#91-enable-the-video-intelligence-api)
  - [9.2. Set up authorization](#92-set-up-authorization)
  - [9.3. Make an annotate video request](#93-make-an-annotate-video-request)
- [10. Reinforcement Learning](#10-reinforcement-learning)
  - [10.1. Reinforcement learning 101](#101-reinforcement-learning-101)
  - [10.2. Create a Vertex AI Platform Notebook](#102-create-a-vertex-ai-platform-notebook)
  - [10.3. Clone the example repo within your Workbench instance](#103-clone-the-example-repo-within-your-workbench-instance)
    - [10.3.1. Navigate to the example notebook](#1031-navigate-to-the-example-notebook)
  - [10.4. Run through the notebook](#104-run-through-the-notebook)








#  1. Apache Spark and Apache Hadoop

1. Navigate DataProc> Clusters
2. Click Create for Cluster on Compute Engine
   1. Name 	example-cluster
   2. Region 	
   3. Zone 	
   4. Machine Series 	E2
   5. Machine Type 	e2-standard-2
   6. Max Worker Nodes 	2


## 1.1. Submit a job

1. Click Jobs in the left pane to switch to Dataproc's jobs view, then click Submit job
   1. Region 	
   2. Cluster 	example-cluster
   3. Job type 	Spark
   4. Main class or jar 	org.apache.spark.examples.SparkPi
   5. Jar files 	file:///usr/lib/spark/examples/jars/spark-examples.jar
   6. Arguments 	1000 (This sets the number of tasks.)
2. Job status displays as Running, and then Succeeded after it completes.


## 1.2. View the job output
1. Click the job ID in the Jobs list.
2. Check Line wrapping or scroll all the way to the right to see the calculated value of Pi. Your output, with Line wrapping checked


## 1.3. Update a cluster

1. Select Clusters in the left navigation pane to return to the Dataproc Clusters view.
2. Click example-cluster in the Clusters list. By default, the page displays an overview of your cluster's CPU usage
3. Click Configuration to display your cluster's current settings.
4. Click Edit. The number of worker nodes is now editable.
5. Enter 4 in the Worker nodes field.
6. Click Save.


# 2. Dataproc: Command Line 

## 2.1. Create a cluster
1. gcloud config set dataproc/region us-east1
2.  create a cluster called example-cluster with default Cloud Dataproc settings
   1. gcloud dataproc clusters create example-cluster --worker-boot-disk-size 500

## 2.2. Submit a job
    That you want to run a spark job on the example-cluster cluster
    The class containing the main method for the job's pi-calculating application
    The location of the jar file containing your job's code
    The parameters you want to pass to the job—in this case, the number of tasks, which is 1000
      
1. submit a sample Spark job that calculates a rough value for pi:
   1. gcloud dataproc jobs submit spark --cluster example-cluster \
  --class org.apache.spark.examples.SparkPi \
  --jars file:///usr/lib/spark/examples/jars/spark-examples.jar -- 1000


## 2.3. Update a cluster
1. change the number of workers in the cluster to four
   1. gcloud dataproc clusters update example-cluster --num-workers 4
2. decrease the number of worker nodes
   1. gcloud dataproc clusters update example-cluster --num-workers 2


# 3. Dataflow: Templates


## 3.1. Create a Cloud BigQuery dataset and table Using Cloud Shell
1. create a dataset called taxirides
   1. 
2.  instantiate a BigQuery table
    1.  bq mk \
--time_partitioning_field timestamp \
--schema ride_id:string,point_idx:integer,latitude:float,longitude:float,\
timestamp:timestamp,meter_reading:float,meter_increment:float,ride_status:string,\
passenger_count:integer -t taxirides.realtime

###  3.1.1. Create a storage bucket
1. create a bucket.
   1. export BUCKET_NAME=**example-bucket02**
   2. gsutil mb gs://$BUCKET_NAME/

## 3.2. Create a Cloud BigQuery dataset and table using the Cloud Console
1. Navigate to **BigQuery**
2. Click on the three dots next to your project name under the Explorer section, then click Create dataset.
3. Input **taxirides** as your dataset ID:
4. Select **us (multiple regions in United States)** in Data location.
5. Leave all of the other default settings in place and click **CREATE DATASET**
6. You should now see the taxirides dataset underneath your project ID in the left-hand console.
7. Click on the three dots next to **taxirides** dataset and select **Open**.
8. Then select **CREATE TABLE** in the right-hand side of the console.
9. In the Destination > Table Name input, enter **realtime**.
10. Under Schema, toggle the Edit as text slider and enter the following
    1.  ride_id:string,point_idx:integer,latitude:float,longitude:float,timestamp:timestamp,meter_reading:float,meter_increment:float,ride_status:string,passenger_count:integer
11. click Create table.


### 3.2.1. Create a storage bucket
1. Go back to the Cloud Console and navigate to Cloud Storage > Browser > Create bucket.
2. Give your bucket a unique name.**example-bucket003**
3. Leave all other default settings, then click Create.



## 3.3. Run the pipeline
1. From the Navigation menu, find the Analytics section and click on Dataflow.
2. Click on + Create job from template at the top of the screen.
3. Enter iotflow as the Job name for your Cloud Dataflow job and select us-east1 for Regional Endpoint.
4. Under Dataflow Template, select the Pub/Sub Topic to BigQuery template.
5. Under Input Pub/Sub topic, click Enter Topic Manually and enter
   1. projects/pubsub-public-data/topics/taxirides-realtime
6. Under BigQuery output table, enter the name of the table that was created
   1. qwiklabs-gcp-02-af5d4aa932fb:taxirides.realtime
7. Add your bucket as Temporary Location
   1. gs://Your_Bucket_Name/temp
8. Run job button

## 3.4. Submit a query
In the BigQuery Editor field add the following, replacing myprojectid with the Project ID from the Qwiklabs page:
> SELECT * FROM `qwiklabs-gcp-02-af5d4aa932fb.taxirides.realtime` LIMIT 1000

Dataflow Template used in the lab to run the pipeline

      Pub/Sub to BigQuery


# 4. Dataflow: Python

## 4.1. Create a Cloud Storage bucket
1. In the Cloud Console, click on Navigation menu and then click on Cloud Storage.
2. Click Create bucket.
3. In the Create bucket dialog, specify the following attributes:
   1. Name: A unique bucket name. Do not include sensitive information in the bucket name, as the bucket namespace is global and publicly visible.
   2. Location type: Multi-region
   3. Location: us
   4. A location where bucket data will be stored.
4. Click Create

## 4.2. Install pip and the Cloud Dataflow SDK

1. Run the Python3.7 Docker Image
   1. docker run -it -e DEVSHELL_PROJECT_ID=$DEVSHELL_PROJECT_ID python:3.7 /bin/bash
2. install the latest version of the Apache Beam for Python 
   1.  pip install 'apache-beam[gcp]'
3. Run the wordcount.py
   1. python -m apache_beam.examples.wordcount --output OUTPUT_FILE
4. LS to get the name of the OUTPUT_FILE
   1. ls
   2. cat <file name>

## 4.3. Run an example pipeline remotely

1. Set the BUCKET environment variable to the bucket you created earlier
   1. BUCKET=gs://bucket-dataflow-01
2. Now you'll run the wordcount.py
   1. python -m apache_beam.examples.wordcount --project $DEVSHELL_PROJECT_ID \
  --runner DataflowRunner \
  --staging_location $BUCKET/staging \
  --temp_location $BUCKET/temp \
  --output $BUCKET/results/output \
  --region us-west1

## 4.4. Check that your job succeeded
1. Navigation menu and click Dataflow
   1. You should see your wordcount job with a status of Running at first
2. Click on the name to watch the process. When all the boxes are checked off, you can continue watching the logs in Cloud Shell.   The process is complete when the status is Succeeded
3. Navigation menu > **Cloud Storage** in the Cloud Console.
4. Click on the **name of your bucket**. In your bucket, you should see the results and staging directories.
5. Click on the results folder and you should see the output files that your job created:
6. Click on a file to see the word counts it contains

# 5. Dataprep

## 5.1. Create a Cloud Storage bucket in your project

1. Buckets
2. Create bucket.
   1. deault values

## 5.2. Initialize Cloud Dataprep
1. Dataprep
2. Terms of Service, then click Accept
3. authorize sharing your account information with Trifacta
4. allow Trifacta to access project
5. Click Continue on the First time setup screen to create the default **storage location**.
6. Dataprep opens.
   1. Click on the Dataprep icon on the top left corner to go to the home screen.

## 5.3. Create a flow

      Cloud Dataprep uses a flow workspace to access and manipulate datasets.

1. Click Flows icon, then the Create button, then select Blank Flow 





# 6. Vertex AI Workbench Notebook 

## 6.1. Launch Vertex AI Workbench notebook

1. In the Navigation Menu Navigation, click **Vertex AI > Workbench**.
2. On the Workbench page, click **New Notebook**.
3. In the Customize instance menu, select TensorFlow Enterprise and choose the latest version of TensorFlow Enterprise 2.x (with LTS) > Without GPUs.
4. Name the notebook.
5. Set Region to **us-east1** and Zone to any zone within the designated region.
6. In the Notebook properties, click the pencil icon pencil icon to **edit** the instance properties.
7. Scroll down to Machine configuration and select **e2-standard-2** for Machine type.
8. Leave the remaining fields at their default and click **Create**
9. Click Open JupyterLab to **open JupyterLab** in a new tab

## 6.2. Clone the example repo within your Workbench instance

1. In JupyterLab, click the **Terminal** icon to open a new terminal.
2. type the following 
   1. git clone https://github.com/GoogleCloudPlatform/training-data-analyst
3. To confirm that you have cloned the repository, in the left panel, **double click** the training-data-analyst folder to see its contents.

### 6.2.1. Navigate to the example notebook
1. Navigate to training-data-analyst/self-paced-labs/ai-platform-qwikstart and open ai_platform_qwik_start.ipynb.
2. Clear all the cells in the notebook (on the notebook toolbar, navigate to Edit > Clear All Outputs) and then Run the cells one by one.


# 7. Cloud Natural Language API

## 7.1. Create an API Key


1. First, you will set an environment variable with your PROJECT_ID which you will use throughout this codelab:
   1. export GOOGLE_CLOUD_PROJECT=$(gcloud config get-value core/project)
2. create a new service account to access the Natural Language API
   1. gcloud iam service-accounts create my-natlang-sa \ --display-name "my natural language service account"
3. Create credentials to log in as your new service account.
   1. gcloud iam service-accounts keys create ~/key.json \ --iam-account my-natlang-sa@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com
4. set the GOOGLE_APPLICATION_CREDENTIALS environment variable. The environment variable should be set to the full path of the credentials JSON file you created, which you can see in the output from the previous command:
   1. export GOOGLE_APPLICATION_CREDENTIALS="/home/USER/key.json"

## 7.2. Make an Entity Analysis Request
1. Navigate to **Compute Engine**. Open **SSH**
   1. gcloud ml language analyze-entities --content="Michelangelo Caravaggio, Italian painter, is known for 'The Calling of Saint Matthew'." > result.json
2. preview the output of result.json file.
   1. cat result.json

# 8. Google Cloud Speech API

## 8.1. Create an API key

1. To create an API key, click Navigation menu > APIs & services > Credentials.
2. Then click Create credentials.
3. In the drop down menu, select API key.
4. Copy the key you just generated and click Close

         AIzaSyCvADq3Z6tPHwBQhzpzH4_BDU7ydmgIEls
5.  Navigate to **Compute Engine**. Open **SSH**
6.  In the command line, enter in the following
      > export API_KEY=AIzaSyCvADq3Z6tPHwBQhzpzH4_BDU7ydmgIEls

## 8.2. Create your Speech API request

1. Create request.json in the SSH command line. You'll use this to build your request to the speech API:
   1. touch request.json
   2. nano request.json

            {
            "config": {
                  "encoding":"FLAC",
                  "languageCode": "en-US"
            },
            "audio": {
                  "uri":"gs://cloud-samples-tests/speech/brooklyn.flac"
            }
            }

## 8.3. Call the Speech API

1. Transcription song to JSON
> curl -s -X POST -H "Content-Type: application/json" --data-binary @request.json \
"https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}"

2. save the response in a result.json 
> curl -s -X POST -H "Content-Type: application/json" --data-binary @request.json \
"https://speech.googleapis.com/v1/speech:recognize?key=${API_KEY}" > result.json

# 9. Video Intelligence

## 9.1. Enable the Video Intelligence API

Enable the Cloud Video Intelligence API

## 9.2. Set up authorization

1. create a new service account named quickstart
   > gcloud iam service-accounts create quickstart
2. Create a service account key file,
   > gcloud iam service-accounts keys create key.json --iam-account quickstart@qwiklabs-gcp-01-c167ba53066f.iam.gserviceaccount.com
3.  authenticate your service account, passing the location of your service account key file
   > gcloud auth activate-service-account --key-file key.json
4.  Obtain an authorization token using your service account
   > gcloud auth print-access-token

## 9.3. Make an annotate video request

1. create a JSON request file with the following text, and save it as request.json 
   > cat > request.json <<EOF
{
   "inputUri":"gs://spls/gsp154/video/train.mp4",
   "features": [
       "LABEL_DETECTION"
   ]
}
EOF

2. curl to make a videos:annotate request passing the filename of the entity request
   > curl -s -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer '$(gcloud auth print-access-token)'' \
    'https://videointelligence.googleapis.com/v1/videos:annotate' \
    -d @request.json

   OUTPUT:
   > "name": "projects/514008641177/locations/us-east1/operations/4411245502194618098"

3. Use this script to request information on the operation by calling the v1.operations endpoint. Replace the PROJECTS, LOCATIONS and OPERATION_NAME with the value you just received in the previous command
   > curl -s -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer '$(gcloud auth print-access-token)'' \
    'https://videointelligence.googleapis.com/v1/projects/514008641177/locations/us-east1/operations/4411245502194618098'



# 10. Reinforcement Learning

## 10.1. Reinforcement learning 101

## 10.2. Create a Vertex AI Platform Notebook

1. Vertex AI > Workbench > New Notebook
2. select TensorFlow Enterprise and choose the latest version of TensorFlow Enterprise 2.x (with LTS) > Without GPUs.
3. Name the notebook.
4. Set Region to **us-east1** and Zone to any zone within the designated region.
5. Click the pencil icon pencil icon to edit the instance properties.
6. Scroll down to Machine configuration and select **e2-standard-2** for Machine type
7. Leave the remaining fields at their default and click Create.

         After a few minutes, the Workbench page lists your instance, followed by Open JupyterLab.

8. Click Open **JupyterLab** to open JupyterLab in a new tab

## 10.3. Clone the example repo within your Workbench instance

1. In JupyterLab, click the **Terminal** icon to open a new terminal.
2. type the following 
   1. git clone https://github.com/GoogleCloudPlatform/training-data-analyst
3. To confirm that you have cloned the repository, in the left panel, **double click** the training-data-analyst folder to see its contents.

### 10.3.1. Navigate to the example notebook
1. Navigate to training-data-analyst> quests> rl > early_rl > early_rl.ipynb. and open early_rl.ipynb

## 10.4. Run through the notebook




