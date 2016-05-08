output "VPC CIDR" {
  value = "${aws_vpc.mgmt_vpc.cidr_block}"
}

output "NAT EIP" {
  value = "${aws_eip.mgmt_nat_gw.public_ip}"
}

output "Public Subnets" {
  value = "${join(",",aws_subnet.mgmt_subnet_public.*.id)}"
}

output "Private Subnets" {
  value = "${join(",",aws_subnet.mgmt_subnet_private.*.id)}"
}

output "Public/Main Route Table" {
  value = "${aws_vpc.mgmt_vpc.main_route_table_id}"
}

output "Private Route Table" {
  value = "${aws_route_table.mgmt_private.id}"
}
