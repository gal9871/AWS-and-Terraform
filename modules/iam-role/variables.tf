variable "tags"{
    type = map
}

variable "assume_role_policy"{
}

variable "name"{
    type = string
}

variable "managed_policy_arns"{
    type = list(string)
}