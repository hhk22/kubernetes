

## POD

- CrashLoopBackOff  
    시작과 비정상의 종료를 연속해서 반복하는 상태.

- Pending  
    필요한 자원이 할당되지 않는 상태

- ImagePullBackOff  
    Failed Pulling Container Image

- Evicted  
    WorkerNode의 의 용량 부족. 


## Security Logging 

- Access Log  
    API 서버에 request 처리 현황 로깅.  
    Log Group > /aws/eks/<EKS_NAME>/authenticator

- Audit Log
    API 명령어에 대한 처리 로깅.  
    Log Group > /aws/eks/<EKS_NAME>/kube-apiserver-audit

- CloudTrail Log  
    AWS Resource에 대한 API 호출에 대한 로깅.  
    Log Group > aws-cloudtrail-logs


- WAF Log  
    사용자가 웹서비스에 접속하려는 것에 대한 로깅.  
    Log Group > aws-waf-logs


## DNS

- 대표적인 DNS 추적 명령어
    - nslookup
    - dig
        - dig +short
        - dig +trace


