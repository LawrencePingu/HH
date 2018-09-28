    if not CLIENT then return end

    Delicate_UI.Materials = {}
    Delicate_UI.Materials[ 'name_tag' ] = Material( 'delicate_name.png' )
    Delicate_UI.Materials[ 'name_tag_large' ] = Material( 'delicate_name_large.png' )
    Delicate_UI.Materials[ 'job_tag' ] = Material( 'delicate_job.png' )
    Delicate_UI.Materials[ 'job_tag_large' ] = Material( 'delicate_job_large.png' )
    Delicate_UI.Materials[ 'health_tag' ] = Material( 'delicate_health.png' )
    Delicate_UI.Materials[ 'health_tag_large' ] = Material( 'delicate_health_large.png' )
    Delicate_UI.Materials[ 'armor_tag' ] = Material( 'delicate_armor.png' )
    Delicate_UI.Materials[ 'hunger_tag' ] = Material( 'delicate_hunger.png' )
    Delicate_UI.Materials[ 'cash_tag' ] = Material( 'delicate_money.png' )
    Delicate_UI.Materials[ 'salary_tag' ] = Material( 'delicate_salary.png' )
    Delicate_UI.Materials[ 'gun_tag' ] = Material( 'delicate_gun.png' )
    Delicate_UI.Materials[ 'ammo_tag' ] = Material( 'delicate_ammo.png' )
    Delicate_UI.Materials[ 'lockdown_tag' ] = Material( 'delicate_lockdown.png' )
    Delicate_UI.Materials[ 'wanted_tag' ] = Material( 'delicate_wanted.png' )
    Delicate_UI.Materials[ 'agenda_tag' ] = Material( 'delicate_agenda.png' )
    Delicate_UI.Materials[ 'law_tag' ] = Material( 'delicate_laws.png' )
    Delicate_UI.Materials[ 'punish_tag' ] = Material( 'delicate_punish.png' )
    Delicate_UI.Materials[ 'ping_tag' ] = Material( 'delicate_ping.png' )
    Delicate_UI.Materials[ 'gun_license' ] = Material( 'gun_license.png' )

    function Delicate_UI.ManageFonts( min, max, font ) -- No idea why I didn't do this sooner.
        for x = min, max do surface.CreateFont( 'Delicate.Font.' .. x, {
            font = font, size = x, weight = 700
        } ) end
    end

    Delicate_UI.ManageFonts( 12, 70, 'Roboto Bold' )
