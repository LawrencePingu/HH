    if not CLIENT then return end

    --[[
        I do not suggest that you change anything in this file, unless you know what you're doing.
        I will not help you if you break something in here.

        This file is purely for those who do want to reskin the UI (to some extent) and know exactly what they're doing.
    --]]

    Delicate_UI.HUD.Themes = {
        [ 'no_blur_theme' ] = {
            top_bar = Color( 22, 22, 22, 210 ),
            middle_line = Color( 255, 255, 255 ),
            bottom_bar = Color( 42, 42, 42, 120 ),
            job_bar = Color( 87, 112, 112, 30 ),
            health_bar = Color( 224, 118, 118, 30 ),
            armor_bar = Color( 118, 135, 224, 30 ),
            hunger_bar = Color( 224, 220, 118, 30 ),
            cash_bar = Color( 145, 224, 118, 30 ),
            salary_bar = Color( 118, 224, 188, 30 ),
            ammo_bar = Color( 108, 108, 108, 140 )
        },
        [ 'blur_theme' ] = {
            top_bar = Color( 0, 0, 0, 170 ),
            middle_line = Color( 255, 255, 255, 220 ),
            bottom_bar = Color( 22, 22, 22, 120 ),
            job_bar = Color( 87, 112, 112, 23 ),
            health_bar = Color( 224, 118, 118, 23 ),
            armor_bar = Color( 118, 135, 224, 23 ),
            hunger_bar = Color( 224, 220, 118, 23 ),
            cash_bar = Color( 145, 224, 118, 23 ),
            salary_bar = Color( 118, 224, 188, 23 ),
            ammo_bar = Color( 108, 108, 108, 140 )
        }
    }

    Delicate_UI.Scoreboard.Themes = {
        [ 'no_blur_theme' ] = {
            background = Color( 22, 22, 22, 210 ),
            line_seperator = Color( 255, 255, 255, 220 ),
            player_count_section = Color( 12, 12, 12, 120 ),
            title_color = Color( 255, 255, 255 ),
            player_name = Color( 255, 255, 255 ),
            player_job = Color( 255, 255, 255 ),
            player_kd = Color( 255, 255, 255 ),
            player_ping = Color( 255, 255, 255 ),
            -- This is for the 'reason' section
            interface_headers = Color( 255, 255, 255 ),
            interface_seperator = Color( 0, 0, 0, 170 ),
            confirm_button = Color( 145, 224, 118, 30 )
        },
        [ 'blur_theme' ] = {
            background = Color( 0, 0, 0, 220 ),
            line_seperator = Color( 255, 255, 255, 220 ),
            player_count_section = Color( 12, 12, 12, 120 ),
            title_color = Color( 255, 255, 255 ),
            player_name = Color( 255, 255, 255 ),
            player_job = Color( 255, 255, 255 ),
            player_kd = Color( 255, 255, 255 ),
            player_ping = Color( 255, 255, 255 ),
            -- This is for the 'reason' section
            interface_headers = Color( 255, 255, 255 ),
            interface_seperator = Color( 0, 0, 0, 170 ),
            confirm_button = Color( 145, 224, 118, 30 )
        }
    }

    Delicate_UI.F4.Themes = {
        [ 'no_blur_theme' ] = {
            background = Color( 22, 22, 22, 230 ),
            line_seperator = Color( 255, 255, 255, 220 ),
            title_color = Color( 255, 255, 255 ),
            general_info = Color( 255, 255, 255 ),
            shop_element = Color( 118, 224, 155, 50 ),
            max_job_limit = Color( 118, 224, 155, 50 ),
            shop_outter = Color( 138, 224, 155, 50 ),
            shop_inner = Color( 118, 224, 155, 50 ),
            job_outter = Color( 100, 72, 120, 70 ),
            job_inner = Color( 70, 72, 120, 50 )
        },
        [ 'blur_theme' ] = {
            background = Color( 0, 0, 0, 225 ),
            line_seperator = Color( 255, 255, 255, 220 ),
            title_color = Color( 255, 255, 255 ),
            general_info = Color( 255, 255, 255 ),
            shop_element = Color( 118, 224, 155, 50 ),
            max_job_limit = Color( 118, 224, 155, 50 ),
            shop_outter = Color( 138, 224, 155, 50 ),
            shop_inner = Color( 118, 224, 155, 50 ),
            job_outter = Color( 100, 72, 120, 70 ),
            job_inner = Color( 70, 72, 120, 50 )
        }
    }
