--[[
    Developer: ted.lua (http://steamcommunity.com/id/tedlua/)
    Script: Delicate UI - The Complete UI Overhall.
--]]

if not Delicate_UI.HUD.Enabled or not CLIENT then return end

include( 'delicate_ui/delicate_core/delicate_ui_themes.lua' )

Delicate_UI.Disable_Components = {}

Delicate_UI.Disable_Components[ 'DarkRP_HUD' ] = true
Delicate_UI.Disable_Components[ 'CHudBattery' ] = true
Delicate_UI.Disable_Components[ 'CHudHealth' ] = true
Delicate_UI.Disable_Components[ 'CHudAmmo' ] = true
Delicate_UI.Disable_Components[ 'DarkRP_Hungermod' ] = true


local Delta, mat, theme = Delicate_UI, Delicate_UI.Materials, Delicate_UI.HUD.Themes[ Delicate_UI.HUD.Theme ]
local hud_gap, show_laws = 0, true

local self_meta = FindMetaTable( 'Player' )

if Delicate_UI.HUD.Enable_Overhead then
    self_meta.drawPlayerInfo = function( targ )
        if LocalPlayer():GetPos():Distance( targ:GetPos() ) > 120 then return end
        local eye_pos, font = targ:EyePos(), 'Delicate.Font.21'
        eye_pos.z = eye_pos.z + 16
        eye_pos = eye_pos:ToScreen()
        local start_x, start_y = eye_pos.x - 35, eye_pos.y - 15
        surface.SetFont( font )
        -- Name Section --
        local name_w, name_h = surface.GetTextSize( targ:Nick() )
        if Delicate_UI.HUD.Enable_Overhead_Blur then Delta.BlurRect( start_x, start_y + 4, name_w + 32, name_h + 3, 150 ) else Delta.DrawRect( start_x, start_y + 4, name_w + 32, name_h + 3, Color( 0, 0, 0, 150 ) ) end
        Delicate_UI.DrawText( targ:Nick(), font, start_x + 27, start_y + 4, Delicate_UI.Staff[ targ:GetUserGroup() ] and Delicate_UI.Staff[ targ:GetUserGroup() ].color or theme.player_name, TEXT_ALIGN_LEFT )
        Delta.DrawIcon( mat[ 'name_tag_large' ], start_x - 2, start_y - 2, Color( 255, 255, 255 ) )
        local job_w, job_h = surface.GetTextSize( team.GetName( targ:Team() ) )
        local health_y = eye_pos.y + 14
        local health_x, health_w, health_h = start_x - 20, 80, 21
        if Delicate_UI.HUD.Enable_Overhead_Blur then Delta.BlurRect( start_x, health_y, health_w, health_h + 3, 150 ) else Delta.DrawRect( start_x, health_y, health_w, health_h + 3, Color( 0, 0, 0, 150 ) ) end
        Delta.DrawIcon( mat[ 'health_tag_large' ], start_x - 2, start_y + 25, Color( 255, 255, 255 ) )
        Delicate_UI.DrawText( string.format( '%i%s', targ:Health(), '%' ), font, start_x + 27, health_y + 1, Delicate_UI.Staff[ targ:GetUserGroup() ] and Delicate_UI.Staff[ targ:GetUserGroup() ].color or theme.player_name, TEXT_ALIGN_LEFT )
        local job_y = eye_pos.y + 39
        if Delicate_UI.HUD.Enable_Overhead_Blur then Delta.BlurRect( start_x, job_y, job_w + 32, job_h + 3, 150 ) else Delta.DrawRect( start_x, job_y, job_w + 32, job_h + 3, Color( 0, 0, 0, 150 ) ) end
        Delicate_UI.DrawText( team.GetName( targ:Team() ), font, start_x + 27, job_y, Delicate_UI.Staff[ targ:GetUserGroup() ] and Delicate_UI.Staff[ targ:GetUserGroup() ].color or theme.player_name, TEXT_ALIGN_LEFT )
        Delta.DrawIcon( mat[ 'job_tag_large' ], start_x - 2, job_y - 3, Color( 255, 255, 255 ) )
        if Delicate_UI.HUD.ShowGunLicense and targ:getDarkRPVar( "HasGunlicense" ) then 
            Delta.DrawIcon( mat[ 'gun_license' ], start_x + 20, start_y - 35, Color( 255, 255, 255 ) )
        end
    end
    self_meta.drawWantedInfo = function( targ )
        if LocalPlayer():GetPos():Distance( targ:GetPos() ) > 300 then return end
        local eye_pos = targ:EyePos()
        eye_pos.z = targ:isWanted() and eye_pos.z + 15 or eye_pos.z + 13
        eye_pos = eye_pos:ToScreen()
        local wanted_x, wanted_y = eye_pos.x - 30, eye_pos.y - 50
        local wanted_w, wanted_h = surface.GetTextSize( Delicate_UI.Language.HUD_WANTED_OVERHEAD )
        font = 'Delicate.Font.30'
        Delicate_UI.DrawText( Delicate_UI.Language.HUD_WANTED_OVERHEAD, font, wanted_x + 40, wanted_y - 5, Color( 194 + math.abs( math.sin( CurTime() * 3 ) * 56 ), 80, 80, 140 ) )
    end
end

local show_popup, popup_message = false, ''

net.Receive( 'Delicate.Send.TellAll', function()
    timer.Remove("DarkRP_AdminTell")
    popup_message = net.ReadString()
    show_popup = true

    timer.Create("DarkRP_AdminTell", 10, 1, function()
        show_popup = false
        popup_message = ''
    end )
end )

local function DisplayNotify(msg)
    local txt = msg:ReadString()
    GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
    surface.PlaySound("buttons/lightswitch2.wav")

    -- Log to client console
    MsgC(Color(255, 20, 20, 255), "[DarkRP] ", Color(200, 200, 200, 255), txt, "\n")
end
usermessage.Hook("_Notify", DisplayNotify)

function Delicate_UI.HandleExternal( component )
    if Delicate_UI.Disable_Components[ component ] then return false end
end
hook.Add( 'HUDShouldDraw', 'Delicate_UI.Handle.HandleExternal', Delicate_UI.HandleExternal )

timer.Create( 'Delicate_UI.Handle.Laws', 1, 0, function()
    if not Delicate_UI.HUD.Enable_Laws then timer.Remove( 'Delicate_UI.Handle.Laws' ) end
    if input.IsKeyDown( KEY_F2 ) then
        if show_laws then show_laws = false else show_laws = true end
    end
end )

function Delicate_UI.CreateBase( top_x, top_y, top_w, top_h, bottom_h, header, header_x, header_y, header_color, font, icon, icon_x, icon_y, disable_second, mainStr )
    --> Top Section <--
    header_x, header_y = header_x or top_x + 22, header_y or top_y + 3
    icon_x, icon_y = icon_x or top_x - 5, icon_y or top_y - 2
    header_color = header_color or Color( 255, 255, 255 )
    font = font or 'Delicate.Font.22'
    if Delicate_UI.HUD.Enable_Blur then
        Delta.BlurRect( top_x, top_y, top_w, top_h, 120 ) -- First main bar
        if not disable_second then Delta.BlurRect( top_x, top_y + top_h + 1, top_w, bottom_h, 100 ) end
    end
    Delta.DrawRect( top_x, top_y, top_w, top_h, theme.top_bar )
    Delta.DrawRect( top_x, top_y + top_h - 2, top_w, 2, theme.middle_line )
    if not disable_second then Delta.DrawRect( top_x, top_y + top_h + 1, top_w, bottom_h, theme.bottom_bar ) end
    if header then Delta.DrawText( header, font, header_x, header_y, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT ) end
    if icon then Delta.DrawIcon( icon, icon_x, icon_y, header_color ) end
    if mainStr then
        local str = DarkRP.textWrap( mainStr, "Delicate.Font.19", top_w )
        --Delta.DrawText( str, 'Delicate.Font.19', top_w + 20, top_y + 1, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT )
        draw.DrawNonParsedText( str, 'Delicate.Font.19', top_x + 3, top_y + 30, Color( 255, 255, 255 ), 0 )
    end
end

local totalSize = 0

function Delicate_UI.DrawTextDisplay( x, y, w, h, text, col, icon, scale )
    surface.SetFont( 'Delicate.Font.22' )
    local bar_w, bar_h
    if scale then
        bar_w, bar_h = surface.GetTextSize( text )
        Delta.DrawRect( x, y, bar_w + 22, 21, col )
    else
        Delta.DrawRect( x, y, w + 22, 21, col )
    end
    Delta.DrawText( text, 'Delicate.Font.19', x + 20, y + 1, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT )
    if icon then Delta.DrawIcon( icon, x - 6, y - 6 ) end
    if scale then return bar_w end
end

local size = 445
function Delicate_UI.RenderAmmo( scr_w, scr_h )
    local self = LocalPlayer()
    if not self:Alive() or not IsValid( self:GetActiveWeapon() ) then return end
    local ammo, reserve = self:GetActiveWeapon():Clip1() < 0 and -2 or self:GetActiveWeapon():Clip1(), self:GetAmmoCount( self:GetActiveWeapon():GetPrimaryAmmoType() )
    local width, height, name = 250, 30, self:GetActiveWeapon():GetPrintName()
    surface.SetFont( 'Delicate.Font.24' )
    local top_w, top_h = surface.GetTextSize( name )
    local disabled = ammo <= 0 and reserve <= 0 and true or false
    Delicate_UI.CreateBase( scr_w - top_w - 53, scr_h - 96 + Delicate_UI.HUD.Pos_Manager[ 'ammo_increase_y' ], top_w + 43, 34, 25, name, nil, scr_h - 92 + Delicate_UI.HUD.Pos_Manager[ 'ammo_increase_y' ], nil, 'Delicate.Font.24', mat[ 'gun_tag' ], nil, scr_h - 97 + Delicate_UI.HUD.Pos_Manager[ 'ammo_increase_y' ], disabled )
    if disabled then return end
    Delicate_UI.DrawRect( scr_w - top_w - 52, scr_h - 58 + Delicate_UI.HUD.Pos_Manager[ 'ammo_increase_y' ], top_w + 40, 20, Color( 108, 108, 108, 140 ) )
    Delta.DrawIcon( mat[ 'ammo_tag' ], scr_w - top_w - 60, scr_h - 66 + Delicate_UI.HUD.Pos_Manager[ 'ammo_increase_y' ] )
    Delta.DrawText( string.format( '%i/%i', ammo, reserve ), 'Delicate.Font.19', scr_w - top_w - 34, scr_h - 58 + Delicate_UI.HUD.Pos_Manager[ 'ammo_increase_y' ], Color( 255, 255, 255 ), TEXT_ALIGN_LEFT )
end

function Delicate_UI.RenderWanted( scr_w, scr_h, reason )
    Delicate_UI.CreateBase( 20, scr_h / 2 - 325 / 2 + 75, 325, 25, 45, Delicate_UI.Language.HUD_WANTED_TITLE, nil, scr_h / 2 - 325 / 2 + 75, Color( 235, 136, 159, 200 ), 'Delicate.Font.22', mat[ 'wanted_tag' ], 15, scr_h / 2 - 325 / 2 - 5 + 75, false, reason )
end

function Delicate_UI.RenderLockdown( scr_w, scr_h )
    Delicate_UI.CreateBase( 20, scr_h / 2 - 325 / 2, 325, 25, 45, Delicate_UI.Language.HUD_LOCKDOWN_TITLE, nil, scr_h / 2 - 325 / 2 - 1, Color( 235, 136, 159, 200 ), 'Delicate.Font.22', mat[ 'lockdown_tag' ], 15, scr_h / 2 - 325 / 2 - 6, false, 'The Mayor has initiated a Lockdown, return to your homes!' )
end

function Delicate_UI.RenderAgenda( scr_w, scr_h )
    local self = LocalPlayer()
    local font, header, agenda = 'Delicate.Font.22', self:getAgendaTable(), self:getDarkRPVar( 'agenda' ) or ''
    if not header then return end
    agenda = agenda:gsub("//", "\n"):gsub("\\n", "\n")
    Delicate_UI.CreateBase( 20, 20 + Delicate_UI.HUD.Pos_Manager[ 'agenda_pos_y' ], 415, 25, 110, header.Title, nil, 20 + Delicate_UI.HUD.Pos_Manager[ 'agenda_pos_y' ], nil, font, mat[ 'agenda_tag' ], 15, 15 + Delicate_UI.HUD.Pos_Manager[ 'agenda_pos_y' ], false, agenda )
end

function Delicate_UI.RenderLaws( scr_w, scr_h )
    if not show_laws or #DarkRP.getLaws() < 1 then return end
    local laws = DarkRP.getLaws()
    local str, disabled, escape = '', true, ''
    if #laws >= 1 then disabled = false end
    for x = 1, 7 do escape = escape .. '\n' end
    Delicate_UI.CreateBase( scr_w - 435, 20 + Delicate_UI.HUD.Pos_Manager[ 'law_pos_y' ], 415, 34, laws and #laws < 4 and 19 * #laws or 18.5 * #laws or 0, Delicate_UI.Language.HUD_LAWS_TITLE .. escape .. Delicate_UI.Language.HUD_LAWS_TITLE_RIGHT, nil, 25 + Delicate_UI.HUD.Pos_Manager[ 'law_pos_y' ], nil, 'Delicate.Font.22', mat[ 'law_tag' ], nil, 20 + Delicate_UI.HUD.Pos_Manager[ 'law_pos_y' ], disabled )
    for k, v in pairs( laws ) do Delta.DrawText( '- ' .. v, 'Delicate.Font.17', scr_w - 430, Delicate_UI.HUD.Pos_Manager[ 'law_pos_y' ] + 39 + ( 18 * k ), Color( 255, 255, 255 ), TEXT_ALIGN_LEFT ) end
end

local startTime, endTime = 0, 0

net.Receive( 'Delicate.Send.ArrestTime', function() startTime, endTime = CurTime(), net.ReadInt( 16 ) end )

local function SecondsToClock( seconds )
    if seconds <= 0 then
        return "00:00"
    else
        mins = string.format( "%02.f", math.floor( seconds / 60 ) )
        secs = string.format( "%02.f", math.floor( seconds - mins * 60 ) )
        return mins.. ":" .. secs
    end
end

function Delicate_UI.RenderArrested( scr_w, scr_h )
    local font, header_string = surface.SetFont( 'Delicate.Font.25' ), Delicate_UI.Language.HUD_ARRESTED_TITLE
    local size_w, size_h = surface.GetTextSize( header_string )
    local start_x = scr_w / 2 - size_w / 2
    local time = math.ceil( endTime - ( CurTime() - startTime ) * 1 / game.GetTimeScale() )
    Delicate_UI.CreateBase( start_x - 50, Delicate_UI.HUD.Pos_Manager[ 'arrested_pos_y' ] + 30, size_w + 100, size_h, 45, header_string, start_x - 1, 28 + Delicate_UI.HUD.Pos_Manager[ 'arrested_pos_y' ], nil, 'Delicate.Font.24', nil, nil, nil, disabled )
    Delta.DrawText( Delicate_UI.Language.HUD_ARRESTED_FOOTER, 'Delicate.Font.23', start_x + 105, 56 + Delicate_UI.HUD.Pos_Manager[ 'arrested_pos_y' ], Color( 255, 255, 255 ) )
    Delta.DrawText( SecondsToClock( time ), 'Delicate.Font.23', start_x + 97, 66 + Delicate_UI.HUD.Pos_Manager[ 'arrested_pos_y' ] + 10, Color( 194 + math.abs( math.sin( CurTime() * 3 ) * 56 ), 80, 80, 140 ) )
end

function Delicate_UI.CallBaseHUD( scr_w, scr_h )
    local self = LocalPlayer()
    local health_glow, food_glow = Color( 174 + math.abs( math.sin( CurTime() * 3 ) * 81 ), 30, 30, 100 ), Color( 185 + math.abs( math.sin( CurTime() * 3 ) * 70 ), 202 + math.abs( math.sin( CurTime() * 3 ) * 53 ), 4, 100 )
    Delicate_UI.CreateBase( 20, ( scr_h - 96 ) + Delicate_UI.HUD.Pos_Manager[ 'hud_increase_y' ], size, 30, 23, self:Nick(), nil, nil, nil, nil, mat[ 'name_tag' ], nil, nil )
    local x = Delicate_UI.DrawTextDisplay( 21, scr_h - 64 + Delicate_UI.HUD.Pos_Manager[ 'hud_increase_y' ], nil, nil, team.GetName( self:Team() ), theme.job_bar, mat[ 'job_tag' ], true )
    size = Delicate_UI.HUD.Enable_Food_Bar and 401 + x or 338 + x
    Delicate_UI.DrawTextDisplay( 44 + x, scr_h - 64 + Delicate_UI.HUD.Pos_Manager[ 'hud_increase_y' ], 50, 20, self:Health() > 1000 and 'Lots' or ( self:Health() < 0 and 0 or self:Health() ) .. '%', self:Health() > 25 and theme.health_bar or health_glow, mat[ 'health_tag' ] )
    Delicate_UI.DrawTextDisplay( 117 + x, scr_h - 64 + Delicate_UI.HUD.Pos_Manager[ 'hud_increase_y' ], 40, 20, ( self:Armor() < 0 and 0 or self:Armor() ) .. '%', theme.armor_bar, mat[ 'armor_tag' ] )
    if Delicate_UI.HUD.Enable_Food_Bar and self:getDarkRPVar( 'Energy' ) then
        Delicate_UI.DrawTextDisplay( 180 + x, scr_h - 64 + Delicate_UI.HUD.Pos_Manager[ 'hud_increase_y' ], 40, 20, ( math.Round( self:getDarkRPVar( 'Energy' ) ) or 0 ) .. '%', self:getDarkRPVar( 'Energy' ) > 25 and theme.hunger_bar or food_glow, mat[ 'hunger_tag' ] )
    end
    Delta.DrawRect( Delicate_UI.HUD.Enable_Food_Bar and 243 + x or 180 + x, scr_h - 64 + Delicate_UI.HUD.Pos_Manager[ 'hud_increase_y' ], 105, 21, theme.cash_bar )
    Delta.DrawText( DarkRP.formatMoney( self:getDarkRPVar( 'money' ) ), 'Delicate.Font.19', Delicate_UI.HUD.Enable_Food_Bar and x + 245 or x + 184, scr_h - 64 + 1 + Delicate_UI.HUD.Pos_Manager[ 'hud_increase_y' ], Color( 255, 255, 255 ), TEXT_ALIGN_LEFT )
    Delicate_UI.DrawTextDisplay( Delicate_UI.HUD.Enable_Food_Bar and 349 + x or 286 + x, scr_h - 64 + Delicate_UI.HUD.Pos_Manager[ 'hud_increase_y' ], 49, 20, DarkRP.formatMoney( self:getDarkRPVar( 'salary' ) ), theme.salary_bar, mat[ 'salary_tag' ] )
end

function Delicate_UI.RenderHUD()
    local scr_w, scr_h, self = ScrW(), ScrH(), LocalPlayer() -- Update the screen resoultion per frame in case they change it.
    if Delicate_UI.HUD.Enable_Base_HUD then Delicate_UI.CallBaseHUD( scr_w, scr_h ) end
    if Delicate_UI.HUD.Enable_Ammo then Delicate_UI.RenderAmmo( scr_w, scr_h ) end
    if GetGlobalBool( "DarkRP_LockDown" ) then Delicate_UI.RenderLockdown( scr_w, scr_h ) end
    if self:isWanted() then Delicate_UI.RenderWanted( scr_w, scr_h, self:getWantedReason() or 'You have done something illegal.' ) end
    if Delicate_UI.HUD.Enable_Agenda then Delicate_UI.RenderAgenda( scr_w, scr_h ) end
    if Delicate_UI.HUD.Enable_Laws then Delicate_UI.RenderLaws( scr_w, scr_h ) end
    if Delicate_UI.HUD.Enable_Overhead and LocalPlayer():isArrested() then Delicate_UI.RenderArrested( scr_w, scr_h ) end
    if show_popup then
        Delta.BlurRect( 10, 10, ScrW() - 20, 110, 100 )
        Delta.DrawRect( 10, 10, ScrW() - 20, 110, theme.top_bar )
        draw.DrawNonParsedText(DarkRP.getPhrase("listen_up"), "Delicate.Font.70", ScrW() / 2 + 10, 10, Color( 194 + math.abs( math.sin( CurTime() * 3 ) * 56 ), 80, 80, 140 ), 1)
        draw.DrawNonParsedText(popup_message, "Delicate.Font.25", ScrW() / 2 + 10, 80, Color( 255, 255, 255 ) , 1)
    end
end
hook.Add( 'HUDPaint', 'Delicate_UI.Handle.HUDPaint', Delicate_UI.RenderHUD )
