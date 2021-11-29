variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type = list(object({
    name  = string
    value = string
  }))
  default = [{
    name  = "hoge"
    value = "huga"
  }]
}

variable "security_groups" {
  type    = list(string)
  default = []
}
