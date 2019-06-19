resource "docker_container" "container_id" {
  name = "${var.c_name}"
  image = "${var.image_name}"
  ports {
    internal = "${var.int_port}"
    external = "${var.ext_port}"
  }
}
