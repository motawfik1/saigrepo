#Docker Image
module "image" {
  source = "./image"
  image = "${lookup(var.image, var.env)}"
}
# Docker Container
module "container" {
  source = "./container"
  c_name = "${lookup(var.con_name, var.env)}"
  image_name = "${module.image.img_output}"
  int_port = "${var.int_port}"
  ext_port = "${lookup(var.ext_port, var.env)}"
}
resource "null_resource" "null_id" {
  provisioner "local-exec" {
    command = "echo ${module.container.container_name}:${module.container.ip} >> test.txt"
  }
}
