# docker image build -t health . -f HEALTHCHECK.Dockerfile
# Check that the nginx config file exists: docker run --name=health-proxy -d \ 
    # --health-cmd='stat /etc/nginx/nginx.conf || exit 1' \ 
    # health
#* Check if nginx is healthy: docker inspect --format='' health-proxy
# container Unhealthy: docker exec health-proxy rm /etc/nginx/nginx.conf
#* Check if nginx is healthy: sleep 5; docker inspect --format='' health-proxy
# docker exec health-proxy touch /etc/nginx/nginx.conf
#* sleep 5; docker inspect --format='' health-proxy
    # healthy


FROM nginx:1.13
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1
EXPOSE 80