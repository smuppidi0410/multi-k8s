#Build
docker build -t smuppidi0410/multi-client:latest -t smuppidi0410/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t smuppidi0410/multi-server:latest -t smuppidi0410/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t smuppidi0410/multi-worker:latest -t smuppidi0410/multi-worker:$SHA -f ./worker/Dockerfile ./worker

#Push
docker push smuppidi0410/multi-client:latest 
docker push smuppidi0410/multi-server:latest 
docker push smuppidi0410/multi-worker:latest 

docker push smuppidi0410/multi-client:$SHA
docker push smuppidi0410/multi-server:$SHA 
docker push smuppidi0410/multi-worker:$SHA 

#Running kubectl
kubectl apply -f k8s
kubectl set image deployment/server-deployment server=smuppidi0410/multi-server:$SHA
kubectl set image deployment/client-deployment client=smuppidi0410/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=smuppidi0410/multi-worker:$SHA