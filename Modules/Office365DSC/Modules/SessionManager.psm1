function Watch-Throttling
{
    [CmdletBinding()]
    param
    (
        [int]
        $WaitTime = 11
    )
    #For long running cmdlet, detect throttling and pause the session
    #HERE - Need to find the right Trap Error and validate that could work in a function in a module.
    #Trap {Start-Sleep -Seconds $WaitTime}
}