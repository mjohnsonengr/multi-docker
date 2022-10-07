docker build -t mejdev/multi-client:latest -t mejdev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mejdev/multi-server:latest -t mejdev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mejdev/multi-worker:latest -t mejdev/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mejdev/multi-client:$SHA
docker push mejdev/multi-server:$SHA
docker push mejdev/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mejdev/multi-server:$SHA
kubectl set image deployments/client-deployment client=mejdev/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mejdev/multi-worker:$SHA