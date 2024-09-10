// Auto-generated variable declarations from massdriver.yaml
variable "aws_authentication" {
  type = object({
    data = object({
      arn         = string
      external_id = optional(string)
    })
    specs = object({
      aws = optional(object({
        region = optional(string)
      }))
    })
  })
}
variable "endpoint_config" {
  type = object({
    instance_count = number
    instance_type  = string
    primary_container = object({
      ecr_image = string
      model_data_config = optional(object({
        enabled    = bool
        model_data = optional(string)
      }))
    })
  })
}
variable "environment_variables" {
  type = list(object({
    name  = string
    value = string
  }))
  default = null
}
variable "md_metadata" {
  type = object({
    default_tags = object({
      managed-by  = string
      md-manifest = string
      md-package  = string
      md-project  = string
      md-target   = string
    })
    deployment = object({
      id = string
    })
    name_prefix = string
    observability = object({
      alarm_webhook_url = string
    })
    package = object({
      created_at             = string
      deployment_enqueued_at = string
      previous_status        = string
      updated_at             = string
    })
    target = object({
      contact_email = string
    })
  })
}
variable "monitoring" {
  type = object({
    endpoint_log_retention = optional(number)
  })
}
variable "s3_model_bucket" {
  type = object({
    data = object({
      infrastructure = object({
        arn = string
      })
      security = optional(object({
        iam = optional(map(object({
          policy_arn = string
        })))
        identity = optional(object({
          role_arn = optional(string)
        }))
        network = optional(map(object({
          arn      = string
          port     = number
          protocol = string
        })))
      }))
    })
    specs = object({
      aws = optional(object({
        region = optional(string)
      }))
    })
  })
}
variable "vpc" {
  type = object({
    data = object({
      infrastructure = object({
        arn  = string
        cidr = string
        internal_subnets = list(object({
          arn = string
        }))
        private_subnets = list(object({
          arn = string
        }))
        public_subnets = list(object({
          arn = string
        }))
      })
    })
    specs = optional(object({
      aws = optional(object({
        region = optional(string)
      }))
    }))
  })
}
