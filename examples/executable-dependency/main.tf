terraform {
  required_version = ">= 0.12"
}

module "executable" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  # source = "git::git@github.com:gruntwork-io/package-terraform-utilities.git//modules/executable-dependency?ref=v1.0.8"
  source = "../../modules/executable-dependency"

  executable     = var.executable
  download_url   = var.download_url
  append_os_arch = var.append_os_arch
}

data "external" "output" {
  program = [
    "bash",
    "-c",
    "echo \"{\\\"output\\\": \\\"$(${module.executable.executable_path} ${var.executable_args})\\\"}\"",
  ]
}
