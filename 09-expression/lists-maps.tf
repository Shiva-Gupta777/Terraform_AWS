locals {
  users_maps = { for user_info in var.users : user_info.username => user_info.role... }

  //for structing in maps in maps

  users_maps2 = { for username, usersroles in local.users_maps : username => {
    roles = usersroles
    }
  }
//Now converting maps to list

   usernames_from_map = [
    for username, roles in local.users_maps : username ]

}



output "users_maps" {
  value = local.users_maps
}

output "users_maps2" {
  value = local.users_maps2
}


//for accesing the particular in maps

output "janes_role" {
  value = local.users_maps2["Jahn"].roles
}


output "usernames" {
   value = local.usernames_from_map
}