
resource "google_compute_instance" "cks_master" {
  name         = "cks-master"
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_name

  boot_disk {
    initialize_params {
      image = var.machine_base_image
      size  = var.machine_disk_size
    }
    auto_delete = true
  }
  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}

resource "null_resource" "init_master" {
  provisioner "local-exec" {
    command = <<EOF
    sleep 30;
    gcloud compute ssh --project=${var.project_name} --zone=${var.zone} root@cks-master -- wget https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_master.sh -O /tmp/install_master.sh;
    gcloud compute ssh --project=${var.project_name} --zone=${var.zone} root@cks-master -- bash /tmp/install_master.sh;
    gcloud compute ssh --project=${var.project_name} --zone=${var.zone} root@cks-master -- kubeadm token create --print-join-command > /tmp/join_cluster.sh;
    EOF
  }

  depends_on = [
    google_compute_instance.cks_master
  ]
}


resource "null_resource" "init_worker" {
  provisioner "local-exec" {
    command = <<EOF
    sleep 30;
    gcloud compute ssh --project=${var.project_name} --zone=${var.zone} root@cks-worker -- wget https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_worker.sh -O /tmp/install_worker.sh;
    gcloud compute ssh --project=${var.project_name} --zone=${var.zone} root@cks-worker -- bash /tmp/install_worker.sh;
    EOF
  }

  depends_on = [
    google_compute_instance.cks_worker
  ]
}


resource "google_compute_instance" "cks_worker" {
  name         = "cks-worker"
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_name

  boot_disk {
    initialize_params {
      image = var.machine_base_image
      size  = var.machine_disk_size
    }
    auto_delete = true
  }
  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}

resource "null_resource" "join_cluster" {
  provisioner "local-exec" {
    command = <<EOF
    gcloud compute scp --project=${var.project_name} --zone=${var.zone} cks-master:/tmp/join_cluster.sh /tmp/join_cluster.sh
    gcloud compute scp --project=${var.project_name} --zone=${var.zone} /tmp/join_cluster.sh cks-worker:/tmp/join_cluster.sh
    gcloud compute ssh root@cks-worker -- bash /tmp/join_cluster.sh
    EOF
  }

  depends_on = [
    google_compute_instance.cks_master,
    google_compute_instance.cks_worker,
    null_resource.init_master,
    null_resource.init_worker
  ]
}
