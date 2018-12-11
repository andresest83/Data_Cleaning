# Load inputdb in a custom PS object
$inputDB = Import-Csv "D:\Data Integration\Data Cleaning\inputDB.csv"

# Convert to capital letters
for ($i=0; $i -lt $inputDB.length; $i++)
{
    $inputDB[$i].RecID=$inputDB[$i].RecID.ToUpper()
    $inputDB[$i].FirstName=$inputDB[$i].FirstName.ToUpper()
    $inputDB[$i].MiddleName=$inputDB[$i].MiddleName.ToUpper()
    $inputDB[$i].LastName=$inputDB[$i].LastName.ToUpper()
    $inputDB[$i].Address=$inputDB[$i].Address.ToUpper()
    $inputDB[$i].City=$inputDB[$i].City.ToUpper()
    $inputDB[$i].State=$inputDB[$i].State.ToUpper()
}

# Remove Alphabetical characters from Zip
for ($i=0; $i -lt $inputDB.length; $i++)
{
    $inputDB[$i].ZIP=$inputDB[$i].ZIP -replace "\D+"
}

# Query by ZIP code a Restful API and populate City and State
for ($i=0; $i -lt $inputDB.length; $i++)
{
    $zip=$inputDB[$i].ZIP
    $cityRestInfo=Invoke-RestMethod -Method Get -Uri "http://api.zippopotam.us/us/$zip"
    $inputDB[$i].State=$cityRestInfo.places."state abbreviation"
    $inputDB[$i].City=$cityRestInfo.places."place name"
}

# Export to csv 
$inputDB | Export-Csv -Path "D:\Data Integration\Data Transformation\inputDB_cleaned_1.csv" -NoTypeInformation