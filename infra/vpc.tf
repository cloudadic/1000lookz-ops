resource "aws_vpc" "mgmt_vpc" {
    cidr_block = "${var.mgmt_vpc_cidr}"
    tags {
        Name = "${var.mgmt_vpc_tag}"
    }
}

resource "aws_subnet" "mgmt_subnet_public" {
    vpc_id = "${aws_vpc.mgmt_vpc.id}"
    availability_zone = "${element(split(",", lookup(var.regions, "${var.region}")), count.index)}"
    cidr_block = "${cidrsubnet(var.mgmt_vpc_cidr, 4, count.index)}"
    count = "${length(split(",", lookup(var.regions, "${var.region}")))}"
    map_public_ip_on_launch = true
    tags {
        Name = "${var.mgmt_vpc_tag} Public"
    }
}

resource "aws_internet_gateway" "mgmt_igw" {
    vpc_id = "${aws_vpc.mgmt_vpc.id}"
}

resource "aws_route" "mgmt_public_route" {
    route_table_id         = "${aws_vpc.mgmt_vpc.main_route_table_id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = "${aws_internet_gateway.mgmt_igw.id}"
}

resource "aws_subnet" "mgmt_subnet_private" {
    vpc_id = "${aws_vpc.mgmt_vpc.id}"
    availability_zone = "${element(split(",", lookup(var.regions, "${var.region}")), count.index)}"
    cidr_block = "${cidrsubnet(var.mgmt_vpc_cidr, 4, "${count.index + length(split(",", lookup(var.regions, "${var.region}")))}")}"
    count = "${length(split(",", lookup(var.regions, "${var.region}")))}"
    map_public_ip_on_launch = false
    tags {
        Name = "${var.mgmt_vpc_tag} Private"
    }
}

resource "aws_eip" "mgmt_nat_gw" {
  vpc      = true
}

resource "aws_nat_gateway" "mgmt_nat_gw" {
    allocation_id = "${aws_eip.mgmt_nat_gw.id}"
    subnet_id = "${aws_subnet.mgmt_subnet_public.0.id}"
}

resource "aws_route_table" "mgmt_private" {
    vpc_id = "${aws_vpc.mgmt_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.mgmt_nat_gw.id}"
    }

    tags {
        Name = "${var.mgmt_vpc_tag} Private"
    }
}

resource "aws_route_table_association" "mgmt_private" {
    count = "${length(split(",", lookup(var.regions, "${var.region}")))}"
    subnet_id = "${element(aws_subnet.mgmt_subnet_private.*.id, count.index)}"
    route_table_id = "${aws_route_table.mgmt_private.id}"
}
