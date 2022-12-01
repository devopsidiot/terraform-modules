variable "sops_file" {
  description = "The .sops.yaml file that SOPS uses to encrypt/decrypt the things"
}
variable "decrypt_script" {
  description = "The script used to decrypt the shared-parameters.yaml for humans to edit"
}
variable "encrypt_script" {
  description = "The script used to encrypt the shared-parameters.yaml so terragrunt can apply secrets"
}
variable "shared_parameters_yaml" {
  description = "shared-parameters.decrypted.yaml script used to hold secrets"
}
variable "gitignore" {
  description = ".gitignore to make sure that decrypted secrets aren't committed to git"
}
