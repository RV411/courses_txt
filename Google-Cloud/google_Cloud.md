## nombre de la cuenta activa 
gcloud auth list

## ID del proyecto
gcloud config list project
	

## En Cloud Shell, utilice gcloud para crear una nueva instancia de máquina virtual desde la línea de comandos:
     gcloud compute instances create gcelab2 --machine-type e2-medium --zone us-east5-a

    
## Para ver todos los valores predeterminados, ejecute lo siguiente:
 gcloud compute instances create --help
 
 
Puede establecer la región y zona predeterminada que usa gcloud si siempre trabaja dentro de la misma región o zona y no quiere incluir la marca --zone en cada ocasión.

Para ello, ejecute los siguientes comandos:

gcloud config set compute/zone ...
gcloud config get-value compute/zone

gcloud config set compute/region ...
gcloud config get-value compute/region


gcloud config get-value project
gcloud compute project-info describe --project $(gcloud config get-value project)


También puede utilizar SSH para conectarse a su instancia a través de gcloud. Asegúrese de agregar su zona o de omitir la marca --zone si estableció la opción de forma global
     gcloud compute ssh gcelab2 --zone us-east5-a 

     
     

> connect to computing resources hosted on Google Cloud via Cloud Shell with the gcloud tool.








