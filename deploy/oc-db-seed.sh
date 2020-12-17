#!/bin/bash

set -euxo pipefail

# take in argument from pipeline/command line
declare PROJECT=$1
echo "Seeding database on project $PROJECT"

declare DATABASE_SVC="hplus-db"

# FIXME: Uncomment to access the oc command
# oc project $PROJECT
# oc port-forward svc/${DATABASE_SVC} 1433:1433 &

# connection settings for the seeding
export ConnectionStrings__CatalogConnection='Server=localhost; UID=sa; Password=yourStrong(!)Password; Integrated Security=False; Initial Catalog=Microsoft.eShopOnWeb.CatalogDb;'
export ConnectionStrings__IdentityConnection='Server=localhost; UID=sa; Password=yourStrong(!)Password; Integrated Security=False; Initial Catalog=Microsoft.eShopOnWeb.Identity;'
export ASPNETCORE_ENVIRONMENT="Development"
export ASPNETCORE_URLS="http://*:8080"

cd src/Web

dotnet tool restore
dotnet ef database update -c catalogcontext -p ../Infrastructure/Infrastructure.csproj -s Web.csproj
dotnet ef database update -c appidentitydbcontext -p ../Infrastructure/Infrastructure.csproj -s Web.csproj

echo "Database $DATABASE_SVC in namespace $PROJECT successfully initialized."

