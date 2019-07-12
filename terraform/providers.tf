provider "google" {
  alias  = "gprovider"
  project = "${var.project}"
  region  = "${var.region}"
  zone    = "${var.zone}"
  credentials = "${file("${var.credential}")}"
}