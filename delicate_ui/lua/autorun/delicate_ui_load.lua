    if SERVER then
        resource.AddFile( 'resource/fonts/Roboto-Bold.ttf' )

        AddCSLuaFile( 'delicate_ui/delicate_ui_config.lua' )
        AddCSLuaFile( 'delicate_ui/delicate_ui_language.lua' )
        AddCSLuaFile( 'delicate_ui/delicate_core/delicate_ui_core.lua' )
        AddCSLuaFile( 'delicate_ui/delicate_core/delicate_ui_themes.lua' )
        AddCSLuaFile( 'delicate_ui/delicate_core/delicate_ui_graphics.lua' )
        AddCSLuaFile( 'delicate_ui/delicate_hud/delicate_ui_hud.lua' )
        AddCSLuaFile( 'delicate_ui/delicate_scoreboard/delicate_ui_scoreboard.lua' )
        AddCSLuaFile( 'delicate_ui/delicate_f4/cs_delicate_f4.lua' )


        include( 'delicate_ui/delicate_ui_config.lua' )
        include( 'delicate_ui/delicate_f4/ss_delicate_f4.lua' )

    else
        include( 'delicate_ui/delicate_ui_config.lua' )
        include( 'delicate_ui/delicate_ui_language.lua' )
        include( 'delicate_ui/delicate_core/delicate_ui_core.lua' )
        include( 'delicate_ui/delicate_core/delicate_ui_themes.lua' )
        include( 'delicate_ui/delicate_core/delicate_ui_graphics.lua' )
        include( 'delicate_ui/delicate_hud/delicate_ui_hud.lua' )
        include( 'delicate_ui/delicate_scoreboard/delicate_ui_scoreboard.lua' )
        include( 'delicate_ui/delicate_f4/cs_delicate_f4.lua' )

        hook.Add( 'PostGamemodeLoaded', 'Delicate_UI.Block.Inputs', function()
            if Delicate_UI.Scoreboard.Enabled then
                hook.Remove( 'ScoreboardShow', 'FAdmin_scoreboard' )
                hook.Remove( 'ScoreboardHide', 'FAdmin_scoreboard' )
            end
            if Delicate_UI.F4.Enabled then
                function GAMEMODE:ShowSpare2() return false end -- This overwrites the default F4 menu, because there's no hook attatched to it.
            end
        end )
    end
