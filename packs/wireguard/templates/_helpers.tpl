[[ define "env_vars" -]]
        [[- range $idx, $var := var "env" . ]]
        [[ $var.key ]] = [[ $var.value | quote ]]
        [[- end ]]
[[- end ]]

[[- define "pinned_hosts" -]]
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
[[- end -]]

[[ define "service_tags" ]]
[[ if var "service_tags" . ]]
tags = [[ var "service_tags" . | toStringList ]]
[[ end ]]
[[ end ]]