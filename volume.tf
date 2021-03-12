# /* This script creates a backup policy, filters block volumes by tag, and then provides two methods of applying the policy to all tagged volumes: 
# (1) assigning the policy to each individual volume or (2) creating a volume group out of the tagged volumes and applying the policy to the group.
# */


# # CREATE BACKUP POLICY AND FILTER TAGGED VOLUMES

# resource oci_core_volume_backup_policy block_backup_policy {
#   provider = oci.sanjose
#   compartment_id = var.compartment_id
#   destination_region = var.standby_region
#   display_name = "block_backup_policy"
#   schedules {                                       # TO DO: Replace with required schedule.
#     backup_type       = "FULL"
#     day_of_month      = "1"
#     day_of_week       = "MONDAY"
#     hour_of_day       = "0"
#     month             = "JANUARY"
#     offset_seconds    = "0"
#     offset_type       = "STRUCTURED"
#     period            = "ONE_MONTH"
#     retention_seconds = "2678400"
#     time_zone         = "UTC"
#   }
# }

# data "oci_core_volumes" "tagged_volumes" {
#     provider = oci.sanjose
#     compartment_id = var.compartment_id
#     # filter {
#     #   name = "freeform_tags.environment"          # TO DO: Replace with required tag. To use a defined tag, replace freeform_tags with defined_tags.
#     #   values = ["dev"]
#     # }
# }

# # BACKUP POLICY PER VOLUME GROUP

# resource oci_core_volume_group block_volume_group {
#   provider = oci.sanjose
#   availability_domain = var.availability_domain_1          
#   compartment_id = var.compartment_id
#   display_name = "block_volume_group"
#   source_details {
#     type = "volumeIds"
#     volume_ids = data.oci_core_volumes.tagged_volumes.volumes[*].id
#   }
#   backup_policy_id = oci_core_volume_backup_policy.block_backup_policy.id
# }


