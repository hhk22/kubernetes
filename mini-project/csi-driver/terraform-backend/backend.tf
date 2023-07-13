resource "aws_s3_bucket" "test-s3-tf-state" {
    bucket = "test-s3-tf-state"
    tags = {
        "Name" = "test-s3-tf-state"
    }
}

resource "aws_dynamodb_table" "test-ddb-tf-lock" {
    depends_on = [aws_s3_bucket.test_s3_tf_state]
    name = "test-ddb-tf-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attributte {
        name = "LockID"
        type = "S"
    }

    tags = {
        name = "test-ddb-tf-lock"
    }

}