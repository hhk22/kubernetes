
- pod : 여러개의 컨테이너를 감싸고 있음.
- node : 가장 기본적인 배포단위.

------

- pod 생성시, node에서 유일한 IP 할당. ( 클러스터 내에서만 접속가능, 생성시 변경됨 )
- pod 내부의 컨테이너 들은 같은 ip 대역대에 있다.
- pod 내부의 컨테이너들이 공유해서 사용하는 volume 리소스가 있다. 


```
kubectl scale deployment orderapp --replicas=3
kubectl get pod
```

pod object 표현 방법. 

```
apiVersion: v1  // kubernetes API version

kind: Pod

metadata:
    name: kube-basic
    labels:  // key-value type
        app: kube-basic
        project: my-project

spec:
    nodeSelector: ...
    containers: ...
    volums: ... 
    ...

ex) spec
spec:
    nodeSelector:
        gpu: "true"
    containers:
        - name: ...
          image: ...
          imagePullPolicy: "always"
          ports:
            - containerPort: 80 ( docker expose port )
          env:
            - name: profile
              value: production
            - name: version
              value: ${profile}/v1
            ...

```


Volume Mount

```
spec:
    containers:
        - name: ...
          volumeMounts:
            - name: html
              mountPath: /var/html

        - name: ...
          volumeMounts:
            - name: html
              mountPath: /usr/share/nginx/html
              readOnly: true

    volumes:
        - name: html
          hostPath:
            path: /data/...  

```





