    if not Delicate_UI.Scoreboard.Enabled or not CLIENT then return end

    include( 'delicate_ui/delicate_core/delicate_ui_themes.lua' )

    local delicate_base = nil
    local _s, theme, base_screen_w = 'Disconnected', Delicate_UI.Scoreboard.Themes[ Delicate_UI.Scoreboard.Theme ], 1366

    function Delicate_UI.CreateIconHeader( str, font, x, y, icon, align )
        Delicate_UI.DrawText( str, font, x, y, Color( 255, 255, 255 ), align and align or TEXT_ALIGN_CENTER )
        if icon then Delicate_UI.DrawIcon( icon, x - 27, y - 3 ) end
    end

    function Delicate_UI.GetPlayerSize()
        if not Delicate_UI.Scoreboard.Enable_Spy_Mode then return #player.GetAll() end
        local counter = 0
        for k, v in pairs( player.GetAll() ) do
            if Delicate_UI.Scoreboard.Spy_Mode_Groups[ v:GetUserGroup() ] then continue end
            counter = counter + 1
        end
        return counter
    end

    function Delicate_UI.CreateDiagBox( self, title, reason, time, args )
        local base = vgui.Create( 'DFrame' )
        base:SetSize( 325, time and reason and 165 or 114 )
        base:SetTitle( '' )
        base:ShowCloseButton( false )
        base:SetDraggable( false )
        base:Center()
        base:MakePopup()

        local newTitle = string.gsub( title, '#name', self:Nick() )

        base.Paint = function( me, w, h )
            if Delicate_UI.Scoreboard.Enable_Blur then Delicate_UI.BlurMenu( me, 16, 16, 255 ) end
            Delicate_UI.DrawRect( 0, 0, w, h, theme.background )
            Delicate_UI.DrawRect( 0, 0, w, 25, theme.interface_seperator )
            Delicate_UI.DrawRect( 0, 26, w, 2, theme.line_seperator )
            Delicate_UI.DrawIcon( Delicate_UI.Materials[ 'punish_tag' ], -3, -3 )
            Delicate_UI.DrawText( newTitle, 'Delicate.Font.21', 27, 3, theme.title_color, TEXT_ALIGN_LEFT )
            if reason then Delicate_UI.DrawText( Delicate_UI.Language.SCOREBOARD_INPUT_DISPLAY, 'Delicate.Font.19', 10, 30, theme.interface_headers, TEXT_ALIGN_LEFT ) end
            if time then Delicate_UI.DrawText( Delicate_UI.Language.SCOREBOARD_TIME_DISPLAY, 'Delicate.Font.19', 10, reason and 80 or 35, theme.interface_headers, TEXT_ALIGN_LEFT ) end
        end

        local close_bounds = vgui.Create( 'DLabel', base )
        close_bounds:SetSize( 21, 19 )
        close_bounds:SetPos( base:GetWide() - 24, 2 )
        close_bounds:SetText( ' x' )
        close_bounds:SetFont( 'Delicate.Font.24' )
        close_bounds:SetTextColor( Color( 224, 118, 118, 120 ) )
        close_bounds:SetMouseInputEnabled( true )
        close_bounds:SetCursor( 'hand' )
        close_bounds.DoClick = function() base:Close() end

        local reason_input, time_input

        if reason then
            reason_input = vgui.Create( 'DTextEntry', base )
            reason_input:SetFont( 'Delicate.Font.18' )
            reason_input:SetSize( 310, 25 )
            reason_input:SetText( '' )
            reason_input:SetPos( 10, 52 )
            reason_input.Paint = function( me, w, h )
                Delicate_UI.DrawRect( 0, 0, w, h, Color( 250, 250, 250, 200 ) )
                me:DrawTextEntryText( Color( 40, 40, 40 ), Color( 60, 60, 60 ), Color( 60, 60, 60 ) )
            end
        end

        if time then
            time_input = vgui.Create( 'DTextEntry', base )
            time_input:SetFont( 'Delicate.Font.18' )
            time_input:SetSize( 90, 25 )
            time_input:SetText( '' )
            time_input:SetPos( 10, not reason and 55 or 102 )
            time_input:SetNumeric( true )
            time_input.Paint = function( me, w, h )
                Delicate_UI.DrawRect( 0, 0, w, h, Color( 250, 250, 250, 200 ) )
                me:DrawTextEntryText( Color( 40, 40, 40 ), Color( 60, 60, 60 ), Color( 60, 60, 60 ) )
            end
        end

        local confirm = Delicate_UI.CreateButton( base, base:GetWide() / 2 - 60, time and reason and base:GetTall() / 2 + 48 or base:GetTall() - 33, 110, 30, 'Delicate.Font.19', Delicate_UI.Language.SCOREBOARD_CONFIRM_BUTTON )
        confirm.Paint = function( me, w, h )
            Delicate_UI.DrawRect( 0, 0, w, h, theme.confirm_button )
            if me:IsHovered() then
                local white_flash = 100 + math.abs( math.sin( CurTime() * 2 ) * 255 )
                Delicate_UI.DrawOutline( 0, 0, w, h, 2, Color( white_flash, white_flash, white_flash ) )
            end
        end

        confirm.DoClick = function()
            local _r, _t = reason and reason_input:GetValue(), time and tonumber( time_input:GetValue() )
            if not _r then _r = '' end
            if time and not _t or time and not _t and not isnumber( _t ) or not IsValid( self ) then LocalPlayer():ChatPrint( Delicate_UI.Language.SCOREBOARD_DATA_ERROR ) return end
            self:ConCommand( reason and time and string.format( '%s %s %i %s', args, self:Nick(), _t, _r ) or reason and string.format( '%s %s %s', args, self:Nick(), _r ) or time and string.format( '%s %s %i', args, self:Nick(), _t ) )
            base:Close()
        end
    end

    function Delicate_UI.CreateHeader( me, w, h, self )
        local row_y = 43
        Delicate_UI.DrawRect( 5, 40, w - 10, 2, theme.line_seperator )
        Delicate_UI.DrawRect( 5, 70, w - 10, 2, theme.line_seperator )

        Delicate_UI.CreateIconHeader( Delicate_UI.Language.SCOREBOARD_NAME_HEADER, 'Delicate.Font.23', 26, row_y, Delicate_UI.Materials[ 'name_tag' ], TEXT_ALIGN_LEFT )
        Delicate_UI.CreateIconHeader( Delicate_UI.Language.SCOREBOARD_JOB_HEADER, 'Delicate.Font.23', ScrW() <= base_screen_w and ScrW() * 0.24 or ScrW() * 0.17, row_y, Delicate_UI.Materials[ 'job_tag' ], TEXT_ALIGN_LEFT )
        Delicate_UI.CreateIconHeader( Delicate_UI.Language.SCOREBOARD_RANK_HEADER, 'Delicate.Font.23', ScrW() <= base_screen_w and ScrW() * 0.37 or ScrW() * 0.27, row_y, Delicate_UI.Materials[ 'law_tag' ], TEXT_ALIGN_LEFT )
        Delicate_UI.CreateIconHeader( Delicate_UI.Language.SCOREBOARD_KD_HEADER, 'Delicate.Font.23', ScrW() <= base_screen_w and ScrW() * 0.46 or ScrW() * 0.36, row_y, Delicate_UI.Materials[ 'gun_tag' ], TEXT_ALIGN_LEFT )
        Delicate_UI.CreateIconHeader( Delicate_UI.Language.SCOREBOARD_PING_HEADER, 'Delicate.Font.23', ScrW() <= base_screen_w and ScrW() * 0.55 or ScrW() * 0.42, row_y, Delicate_UI.Materials[ 'ping_tag' ], TEXT_ALIGN_LEFT )
    end

    function Delicate_UI.CreateScoreboard()
        local size_w = ScrW() <= base_screen_w and ScrW() * 0.63 or ScrW() * 0.47
        local self = LocalPlayer()
        gui.EnableScreenClicker( true )

        delicate_base = vgui.Create( 'DFrame' )
        delicate_base:SetSize( size_w, ScrH() * 0.8 )
        delicate_base:SetTitle( '' )
        delicate_base:ShowCloseButton( false )
        delicate_base:SetDraggable( false )

        delicate_base:SetPos( ( ScrW() * 0.5 ) - size_w * 0.5, ( ScrH() * 1.5 )  )
        delicate_base:MoveTo( ( ScrW() * 0.5 ) - size_w * 0.5, ( ScrH() * 0.5 ) - ScrH() * 0.4, 0.2 )

        delicate_base.Paint = function( me, w, h )
            if Delicate_UI.Scoreboard.Enable_Blur then Delicate_UI.BlurMenu( me, 16, 16, 255 ) end
            Delicate_UI.DrawRect( 0, 0, w, h, theme.background )
            Delicate_UI.DrawText( Delicate_UI.Server_Name, 'Delicate.Font.40', w / 2 - 20, -2, theme.title_color )
            Delicate_UI.CreateHeader( me, w, h, self )
            Delicate_UI.DrawText( string.format( 'There is currently %i out of %i %s online.', Delicate_UI.GetPlayerSize(), game.MaxPlayers(), 'players' ), 'Delicate.Font.20', w / 2 - 20, h - 25, theme.title_color )
            --Delicate_UI.DrawRect( 5, h - 35, w - 10, 30, theme.player_count_section )
            Delicate_UI.DrawRect( 20, h - 30, w - 40, 2, theme.line_seperator )
            --Delicate_UI.DrawRect( 0, h - 2, w, 2, theme.line_seperator )
        end

        local delicate_scroll = vgui.Create( 'DScrollPanel', delicate_base )
        delicate_scroll:SetPos( 5, 80 )
        delicate_scroll:SetSize( delicate_base:GetWide(), delicate_base:GetTall() - 115 )
        Delicate_UI.PaintBar( delicate_scroll, nil, nil, Color( 255, 255, 255 ) )

        local player_list = vgui.Create( 'DListLayout', delicate_scroll )
        player_list:SetSize( delicate_scroll:GetWide() - 10, delicate_scroll:GetTall() )
        --delicate_scroll.Paint = function( me, w, h ) Delicate_UI.DrawRect( 0, 0, w, h, Color( 200, 0, 0 ) ) end


        local my_table = DarkRP.getCategories()[ 'jobs' ]

        table.sort( my_table, function( tableA, tableB )
            if tableA.sortOrder and tableB.sortOrder then
                return tableA.sortOrder < tableB.sortOrder
            end
            return false
        end )
        -- This might be overcomplicated, but it works.
        for x, o in pairs( my_table ) do
            if not o[ 'members' ] then continue end
            for i = 1, #o[ 'members' ] do
                for j = 1, #player.GetAll() do
                    local targ = player.GetAll()[ j ]
                    if Delicate_UI.Scoreboard.Enable_Spy_Mode and Delicate_UI.Scoreboard.Spy_Mode_Groups[ targ:GetUserGroup() ] then continue end
                    if o[ 'members' ][ i ].name == team.GetName( targ:Team() ) then
                        local increase, split_value = 1, ( delicate_scroll:GetWide() - 10 ) / 100
                        local pan = vgui.Create( 'DCollapsibleCategory', player_list )
                        pan:SetExpanded( 0 )
                        pan:SetLabel( '' )
                        pan:SetSize( player_list:GetWide(), 25 )
                        pan:GetChildren()[1]:SetTall( 25 )
                        pan.Paint = function( me, w, h )
                            if not IsValid( targ ) then return end
                            local clr, y = team.GetColor( targ:Team() ), 2
                            Delicate_UI.DrawRect( 0, 0, w, h, Color( clr.r, clr.g, clr.b, 50 ) )
                            Delicate_UI.DrawText( targ:Nick(), 'Delicate.Font.18', 10, y, Delicate_UI.Staff[ targ:GetUserGroup() ] and Delicate_UI.Staff[ targ:GetUserGroup() ].color or theme.player_name, TEXT_ALIGN_LEFT )
                            Delicate_UI.DrawText( Delicate_UI.Staff[ targ:GetUserGroup() ] and Delicate_UI.Staff[ targ:GetUserGroup() ].name or 'User', 'Delicate.Font.18', ScrW() <= base_screen_w and ScrW() * 0.37 or ScrW() * 0.275, y, Delicate_UI.Staff[ targ:GetUserGroup() ] and Delicate_UI.Staff[ targ:GetUserGroup() ].color or theme.player_name )
                            Delicate_UI.DrawText( team.GetName( targ:Team() ), 'Delicate.Font.18', ScrW() <= base_screen_w and ScrW() * 0.24 or ScrW() * 0.17, y, theme.player_job )
                            Delicate_UI.DrawText( string.format( '%i:%i', targ:Frags() < 0 and 0 or targ:Frags(), targ:Deaths() < 0 and 0 or targ:Deaths() ), 'Delicate.Font.18', ScrW() <= base_screen_w and ScrW() * 0.46 or ScrW() * 0.36, y, theme.player_kd )
                            Delicate_UI.DrawText( targ:Ping() .. ' ms', 'Delicate.Font.18', ScrW() <= base_screen_w and ScrW() * 0.55 or ScrW() * 0.42, y, theme.player_ping )
                        end

                        local mute = vgui.Create( 'DImageButton', pan )
                        mute:SetSize( 16, 16 )
                        mute:SetPos( player_list:GetWide() - 25, 5 )
                        mute:SetImage( targ:IsMuted() and 'delicate_muted.png' or 'delicate_unmuted.png' )
                        mute:SetColor( Color( 255, 255, 255 ) )

                        mute.DoClick = function()
                            if targ:IsMuted() then targ:SetMuted( false ) else targ:SetMuted( true ) end
                            mute:SetImage( targ:IsMuted() and 'delicate_muted.png' or 'delicate_unmuted.png' )
                        end

                        local zone = vgui.Create( 'DPanelList' )
                        zone:SetSize( pan:GetWide(), pan:GetTall() )
                        zone:SetSpacing( 1 )
                        pan:SetContents( zone )

                        local pnl = vgui.Create( 'DPanel' )
                        pnl:SetSize( delicate_scroll:GetWide(), #Delicate_UI.Scoreboard.Buttons < split_value and 37 or 60 )
                        zone:AddItem( pnl )
                        pnl.Paint = function( me, w, h ) Delicate_UI.DrawRect( 0, 0, w, h, Color( 70, 70, 70, 100 ) ) end

                        for button_key, button_value in pairs( Delicate_UI.Scoreboard.Buttons ) do
                            if button_key > split_value then increase = increase + 1 end -- Work around to reset the buttons x position multi
                            local x_pos, y_pos = button_key < split_value and -100 + ( button_key * 103 ) or -203 + ( increase * 103 ), button_key < split_value and 8 or 34
                            local btn = Delicate_UI.CreateButton( pnl, x_pos, y_pos, 100, 25, 'Delicate.Font.16', button_value.buttonName )
                            btn.Paint = function( me, w, h )
                                Delicate_UI.DrawRect( 0, 0, w, h, Color( 4, 4, 4, 200 ) )
                                if me:IsHovered() then
                                    local white_flash = 100 + math.abs( math.sin( CurTime() * 2 ) * 255 )
                                    Delicate_UI.DrawOutline( 0, 0, w, h, 2, Color( white_flash, white_flash, white_flash ) )
                                end
                            end
                            btn.DoClick = function()
                                if not IsValid( targ ) then return end
                                if button_value.func then button_value.func( targ ) return end -- This is for the copying of Steam IDs.
                                if button_value.title then -- If no title, then we assume they just want to instantly exec.
                                    Delicate_UI.CreateDiagBox( targ, button_value.title, button_value.reason, button_value.time, button_value.cmd )
                                else
                                    LocalPlayer():ConCommand( button_value.cmd .. ' ' .. targ:Nick() )
                                end
                            end
                        end

                        player_list:Add( pan )
                    end
                end
            end
        end
    end

    function Delicate_UI.ShowScoreboard()
        if IsValid( delicate_base ) then delicate_base:Close() end
        Delicate_UI.CreateScoreboard()
        return true
    end
    hook.Add( 'ScoreboardShow', 'Delicate_UI.Handle.ScoreboardShow', Delicate_UI.ShowScoreboard )

    function Delicate_UI.HideScoreboard()
        if IsValid( delicate_base ) then 
            local size_w = ScrW() <= base_screen_w and ScrW() * 0.63 or ScrW() * 0.47
            delicate_base:MoveTo( ( ScrW() * 0.5 ) - size_w * 0.5, ScrH() + size_w, 0.2 )
            gui.EnableScreenClicker( false ) 
        end
        return true
    end
    hook.Add( 'ScoreboardHide', 'Delicate_UI.Handle.ScoreboardHide', Delicate_UI.HideScoreboard )
