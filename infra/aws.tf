provider "aws" {
    region = "${var.region}"
    profile = "${var.profile}"
}

variable "ami" {
    default = {
    ap-northeast-1="ami-3c5f4152"
    ap-southeast-1="ami-fbe83c98"
    ap-southeast-2="ami-a5416cc6"
    eu-central-1="ami-f0eb089f"
    eu-west-1="ami-3079f543"
    sa-east-1="ami-567cf23a"
    us-east-1="ami-840910ee"
    us-west-1="ami-d8e996b8"
    us-west-2="ami-fa82739a"
    }
}
