resource "aws_instance" "my_ec2" {
  ami           = var.ami
  instance_type = var.instance_type

  key_name = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [
    aws_security_group.launch_wizard.id
  ]

  tags = {
    Name = "MyTerraformEC2"
  }
}
