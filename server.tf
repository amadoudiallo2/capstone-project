resource "aws_launch_configuration" "capstone-server" {
  name_prefix     = "capstone-server-launch"
  image_id        = var.ami_value
  instance_type   = var.instance_type
  key_name        = "DemoKeyPair"
  security_groups = ["${aws_security_group.project-security-group.id}"]

  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    encrypted   = true
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"tou
    volume_size = 5
    encrypted   = true
  }
}
