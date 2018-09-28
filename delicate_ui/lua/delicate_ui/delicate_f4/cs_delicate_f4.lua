if not Delicate_UI.F4.Enabled or not CLIENT then return end

include( 'delicate_ui/delicate_core/delicate_ui_themes.lua' )

local theme = Delicate_UI.F4.Themes[ Delicate_UI.F4.Theme ]

function Delicate_UI.GetUseableContent( tbl, hide_item, title, verify )
    local useable_data = {}
    for k, v in pairs( tbl or {} ) do
        if verify and not verify( v ) then continue end
        if v.customCheck then
            if hide_item then
                if not v.customCheck( LocalPlayer() ) then
                    continue
                end
            end
        end
        if v.canSee and not v.canSee() then continue end
        if title and title == 'Singles' and GAMEMODE.Config.restrictbuypistol then -- Literal aids.
            if v.allowed then
                if type( v.allowed ) == 'table' then
                    if not table.HasValue( v.allowed, LocalPlayer():Team() ) then continue end
                else
                    if v.allowed ~= '' and LocalPlayer():Team() ~= v.allowed then continue end
                end
            end
        else
            if title ~= 'Singles' and v.allowed then
                if type( v.allowed ) == 'table' then
                    if not table.HasValue( v.allowed, LocalPlayer():Team() ) then continue end
                else
                    if v.allowed ~= '' and LocalPlayer():Team() ~= v.allowed then continue end
                end
            end
        end
        table.insert( useable_data, v )
    end
    return useable_data
end

function Delicate_UI.CreateBrowser( canvis, link )
    local foreground = vgui.Create( 'DPanel', canvis )
    foreground:SetSize( canvis:GetWide(), canvis:GetTall() )
    foreground.Paint = function( me, w, h )
        local x, y = w / 2 - 80, 50
        local white_flash = 100 + math.abs( math.sin( CurTime() * 2 ) * 255 )
        Delicate_UI.DrawRect( 0, 0, w, h, Color( 0, 0, 0, 150 ) )
        Delicate_UI.DrawText( Delicate_UI.Language.F4_LOADING_PAGE, 'Delicate.Font.30', x + 45, y, Color( white_flash, white_flash, white_flash ) )
        Delicate_UI.DrawOutline( x - 100, y - 4, 300, 40, 2, Color( white_flash, white_flash, white_flash ) )
    end

    local html_panel = vgui.Create( 'DHTML', foreground )
    html_panel:SetSize( foreground:GetWide(), foreground:GetTall() - 50 )
    html_panel:OpenURL( link )

    local open_button = vgui.Create( 'DButton', foreground )
    open_button:SetSize( foreground:GetWide(), 50 )
    open_button:SetPos( 0, foreground:GetTall() - 50 )
    open_button:SetFont( 'Delicate.Font.28' )
    open_button:SetText( Delicate_UI.Language.F4_OPEN_PAGE )
    open_button:SetTextColor( theme.general_info )
    open_button.Paint = function( me, w, h )
        local white_flash = 100 + math.abs( math.sin( CurTime() * 2 ) * 255 )
        Delicate_UI.DrawOutline( 0, 0, w, h, 2, Color( white_flash, white_flash, white_flash ) )
        Delicate_UI.DrawRect( 0, 0, w, h, Color( 0, 0, 0, 150 ) )
    end
    open_button.DoClick = function() gui.OpenURL( link ) end

    canvis:AddItem( foreground )
end

function Delicate_UI.FormCategory( my_home, title, string_one, string_two, showIcon, context, fov, check, onbuy )
    local new_data = Delicate_UI.GetUseableContent( context, Delicate_UI.F4.Hide_Unusable_Content, title, check )
    if #new_data < 1 then return end
    local font_size = ScrW() < 1600 and 'Delicate.Font.18' or 'Delicate.Font.20'
    local section_one = vgui.Create( 'DPanel', my_home )
    section_one:SetSize( my_home:GetWide(), ( 79 * math.ceil( #new_data / 3 ) ) + 42 )
    section_one.Paint = function( me, w, h )
        Delicate_UI.DrawText( title, 'Delicate.Font.26', 10, -1, theme.general_info, TEXT_ALIGN_LEFT )
        Delicate_UI.DrawRect( 10, 23, surface.GetTextSize( title ), 2, theme.general_info )
    end

    local section_two = vgui.Create( 'DPanelList', section_one )
    section_two:SetPos( 10, 32 )
    section_two:SetSize( section_one:GetWide(), section_one:GetTall() )
    section_two:EnableHorizontal( true )
    section_two:SetSpacing( 5 )

    for k, v in pairs( new_data ) do
        local item_holster = vgui.Create( 'DPanel', section_two )
        item_holster:SetSize( ScrW() <= 1600 and ScrW() * 0.192 or ScrW() * 0.165, 75 )

        local price = v.price
        if title == 'Singles' then price = v.pricesep end
        if price == 0 then price = 'Free' else price = DarkRP.formatMoney( price ) end

        item_holster.Paint = function( me, w, h )
            Delicate_UI.DrawRect( 0, 0, w, h, theme.shop_outter )
            Delicate_UI.DrawRect( 3, 3, w - 6, h - 6, theme.shop_inner )
            Delicate_UI.DrawText( v.name, font_size, 70, 15, theme.general_info, TEXT_ALIGN_LEFT )
            Delicate_UI.DrawText( price, font_size, 70, 40, theme.general_info, TEXT_ALIGN_LEFT )
            if me:IsHovered() then
                local white_flash = 100 + math.abs( math.sin( CurTime() * 2 ) * 255 )
                Delicate_UI.DrawOutline( 0, 0, w, h, 2, Color( white_flash, white_flash, white_flash ) )
            end
        end

        item_holster.OnMousePressed = function() onbuy( k, v ) end

        local model = vgui.Create( 'DModelPanel', item_holster )
        model:SetSize( 60, 60 )
        model:SetPos( 7, 4 )
        model:SetModel( v.model )
        model.LayoutEntity = function() return end

        local mn, mx = model.Entity:GetRenderBounds()
        local size = 0
        size = math.max( size, math.abs(mn.x) + math.abs(mx.x) )
        size = math.max( size, math.abs(mn.y) + math.abs(mx.y) )
        size = math.max( size, math.abs(mn.z) + math.abs(mx.z) )
        model:SetFOV( fov )
        model:SetCamPos( Vector( size, size, size ) )
        model:SetLookAt( ( mn + mx ) * 0.5 )

        section_two:AddItem( item_holster )
    end
    my_home:AddItem( section_one )
end

function Delicate_UI.CreateShop( base, canvis )

    local panel = vgui.Create( 'DPanel', canvis )
    panel:SetSize( canvis:GetWide(), canvis:GetTall()  )

    local parent = vgui.Create( 'DPanelList', panel ) -- This holds all of the categories into one parent.
    parent:SetSize( panel:GetWide(), panel:GetTall() )
    parent:EnableVerticalScrollbar( true )
    Delicate_UI.PaintBar( parent, nil, nil, theme.general_info )
    panel.Paint = function() end

    if Delicate_UI.F4.Enabled_Store_Components[ 'ammo_section' ] then
        Delicate_UI.FormCategory( parent, 'Ammo', '', '', true, GAMEMODE.AmmoTypes, 60, nil, function( _, key )
            RunConsoleCommand( 'darkrp', 'buyammo', key.ammoType )
        end )
    end
    if Delicate_UI.F4.Enabled_Store_Components[ 'entities_section' ] then
        Delicate_UI.FormCategory( parent, 'Entities', '', '', true,  DarkRPEntities, 60, nil, function( _, key ) RunConsoleCommand( 'darkrp', key.cmd ) end )
    end
    if Delicate_UI.F4.Enabled_Store_Components[ 'shipments_section' ] then
        Delicate_UI.FormCategory( parent, 'Shipments', '', '', true, CustomShipments, 40, function( key )
            if not key.noship then return true end
            return false
        end,
        function( _, key ) RunConsoleCommand( 'darkrp', 'buyshipment', key.name ) end )
    end
    if Delicate_UI.F4.Enabled_Store_Components[ 'singles_section' ] then
        Delicate_UI.FormCategory( parent, 'Singles', '', '', true, CustomShipments, 40, function( key )
            if key.seperate then return true end
            return false
        end, function( _, key ) RunConsoleCommand( 'darkrp', 'buy', key.name ) end )
    end
    if Delicate_UI.F4.Enabled_Store_Components[ 'food_section' ] then
        Delicate_UI.FormCategory( parent, 'Food', '', '', true, FoodItems, 60, function( key )
            if key.requiresCook == nil and LocalPlayer():isCook() or key.requiresCook == true and LocalPlayer():isCook() == true then
                 return true
            end
            if key.requiresCook == false then return true end
            return false
        end, function( _, key ) RunConsoleCommand( 'darkrp', 'buyfood', key.name ) end )
    end
    if Delicate_UI.F4.Enabled_Store_Components[ 'vehicles_section' ] then
        Delicate_UI.FormCategory( parent, 'Vehicles', '', '', true, CustomVehicles, 60, nil, function( _, key ) RunConsoleCommand( 'darkrp', 'buyvehicle', key.name ) end )
    end
    canvis:AddItem( panel )
end

function Delicate_UI.GetCurrentSize( name )
    local size = 0
    for k, v in pairs( RPExtraTeams ) do
        if v.name == name then
            size = team.NumPlayers( k )
        end
    end
    return size
end

local can_open_menu = true
function Delicate_UI.CreateModelInter( base, value, num )
    can_open_menu = false
    local frame = vgui.Create( 'DFrame', base )
    frame:SetDraggable( false )
    frame:SetSize( 450, #value.model < 5 and 110 or ( 60 * math.ceil( #value.model / 5 ) ) )
    frame:Center()
    frame:SetTitle( '' )
    frame:SetVisible( true )
    frame:ShowCloseButton( false ) 

    frame.Paint = function( me, w, h )
        if Delicate_UI.F4.Enable_Blur then Delicate_UI.BlurMenu( me, 16, 16, 255 ) end
        Delicate_UI.DrawRect( 0, 0, w, h, theme.background )
        --Delicate_UI.DrawRect( 0, 0, w, 2, theme.line_seperator )
        Delicate_UI.DrawRect( 0, 30, w, 2, theme.line_seperator )
        Delicate_UI.DrawText( 'Select a Model', 'Delicate.Font.20', 10, 5, theme.title_color, TEXT_ALIGN_LEFT )
    end

    local close_bounds = vgui.Create( 'DLabel', frame )
    close_bounds:SetSize( 21, 19 )
    close_bounds:SetPos( frame:GetWide() - 24, 4 )
    close_bounds:SetText( ' x' )
    close_bounds:SetFont( 'Delicate.Font.24' )
    close_bounds:SetTextColor( Color( 255, 255, 255 ) )
    close_bounds:SetMouseInputEnabled( true )
    close_bounds:SetCursor( 'hand' )
    close_bounds.DoClick = function() 
        can_open_menu = true
        frame:Close() 
    end

    local model_panel = vgui.Create( 'DPanelList', frame )
    model_panel:SetSize( frame:GetWide(), frame:GetTall() - 50 )
    model_panel:SetPos( 10, 40 )
    model_panel:EnableHorizontal( true )
    model_panel:SetSpacing( 3 )

    for k, v in pairs( value.model ) do
        local model = vgui.Create( 'DModelPanel', model_panel )
        model:SetSize( 45, 60 )
        model:SetPos( 10, 5 )
        model:SetFOV( 30 )
        model:SetCamPos( Vector( 22, 0, 65 ) )
        model:SetLookAt( Vector( 10, 0, 65 ) )
        model.LayoutEntity = function() return end
        model:SetModel( v )

        model:SetToolTip( v )

        model.OnMousePressed = function()
            for x, o in pairs( RPExtraTeams ) do
                if value.name == o.name then DarkRP.setPreferredJobModel( x, v ) end
            end
            timer.Simple( 0.2, function() RunConsoleCommand( 'darkrp', value.vote and 'vote' .. value.command or value.command ) end )
            frame:Close() base:Close()
            can_open_menu = true
        end

        model_panel:AddItem( model )
    end


end


function Delicate_UI.CreateJobs( base, canvis )
    local panel = vgui.Create( 'DPanel', canvis )
    panel:SetSize( canvis:GetWide(), canvis:GetTall()  )

    local parent = vgui.Create( 'DPanelList', panel ) -- This holds all of the categories into one parent.
    parent:SetSize( panel:GetWide(), panel:GetTall() )
    parent:EnableVerticalScrollbar( true )
    Delicate_UI.PaintBar( parent, nil, nil, theme.general_info )
    panel.Paint = function() end

    local sorted_cat, sorted_table = DarkRP.getCategories().jobs, {}

    for x = 1, #sorted_cat do
        if sorted_cat[ x ].sortOrder then
            table.insert( sorted_table, { data = sorted_cat[ x ], order = sorted_cat[ x ].sortOrder } )
        end
    end

    table.sort( sorted_table, function( a, b ) return a.order < b.order end )

    for k, v in pairs( sorted_table ) do
       if #v.data.members < 1 then continue end
       if v.data.canSee and not v.data.canSee( LocalPlayer() ) then continue end
       surface.SetFont( 'Delicate.Font.26' )
       local line_w, line_clr = surface.GetTextSize( v.data.name ), v.data.color
       local shouldShow = true
       local tbl = Delicate_UI.GetUseableContent( v.data.members, Delicate_UI.F4.Hide_Unusable_Content, 'Jobs', function( key )
           if key.name == team.GetName( LocalPlayer():Team() ) then
           if #v.data.members == 1 then shouldShow = false end
           return false end
           if key.customCheck then
               if Delicate_UI.F4.Hide_Unusable_Content then
                   if not key.customCheck( LocalPlayer() ) then
                       return false
                   end
               end
           end
           return true
       end )
       if not shouldShow then continue end -- Prevent category creating if nothing to see.

       local category = vgui.Create( 'DPanel', parent )
       category:SetSize( canvis:GetWide(), ( 75 * math.ceil( #tbl / 2 ) ) + 40 )
       category.Paint = function( me, w, h )
           Delicate_UI.DrawText( v.data.name, 'Delicate.Font.26', 10, 3, theme.general_info, TEXT_ALIGN_LEFT )
           Delicate_UI.DrawRect( 10, 28, line_w, 2, Color( line_clr.r, line_clr.g, line_clr.b, 150 ) )
       end

       local job_list = vgui.Create( 'DPanelList', category )
       job_list:SetPos( 10, 40 )
       job_list:SetSize( canvis:GetWide(), category:GetTall() )
       job_list:EnableHorizontal( true )
       --job_list.Paint = function( me, w, h ) Delicate_UI.DrawRect( 0, 0, w, h, Color( 200, 0, 0 ) ) end

       for id, value in pairs( tbl ) do
           --if value.name == team.GetName( LocalPlayer():Team() ) then continue end
           local item = vgui.Create( 'DPanel', job_list )
           item:SetSize( ScrW() <= 1600 and ScrW() * 0.292 or ScrW() * 0.25, 75 )
           item.Paint = function( me, w, h )
               local clr, increase = team.GetColor( id ), 15

               Delicate_UI.DrawRect( 0, 0, w, h, theme.job_outter )
               Delicate_UI.DrawRect( 3, 3, w - 6, h - 6, theme.job_inner )
               Delicate_UI.DrawText( value.name, 'Delicate.Font.21', 90, 13, theme.general_info, TEXT_ALIGN_LEFT )
               Delicate_UI.DrawText( DarkRP.formatMoney( value.salary ), 'Delicate.Font.21', 89, 40, theme.general_info, TEXT_ALIGN_LEFT )
               Delicate_UI.DrawRoundedBox( 4, w - 77, h - 40, 70, 30, Color( 118, 224, 155, 50 ) )
               Delicate_UI.DrawText( Delicate_UI.GetCurrentSize( value.name ) .. '/' .. ( value.max == 0 and '∞' or value.max ), 'Delicate.Font.22', w - 43, h - 37, theme.general_info )
               if me:IsHovered() then
                   local white_flash = 100 + math.abs( math.sin( CurTime() * 2 ) * 255 )
                   Delicate_UI.DrawOutline( 0, 0, w, h, 2, Color( white_flash, white_flash, white_flash ) )
               end
               item:SetToolTip( value.description )
           end

           item.OnCursorEntered = function() my_selection = value end

           item.OnMousePressed = function()
               --if v.customCheck and not v.customCheck( LocalPlayer() ) then print( 'Yeah, no' ) return end
               if type( value.model ) == 'table' and #value.model > 1 then
                    if not can_open_menu then return end
                    Delicate_UI.CreateModelInter( base, value, id )
               else
                    can_open_menu = true
                    RunConsoleCommand( 'darkrp', value.vote and 'vote' .. value.command or value.command )
                    base:Close()
               end
           end

           local model = vgui.Create( 'DModelPanel', item )
           model:SetSize( 60, 60 )
           model:SetPos( 10, 5 )
           model:SetFOV( 34 )
           model:SetCamPos( Vector( 25, 0, 65 ) )
           model:SetLookAt( Vector( 10, 0, 65 ) )
           model.LayoutEntity = function() return end
           model:SetModel( type( value.model ) == 'table' and value.model[ 1 ] or value.model )
           job_list:AddItem( item )
       end
       parent:AddItem( category )
    end

   canvis:AddItem( panel ) -- Insert the parent onto the Canvis, allowing us to remove it.
end

function Delicate_UI.RenderF4()
    local size_w, size_h = ScrW() <= 1600 and ScrW() * 0.6 or ScrW() * 0.512, ScrH() <= 900 and ScrH() * 0.85 or ScrH() * 0.8
    local my_selection, btn_selection = nil, Delicate_UI.F4.DefaultTab
    local base = vgui.Create( 'DFrame' )
    base:SetSize( size_w, size_h )
    base:SetTitle( '' )
    base:ShowCloseButton( false )
    base:SetDraggable( false )
    base:Center()
    base:MakePopup()

    local close_button = Delicate_UI.CreateButton( base, base:GetWide() - 110, 10, 100, 35, 'Delicate.Font.20', 'Close' )
    close_button.DoClick = function() base:Close() can_open_menu = true end
    
    timer.Simple( 0.4, function()
        if IsValid( base ) then
            base.Think = function() if IsValid( base ) and input.IsKeyDown( KEY_F4 ) then can_open_menu = true base:Close() end end
        end
    end )

    base.Paint = function( me, w, h )
        if Delicate_UI.F4.Enable_Blur then Delicate_UI.BlurMenu( me, 16, 16, 255 ) end
        Delicate_UI.DrawRect( 0, 0, w, h, theme.background )
        Delicate_UI.DrawText( Delicate_UI.F4.Header, 'Delicate.Font.20', 10, 5, theme.title_color, TEXT_ALIGN_LEFT )
        Delicate_UI.DrawText( Delicate_UI.F4.Footer, 'Delicate.Font.30', 10, 25, theme.title_color, TEXT_ALIGN_LEFT )
        Delicate_UI.DrawRect( 0, 57, w, 2, theme.line_seperator )
        Delicate_UI.DrawRect( 0, 90, w, 2, theme.line_seperator )
    end

    local dock_right = vgui.Create( 'DPanelList', base )
    dock_right:SetPos( 2, 60 )
    dock_right:SetSize( base:GetWide(), 46 )
    dock_right:EnableHorizontal( true )
    dock_right:SetStretchHorizontally( true )
    dock_right:SetSpacing( 7 )

    local canvis = vgui.Create( 'DPanelList', base )
    canvis:SetPos( 0, 93 )
    canvis:SetSize( base:GetWide(), base:GetTall() - 95 )

    for k, v in pairs( Delicate_UI.F4.EnabledButtons ) do
        local font = 'Delicate.Font.24'
        surface.SetFont( font )
        local w, h = surface.GetTextSize( v.name )
        local btn = Delicate_UI.CreateButton( pnl, ScrW() * 0.4, 10, w + 20, 30, font, v.name )
        dock_right:AddItem( btn )

        btn.Paint = function( me, w, h )
            if me:IsHovered() then
                Delicate_UI.DrawRect( 0, 0, w, h, v.tab_color )
            end
            if btn_selection == v.tab and not me:IsHovered() then
                local white_flash = 100 + math.abs( math.sin( CurTime() * 2 ) * 255 )
                Delicate_UI.DrawRect( 0, 0, w, h, v.tab_color )
                Delicate_UI.DrawRect( 0, me:GetTall() - 3, w, 2, Color( white_flash, white_flash, white_flash ) )
            end
        end

        btn.DoClick = function()
           btn_selection = v.tab
           canvis:Clear()
           if v.link then Delicate_UI.CreateBrowser( canvis, v.link ) else Delicate_UI.HandleTabProcess( base, v.tab, canvis ) end
        end

        if v.tab == Delicate_UI.F4.DefaultTab then
            if v.link then Delicate_UI.CreateBrowser( canvis, v.link ) else Delicate_UI.HandleTabProcess( base, v.tab, canvis ) end
        end
    end
end
net.Receive( 'Delicate.Handle.OnF4Pressed', Delicate_UI.RenderF4 )

local tab_process = { -- This is a workaround to allow people to change the tabs which translate to the function. So they can use whatever string name they want.
    { tag = 'jobs_tab', func = Delicate_UI.CreateJobs },
    { tag = 'shop_tab', func = Delicate_UI.CreateShop }
}

function Delicate_UI.HandleTabProcess( base, identifier, parent )
    for k, v in ipairs( tab_process ) do
        if identifier == v.tag then v.func( base, parent ) end
    end
end
