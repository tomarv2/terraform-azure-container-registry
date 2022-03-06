variable "teamid" {
  description = "Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
<<<<<<< HEAD
  type        = string
=======
>>>>>>> 31e0ceeb7a3465e9b1567032ec2d4bb7467b4b98
}

variable "prjid" {
  description = "Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
<<<<<<< HEAD
  type        = string
}
variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created"
  type        = string
  default     = "westus2"
=======
>>>>>>> 31e0ceeb7a3465e9b1567032ec2d4bb7467b4b98
}
