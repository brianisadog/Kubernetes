provider "kubernetes" {
  host     = "${var.host}"
  username = "${var.username}"
  password = "${var.password}"

  client_certificate     = "${file("~/.kube/keys/apiserver-kubelet-client.crt")}"
  client_key             = "${file("~/.kube/keys/apiserver-kubelet-client.key")}"
  cluster_ca_certificate = "${file("~/.kube/keys/ca.crt")}"
}
