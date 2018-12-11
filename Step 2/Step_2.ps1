# Load inputdb in a custom PS object
$inputDB = Import-Csv "D:\Data Integration\Data Cleaning\Step 2\inputDB_cleaned_1.csv"

# Remove "," and "#" from address field
for ($i=0; $i -lt $inputDB.length; $i++)
{
$inputDB[$i].Address=$inputDB[$i].Address.Replace(",","")
$inputDB[$i].Address=$inputDB[$i].Address.Replace("#","")
}

# Export to csv 
$inputDB | Export-Csv -Path "D:\Data Integration\Data Transformation\inputDB_cleaned_2.csv" -NoTypeInformation