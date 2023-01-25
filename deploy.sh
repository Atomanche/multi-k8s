docker build -t atomanche/multi-client-k8s:latest -t atomanche/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t atomanche/multi-server-k8s-pgfix:latest -t atomanche/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t atomanche/multi-worker-k8s:latest -t atomanche/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push atomanche/multi-client-k8s:latest
docker push atomanche/multi-server-k8s-pgfix:latest
docker push atomanche/multi-worker-k8s:latest

docker push atomanche/multi-client-k8s:$SHA
docker push atomanche/multi-server-k8s-pgfix:$SHA
docker push atomanche/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=atomanche/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=atomanche/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=atomanche/multi-worker-k8s:$SHA