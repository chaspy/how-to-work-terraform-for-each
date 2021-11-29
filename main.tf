data "aws_availability_zones" "all" {}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.id
  availability_zones   = data.aws_availability_zones.all.names

  min_size = 2
  max_size = 2

  # Use for_each to loop over var.custom_tags
  dynamic "tag" {
    for_each = toset(concat(var.custom_tags, var.security_groups))
    content {
      key                 = tag.value.name
      value               = tag.value.value
      propagate_at_launch = true
    }
  }
}

resource "aws_launch_configuration" "example" {
  image_id      = "ami-07ebfd5b3428b6f4d"
  instance_type = "t2.nano"

  lifecycle {
    create_before_destroy = true
  }
}
