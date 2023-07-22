resource "aws_s3_bucket" "mynewbucket" {
  bucket = var.bucketName
}

resource "aws_s3_bucket_ownership_controls" "www_bucket" {
  bucket = aws_s3_bucket.mynewbucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "versioning_the_bucket" {
  bucket = aws_s3_bucket.mynewbucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "mys3-acls" {
  bucket                  = aws_s3_bucket.mynewbucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_website_configuration" "thes3bucketconfig" {
  bucket = aws_s3_bucket.mynewbucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}


resource "aws_s3_object" "my_s3_object" {
  key    = "index.html"
  bucket = aws_s3_bucket.mynewbucket.id
  source = "index.html"
  etag   = filemd5("index.html")
}

resource "aws_s3_bucket_policy" "bucket_access_allow" {
  bucket = aws_s3_bucket.mynewbucket.id
  policy = data.aws_iam_policy_document.access_from_others.json

}

data "aws_iam_policy_document" "access_from_others" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["467283722999"]
    }


    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.mynewbucket.arn,
      "${aws_s3_bucket.mynewbucket.arn}/*",
    ]
  }
}


