


```

kubectl create configmap greeting-config --from-literal=STUDENT_NAME="hhk" --from-literal=MESSAGE="hello world"
kubectl get configmap greeting-config -o yaml 

```


```

apiVersion: v1
kind: Pod
metadata:
    name: hello-app
    labels:
        name: hello-app
spec:
    containers:
        - name: hello-app
          image: yoonjeong/hello-app:1.0
          ports:
          - containerPort: 8080
          env:
          - name: STUDENT_NAME
            valueFrom:
                configMapKeyRef:
                    name: greeting-config
                    key: STUDENT_NAME
          - name: MESSAGE
            valueFrom:
                configMapKeyRef:
                    name: greeting-config
                    key: MESSAGE
          - name: GREETING
            value: $(STDUNNET_NAME): $(MESSAGE)
        resources:
            limits:
                memory: "64Mi"
                cpu: "50m"
                

```


```

apiVersion: v1
kind: Pod
metadata:
    name: hello-app
    labels:
        name: hello-app
spec:
    containers:
        - name: hello-app
          image: yoonjeong/hello-app:1.0
          ports:
          - containerPort: 8080
          envFrom:
          - name: STUDENT_NAME
            valueFrom:
                configMapKeyRef:
                    name: greeting-config
          env:
          - name: GREETING
            value: $(MESSAGE)!! $(STUDENT_NAME)
        resources:
            limits:
                memory: "64Mi"
                cpu: "50m"

```


```
kubectl create configmap nginx-config --from-file=service/configs/server.conf
kubectl get configmap nginx-config -o yaml

```


```

apiVersion: v1
kind: Service
metadta:
    name: my-app
spec:
    selector:
        app: my-app
    ports:
    - port: 80
      targetPort: 8080

---

aopiVersion: v1
kind: Pod
metaData:
    nameL my-app
    labels:
        app: my-app
spec:
    containers:
        - name: my-app
          image: yoonjeong/my-app:1.0
          resources:
            limits:
                memory: "64Mi"
                cpu: "50m"
          ports:
          - containerPort: 8080
          
---

apiVersions: v1
kind: Pod
metadata: 
    name: web-server
    labels:
        name: nginx
sepc:
    volumes:
    - name: app-config
      configMap:
        name: nginx
    containers:
    - name: nginx
      image: nginx
      ports:
      - containerPort: 80
    volumeMounts:
        - name: app-config
          mountPath: /etc/nginx/conf.d
      resources:
        limits:
            memory: "64Mi"
            cpu: "50m"
```
