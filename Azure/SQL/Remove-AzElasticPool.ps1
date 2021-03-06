﻿#Requires -Version 5.0
#Requires -Modules Az.Sql

<#
    .SYNOPSIS
        Deletes an elastic database pool
    
    .DESCRIPTION  
        
    .NOTES
        This PowerShell script was developed and optimized for ScriptRunner. The use of the scripts requires ScriptRunner. 
        The customer or user is authorized to copy the script from the repository and use them in ScriptRunner. 
        The terms of use for ScriptRunner do not apply to this script. In particular, AppSphere AG assumes no liability for the function, 
        the use and the consequences of the use of this freely available script.
        PowerShell is a product of Microsoft Corporation. ScriptRunner is a product of AppSphere AG.
        © AppSphere AG

    .COMPONENT
        Requires Module Az
        Requires Library script AzureAzLibrary.ps1

    .LINK
        https://github.com/scriptrunner/ActionPacks/blob/master/Azure        

    .Parameter AzureCredential
        The PSCredential object provides the user ID and password for organizational ID credentials, or the application ID and secret for service principal credentials

    .Parameter Tenant
        Tenant name or ID

    .Parameter PoolName
        Specifies the name of the elastic pool to remove

    .Parameter ServerName
        Specifies the name of the server that hosts the elastic pool

    .Parameter ResourceGroupName
        Specifies the name of the resource group to which the elastic pool is assigned
#>

param( 
    [Parameter(Mandatory = $true)]
    [pscredential]$AzureCredential,    
    [Parameter(Mandatory = $true)]
    [string]$PoolName,
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName,
    [Parameter(Mandatory = $true)]
    [string]$ServerName,
    [string]$Tenant
)

Import-Module Az

try{
#    ConnectAzure -AzureCredential $AzureCredential -Tenant $Tenant
    
    if([System.String]::IsNullOrWhiteSpace($Properties)){
        $Properties = '*'
    }
    [hashtable]$cmdArgs = @{'ErrorAction' = 'Stop'
                            'Force' = $null
                            'Confirm' = $false
                            'ElasticPoolName' = $PoolName
                            'ServerName' = $ServerName
                            'ResourceGroupName' = $ResourceGroupName}
    
    $null = Remove-AzSqlElasticPool @cmdArgs 
    $ret = "Elastic pool $($PoolName) removed"

    if($SRXEnv) {
        $SRXEnv.ResultMessage = $ret 
    }
    else{
        Write-Output $ret
    }
}
catch{
    throw
}
finally{
#    DisconnectAzure -Tenant $Tenant
}