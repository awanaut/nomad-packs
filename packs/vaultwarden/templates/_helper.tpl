[[- define "port" ]]
[[ if var "port" . ]]
  port "http" {
    to = 80
    static = [[ var "port" . ]]
  }
  [[ else ]]
  port "http" {
    to = 80
  }
  [[ end ]]
[[- end ]]







