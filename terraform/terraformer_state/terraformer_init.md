### state 파일 s3 bucket으로 전송. 

```
-- s3 file local 파일 s3 bucket으로 전송. 
aws s3 cp <state file path on local to transfer> s3://<s3 bucket>/<filename>
aws s3 cp ./terraform.tfstate s3://tt-s3-tf-state/terraform.tfstate

-- <참고> 반대로 가져오기
aws s3 cp s3://<s3 bucket>/<filename> <state file path on local to save>


-- terraformer를 활용해서 auto scaling 자원 가져오기. 
terraformer import aws --regions=<region_name>  --resources=<resource_name> --path-patttern=<path_to_save>

terraformer import aws --regions=ap-northeast-2 --resources=auto_scaling --path-pattern=auto_scaling


-- 추출된 terraform 상태파일을 기존의 terraform 상태파일에 import. 
terraform state mv --state-out=<상태파일 저장경로> <추출할 terraform object name> <추출될 terraform object name>

ex) terraform state mv --state-out=../terraform.tfstate aws_launch_template.tfer--eks-a4c49d63-ccfd-2446-e803-0eef1f8a51a1 aws_launch_template.tfer--eks-a4c49d63-ccfd-2446-e803-0eef1f8a51a1

상태 확인 
cd .. (terraform.tfstate 파일이 있는 디렉토리)
terraform state list

-- 변경된 state 파일을 다시 s3 업로드
aws s3 cp ./terraform.tfstate s3://tt-s3-tf-state/terraform.tfstate

-- eks 외의 resource 가져오기. 
terraformer import aws --regions=ap-northeast-2 --resource-vpc --path-patttern=vpc
terraform state mv --state-out=<...> ... ...



```

### trouble shooting

```
This configuration or its associated state refers to the unqualified provider "aws".  
>>
terraform state replace-provider "registry.terraform.io/-/aws" "hashicorp/aws"
```