docker build -t lab4957/multi-client:latest -t lab4957/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lab4957/multi-server:latest -t lab4957/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lab4957/multi-worker:latest -t lab4957/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push lab4957/multi-client:latest
docker push lab4957/multi-server:latest
docker push lab4957/multi-worker:latest

docker push lab4957/multi-client:$SHA
docker push lab4957/multi-server:$SHA
docker push lab4957/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lab4957/multi-server:$SHA
kubectl set image deployments/client-deployment client=lab4957/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lab4957/multi-worker:$SHA