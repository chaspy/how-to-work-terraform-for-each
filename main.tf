data "aws_availability_zones" "all" {}

resource "aws_autoscaling_group" "example" {
  count = length(var.data)

  launch_configuration = aws_launch_configuration.example.id
  availability_zones   = data.aws_availability_zones.all.names

  min_size = 2
  max_size = 2

  # Use for_each to loop over var.custom_tags
  dynamic "tag" {
    for_each = toset(concat([
      {
        name  = "hoge"
        value = "${var.data[count.index].name}:${var.data[count.index].user}"
      }
    ], var.data[count.index].values))
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
