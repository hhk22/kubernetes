resource "aws_route_table_association" "tfer--subnet-02784bcb3e173a4d6" {
  route_table_id = "${data.terraform_remote_state.local.outputs.aws_route_table_tfer--rtb-01131bbb0737495df_id}"
  subnet_id      = "subnet-02784bcb3e173a4d6"
}

resource "aws_route_table_association" "tfer--subnet-09a03515a300c2fe0" {
  route_table_id = "${data.terraform_remote_state.local.outputs.aws_route_table_tfer--rtb-0876e73d764fd0a28_id}"
  subnet_id      = "subnet-09a03515a300c2fe0"
}
