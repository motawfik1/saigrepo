#-------- Storage/main.tf------------

#create Random id

resource "random_id" "tf_bucket_id" {
    byte_length = 2
}

# Create S3 Bucket
resource "aws_s3_bucket" "tf_code_bucket" {
    bucket = "${var.project_name}-${random_id.tf_bucket_id.dec}"
    acl = "private"
    force_destroy = "true"
    tags {
        Name = "tf_code_bucket"
    }
}
