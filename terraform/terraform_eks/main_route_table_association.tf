resource "aws_main_route_table_association" "tfer--vpc-0d005e84f2bb96266" {
  route_table_id = "${data.terraform_remote_state.local.outputs.aws_route_table_tfer--rtb-0f37da50152e19728_id}"
  vpc_id         = "vpc-0d005e84f2bb96266"
}
