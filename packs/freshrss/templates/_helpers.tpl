[[ define "service_tags" ]]
[[ if var "service_tags" . ]]
tags = [[ var "service_tags" . | toStringList ]]
[[ end ]]
[[ end ]]

[[ define "port" ]]
[[- if var "port" . -]]    
    network {
      port "http" {
        to = 80
        static = [[ var "port" . ]]
       }
      [[ else ]]
      port "http" {
       to = 80
      }
      [[- end -]]
    }
[[ end ]]

[[- define "pinned_hosts" -]]
[[- if var "pinned_host" . ]]
[[ if var "pinned_host" . | regexMatch "^[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+$" ]]
constraint {
  attribute = "${attr.unique.network.ip-address}"
  value = [[ var "pinned_host" . | quote ]]
}
[[ else if var "pinned_host" . ]]
constraint {
  attribute = "${node.unique.name}"
  value = [[ var "pinned_host" . | quote ]]
}
[[ end ]]
[[- end ]]
[[- end -]]
