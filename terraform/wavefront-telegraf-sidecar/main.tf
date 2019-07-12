module "gke" {
  source    = "./gke"
  project   = "${var.project}"
  providers = {
    google  = "google.gprovider"
  } 
  region    = "${var.region}"
  username  = "${var.username}"
  password  = "${var.password}"
  clustername = "${var.clustername}"
}

module "k8s" {
  source   = "./k8s"
  providers = {
    google = "google.gprovider"
  } 
  host                   = "${module.gke.host}"
  username               = "${var.username}"
  password               = "${var.password}" 
  client_certificate     = "${module.gke.client_certificate}"
  client_key             = "${module.gke.client_key}"
  cluster_ca_certificate = "${module.gke.cluster_ca_certificate}"
  image                  = "${var.image}"
  context                = "${var.context}"
  service_context        = "${var.service_context}"
}