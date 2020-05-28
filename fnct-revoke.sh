
echo "Listando FUNCTION APP"
az functionapp show --name "$resource_name" --resource-group "$resource_group_name" --output none
sleep 10
functionAppId=$(az functionapp list --query "[?name=='$resource_name'].id" -o tsv)
echo $functionAppId

    resource=$((az rest --method post --uri "$functionAppId/host/default/listKeys?api-version=2018-11-01" --query functionKeys -o tsv) 2>&1)
   error=$(echo $resource | grep error)
   echo "Mostrando variable error"
   echo $error
   log=$error"nulo"
   echo "mostrando variable log"
   echo $log


#echo "creando variable count"
#count=$(az rest --method post --uri "$functionAppId/host/default/listKeys?api-version=2018-11-01" --query functionKeys -o tsv &> error.log)
#echo $count
#echo "creando variable counter"
#counter=$count"nulo"
#echo $counter

echo "Entrando a While"
while [ "$log" != "nulo" ]
do
   echo "Dentro de While"
   resource=$((az rest --method post --uri "$functionAppId/host/default/listKeys?api-version=2018-11-01" --query functionKeys -o tsv) 2>&1)
   error=$(echo $resource | grep error)
   echo "Mostrando variable error"
   echo $error
   log=$error"nulo"
   echo "mostrando variable log"
   echo $log 
done
echo "Saliendo de While"
rm -rf "$resource_name".log
sleep 10
echo "BORRANDO FUNCTION HOSTKEY"
az rest --method delete --uri "$functionAppId/host/default/functionkeys/default?api-version=2018-11-01"