    if not CLIENT then return end

    function Delicate_UI.DrawRect( x, y, w, h, col )
        surface.SetDrawColor( col )
        surface.DrawRect( x, y, w, h )
    end

    function Delicate_UI.DrawText( msg, fnt, x, y, c, align )
        draw.SimpleText( msg, fnt, x, y, c, align and align or TEXT_ALIGN_CENTER )
    end

    function Delicate_UI.DrawOutline( x, y, w, h, t, c )
       surface.SetDrawColor( c )
       for i = 0, t - 1 do
           surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
       end
    end

    function Delicate_UI.PlaySequence( parent, id )
        local model_entity = parent:GetEntity()
        local sequence = model_entity:LookupSequence( id )
        model_entity:SetSequence( sequence )
    end

    function Delicate_UI.DrawRoundedBox( rad, x, y, w, h, col )
        draw.RoundedBox( rad, x, y, w, h, col )
    end

    function Delicate_UI.GenerateScreenBlur( parent, startTime ) Derma_DrawBackgroundBlur( parent, startTime ) end

    function Delicate_UI.CreateIconObject( self, icon, x, y, w, h, button )
        local image = vgui.Create( button and 'DImageButton' or 'DImage', self )
        image:SetSize( w, h )
        image:SetPos( x, y )
        image:SetMaterial( icon )
        --image:SetKeepAspect( true )
        if not button then return image end
        image.Paint = function( me ) me:SetColor( me:IsHovered() and Color( 230, 32, 25 ) or Color( 255, 255, 255 ) ) end
        image.DoClick = function() self:SetVisible( false ) end
    end

    function Delicate_UI.CreateButton( parent, x, y, w, h, font, txt )
        local btn = vgui.Create( 'DButton', parent )
        btn:SetSize( w, h )
        btn:SetFont( font )
        btn:SetText( txt )
        btn:SetPos( x, y )
        btn:SetTextColor( Color( 255, 255, 255 ) )
        btn.Paint = function( me, w, h )
            if me:IsHovered() then
                --me:SetTextColor( Color( 3, 169, 244 ) )
                Delicate_UI.DrawOutline( 0, 0, w, h, 2, Color( 255, 255, 255 ) )
            else
                me:SetTextColor( Color( 255, 255, 255 ) )
            end
            Delicate_UI.DrawRect( 0, 0, w, h, Color( 4, 4, 4, 200 ) )
        end
        return btn
    end

    function Delicate_UI.DrawIcon( mat, x, y, col, w, h )
        surface.SetDrawColor( col and col or Color( 255, 255, 255 ) )
        surface.SetMaterial( mat )
        surface.DrawTexturedRect( x, y, w and w or 32, h and h or 32 )
    end

    function Delicate_UI.PaintBar( parent, base_color, switch_color, bar_color )
        if not parent.VBar then print( 'No VBar found.' ) return end
        parent.VBar.Paint = function( me, w, h ) if not base_color then return else Delicate_UI.DrawRect( 0, 0, w, h, base_color ) end end
        parent.VBar.btnUp.Paint = function( me, w, h ) if not switch_color then return else Delicate_UI.DrawRect( 0, 0, w, h, switch_color ) end end
        parent.VBar.btnDown.Paint = function( me, w, h ) if not switch_color then return else Delicate_UI.DrawRect( 0, 0, w, h, switch_color ) end end -- 76561198058539108
        parent.VBar.btnGrip.Paint = function( me, w, h ) if not bar_color then return else Delicate_UI.DrawRect( 3, 0, w / 2, h, bar_color ) end end
    end

    local blur = Material( "pp/blurscreen" )
    function Delicate_UI.BlurMenu( panel, layers, density, alpha )
        -- Its a scientifically proven fact that blur improves a script
        local x, y = panel:LocalToScreen( 0, 0 )

        surface.SetDrawColor( 255, 255, 255, alpha )
        surface.SetMaterial( blur )

        for i = 1, 5 do
            blur:SetFloat( "$blur", ( i / 4 ) * 4 )
            blur:Recompute()

            render.UpdateScreenEffectTexture()
            surface.DrawTexturedRect( -x, -y, ScrW(), ScrH() )
        end
    end

    function Delicate_UI.BlurRect(x, y, w, h, alpha)
    	local X, Y = 0,0

    	surface.SetDrawColor(255,255,255)
    	surface.SetMaterial(blur)

    	for i = 1, 5 do
    		blur:SetFloat("$blur", (i / 4) * (4))
    		blur:Recompute()

    		render.UpdateScreenEffectTexture()

    		render.SetScissorRect( x, y, x+w, y+h, true )
    			surface.DrawTexturedRect( X * -1, Y * -1, ScrW(), ScrH() )
    		render.SetScissorRect( 0, 0, 0, 0, false )
    	end

       draw.RoundedBox(0,x,y,w,h,Color(0,0,0,alpha))
    end

    function Delicate_UI.WrapText( text, font, pxWidth ) -- Full credit to the creators of DarkRP for this.
        local total = 0

        surface.SetFont(font)

        local spaceSize = surface.GetTextSize(' ')
        text = text:gsub("(%s?[%S]+)", function(word)
                local char = string.sub(word, 1, 1)
                if char == "\n" or char == "\t" then
                    total = 0
                end

                local wordlen = surface.GetTextSize(word)
                total = total + wordlen

                -- Wrap around when the max width is reached
                if wordlen >= pxWidth then -- Split the word if the word is too big
                    local splitWord, splitPoint = charWrap(word, pxWidth - (total - wordlen))
                    total = splitPoint
                    return splitWord
                elseif total < pxWidth then
                    return word
                end

                -- Split before the word
                if char == ' ' then
                    total = wordlen - spaceSize
                    return '\n' .. string.sub(word, 2)
                end

                total = wordlen
                return '\n' .. word
            end)

        return text
    end
