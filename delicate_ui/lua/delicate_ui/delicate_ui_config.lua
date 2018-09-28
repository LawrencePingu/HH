    --[[
        Developer: ted.lua (http://steamcommunity.com/id/tedlua/)
        Script: Delicate UI - The Complete UI Overhall.
    --]]

    Delicate_UI = Delicate_UI or {}
    Delicate_UI.HUD = {}
    Delicate_UI.Scoreboard = {}
    Delicate_UI.F4 = {}

    -----------------------
    --> Global Settings <--
    -----------------------

    --[[
        In order to create a rank, follow these simple instructions.
        First of all, ensure that the ingame rank is EXACTLY the same as the [ 'group_name_here' ]
        So, if your group name is doughnut_Destroyer in game then it would be:
        [ 'doughnut_Destroyer' ] = { name = "Maybe I should eat less", color = Color( 200, 0, 0 ) }
        'name' is the rank you want to see and color, well that needs no explanation.
        Do not forget a comma if you add rank to the table.
    ]]

    Delicate_UI.Staff = { -- Here you can make Staff groups specific colors.
        [ 'superadmin' ] = { name = 'Super Administrator', color = Color( 255, 255, 255 ) },
        [ 'admin' ] = { name = 'Administrator', color = Color( 255, 255, 0 ) },
        [ 'founder' ] = { name = 'Founder', color = Color( 200, 0, 0 ) }
    }

    --If you wish to translate the script yourself, go into delicate_ui_language.lua
    Delicate_UI.Server_Name = 'Delicate UI'
    Delicate_UI.F4.Header = 'Roleplay Options'
    Delicate_UI.F4.Footer = 'MY COMMUNITY NAME'

    --[[
        If you're using the no_blur_theme, you'll see blur unless you turn it off each element.
        For instance: Delicate_UI.HUD.Enable_Blur = false

        Want to re-skin the UI? delicate_ui_themes.lua.
        I am not going to help you if you break something inside of there. Edit it if you know what you're doing.
    --]]

    --------------------
    --> HUD Settings <--
    --------------------
    Delicate_UI.HUD.Enabled = true -- Is the HUD Enabled?
    Delicate_UI.HUD.Enable_Blur = true -- Enable Blur interfaces?
    Delicate_UI.HUD.Enable_Food_Bar = false -- [!!Only set to true if you use DarkRP Hunger Mod!!].
    Delicate_UI.HUD.Enable_Base_HUD = true -- Do you want to see the HUD at the bottom right? Use this if you don't want the HUD, just ammo counter or whatever.
    Delicate_UI.HUD.Enable_Overhead_Blur = true -- Do you want Overhead Blur?

    Delicate_UI.HUD.Enable_Laws = true -- Do you want people to be able to see the Laws (F2 to toggle if enabled)?
    Delicate_UI.HUD.Enable_Agenda = true -- Do you want people to be able to see the Agenda?
    Delicate_UI.HUD.Enable_Ammo = true -- Do you want people to be able to see their ammo count?
    Delicate_UI.HUD.Enable_Overhead = true -- Enable Delicate Overhead Display?
    Delicate_UI.HUD.ShowGunLicense = true -- Show a page overhead if the user has a Gun License?
    Delicate_UI.HUD.Theme = 'blur_theme' -- blur_theme or no_blur_theme

    -- DO NOT REMOVE ANY OF THESE VALUES, ONLY EDIT THEM.
    Delicate_UI.HUD.Pos_Manager = { -- Use this to change the y position of the Agenda and Law interface.
        [ 'law_pos_y' ] = -10,
        [ 'agenda_pos_y' ] = -10,
        [ 'arrested_pos_y' ] = -20,
        [ 'hud_increase_y' ] = 15,
        [ 'ammo_increase_y' ] = 15
    }
    -----------------------------------------------------

    ---------------------------
    --> Scoreboard Settings <--
    ---------------------------
    Delicate_UI.Scoreboard.Enabled = true -- Is the Scoreboard Enabled?
    Delicate_UI.Scoreboard.Enable_Blur = true -- Enable Blur?
    Delicate_UI.Scoreboard.Theme = 'blur_theme'

    Delicate_UI.Scoreboard.Enable_Spy_Mode = false -- Do you want specific ranks to not appear on the scoreboard? If so enable this.
    Delicate_UI.Scoreboard.Spy_Mode_Groups = { [ 'superadmin' ] = true } -- If Spy Mode is enabled, which ranks are invisible?

    Delicate_UI.Inherit_Job_Color = true -- Set the player row's color to that of their job?

    -- Buttons are drawn in order. If you wish to move them around, simply change the order in the table.
    -- If we want confirmation, you must pass 'title'. Pick one or both: time, reason. #name represents the player's name.
    Delicate_UI.Scoreboard.Buttons = {
        { buttonName = 'Copy SteamID', func = function( ply ) SetClipboardText( ply:SteamID() ) ply:ChatPrint( string.format( "You have copied %s's (%s) Steam ID.", ply:Nick(), ply:SteamID() ) ) end },
        { buttonName = 'Bring Player', cmd = 'ulx bring' },
        { buttonName = 'Freeze Player', cmd = 'ulx freeze' },
        { buttonName = 'Slay Player', cmd = 'ulx slay' },
        { buttonName = 'Kick Player',  cmd = 'ulx kick', title = 'Kick Player #name?', reason = true },
        { buttonName = 'Ban Player',  cmd = 'ulx ban', title = 'Ban Player #name?', reason = true, time = true },
        { buttonName = 'Jail Player',  cmd = 'ulx jail', title = 'Jail Player #name?', time = true },
        { buttonName = 'Open Profile', func = function( ply ) ply:ShowProfile() end }
    }

    Delicate_UI.F4.Enabled_Store_Components = { -- Here you can change which "categories" are shown in the Shop tab. Don't want a section? Set it to false.
        [ 'ammo_section' ] = true,
        [ 'entities_section' ] = true,
        [ 'shipments_section' ] = true,
        [ 'singles_section' ] = true,
        [ 'food_section' ] = true,
        [ 'vehicles_section' ] = true,
    }
    ------------------------
    --> F4 Menu Settings <--
    ------------------------

    Delicate_UI.F4.Enabled = true -- Is the F4 menu enabled?
    Delicate_UI.F4.Enable_Blur = true -- Enable Blur?
    Delicate_UI.F4.Theme = 'blur_theme'

    Delicate_UI.F4.Hide_Unusable_Content = false -- Hide anything that players do not have the permission to use? When someone will not pass a custom check.

    Delicate_UI.F4.EnabledButtons = { -- DO NOT CHANGE 'TAB' AT ALL
        { name = 'Jobs', tab_color = Color( 195, 118, 224, 50 ), tab = 'jobs_tab' },
        { name = 'Shop', tab_color = Color( 118, 224, 155, 50 ), tab = 'shop_tab' },
        { name = 'Website', tab_color = Color( 118, 224, 155, 50 ), tab = 'website_tab', link = 'https://www.gmodstore.com/users/view/76561198058539108' },
        { name = 'Updates', tab_color = Color( 224, 118, 118, 50 ), tab = 'updates_tab', link = 'https://www.gmodstore.com/users/view/76561198058539108' },
        { name = 'Donate', tab_color = Color( 224, 215, 118, 50 ), tab = 'donate_tab', link = 'https://www.gmodstore.com/users/view/76561198058539108' },
        { name = 'Steam Group', tab_color = Color( 224, 215, 118, 50 ), tab = 'steam_tab', link = 'https://www.gmodstore.com/users/view/76561198058539108' }
    }

    -- MAKE SURE THAT THIS IS SET TO AN ACTUAL TAB NAME --
    Delicate_UI.F4.DefaultTab = 'jobs_tab' -- The name of the tab you want to open by default.
    ------------------------------------------------------
