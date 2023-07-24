# Create Auto Scaling Group
resource "aws_autoscaling_group" "my_asg" {
  name                 = "capstone-asg"
  desired_capacity     = 1
  max_size             = 3
  min_size             = 1
  force_delete         = true
  depends_on           = [aws_lb.my-lb]
  target_group_arns    = ["${aws_lb_target_group.target-grp.arn}"]
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.capstone-server.name
  vpc_zone_identifier  = ["${aws_subnet.private_subnet1.id}", "${aws_subnet.private_subnet2.id}"]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "capstone-asg"
    propagate_at_launch = true
  }
}
