provider "aws" {
  region     = "us-east-2"
}


resource "aws_instance" "Test_Terraform" {
  ami           = "ami-09246ddb00c7c4fef"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]
    connection {
      host         = aws_instance.Test_Terraform.public_ip
      type        = "ssh"
      user        = "root"
      private_key = file("~/.ssh/id_rsa")
    }
  }
  
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i 'aws_instance.Test_Terraform.public_ip,' --private-key /etc/ansible/vissu_aws_private.pem' /etc/ansible/playbooks/install_httpd.yml"
  }

}