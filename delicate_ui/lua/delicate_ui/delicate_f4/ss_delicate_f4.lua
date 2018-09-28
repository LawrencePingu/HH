if not SERVER then return end

local sorted_table = {}
if Delicate_UI.F4.Enabled then
    util.AddNetworkString( 'Delicate.Handle.OnF4Pressed' )
    function Delicate_UI.HandleF4Press( self )
        net.Start( 'Delicate.Handle.OnF4Pressed' )
        net.Send( self )
    end
    hook.Add( 'ShowSpare2', 'Delicate.Handle.F4Press', Delicate_UI.HandleF4Press )
end

-- Don't want to make a new file, but I refuse to use usermessage.Hook in 2018.

util.AddNetworkString( 'Delicate.Send.ArrestTime' )
hook.Add( 'playerArrested', 'Delicate.Handle.Arrest', function( targ, time, void )
    net.Start( 'Delicate.Send.ArrestTime' )
        net.WriteInt( time, 16 )
    net.Send( targ )
end)


util.AddNetworkString( 'Delicate.Send.TellAll' )
local function ccTellAll(ply, args)
    net.Start( "Delicate.Send.TellAll" )
        net.WriteString( args )
    net.Broadcast()

    if ply:EntIndex() == 0 then
        DarkRP.log("Console did admintellall \"" .. args .. "\"", Color(30, 30, 30))
    else
        DarkRP.log(ply:Nick() .. " (" .. ply:SteamID() .. ") did admintellall \"" .. args .. "\"", Color(30, 30, 30))
    end
end

hook.Add( 'PostGamemodeLoaded', 'Delicate.Handle.DarkRP', function()
    DarkRP.definePrivilegedChatCommand("admintellall", "DarkRP_AdminCommands", ccTellAll)
end )