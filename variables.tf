variable "data" {
  description = "Custom tags to set on the Instances in the ASG"
  type = list(object({
    name = string
    user = string
    values = list(object({
      name  = string
      value = string
    }))
  }))
  default = [
    {
      name   = "hoge"
      user   = "huga"
      values = []
    },
    {
      name   = "foo"
      user   = "bar"
      values = []
    }
  ]
}

variable "security_groups" {
  type    = list(string)
  default = []
}
