$rg = "<changeme>"

$confirmation = Read-Host "About to delete EVERYTHING from $rg. Are you sure? [y/N]"

if ($confirmation -eq "y") {
  az deployment group create --mode complete --template-file ./delete_env.json --resource-group "$rg"
}
