script_name("MiniCrHelper")
script_version("0.0.6")


--������ ����������--
require 'lib.moonloader'
local imgui = require 'mimgui' -- ���������� ���������� ������
local encoding = require 'encoding' -- ���������� ���������� ��� ������ � ������� �����������
encoding.default = 'CP1251' -- ����� ��������� �� ���������
local u8 = encoding.UTF8 -- ��� �������� ��� ������ �������� ��������/����� �� ���������
local new = imgui.new -- ������ �������� ��������� ��� ��������
local WinState = new.bool() -- ������ ������ ��� �������� ����
require 'lib.moonloader'
local imgui = require 'mimgui'
local ffi = require 'ffi'
local encoding = require 'encoding'
encoding.default = 'CP1251'
local u8 = encoding.UTF8
local new, str = imgui.new, ffi.string
local renderWindow = new.bool()
local sampev = require 'samp.events'
local f = require 'moonloader'.font_flag
local font = renderCreateFont('Arial', 15, f.BOLD + f.SHADOW)
local clean = false
local counter = 0
local ev = require 'samp.events'
local lavki = {}
local marketShop = {}
local keys = require "vkeys"
local ffi = require 'ffi'
local new, str = imgui.new, ffi.string
local effil = require("effil")
local encoding = require("encoding")
encoding.default = 'CP1251'
u8 = encoding.UTF8

--������ ����������--

--������ CFG--
local inicfg = require 'inicfg'
local mainIni = inicfg.load({
	main =
    {
	    autoeat = false,
		autoeatmin = 0, -- �������� ������
		ComboTest = 0,
        autoclean = false,
		chat_id = '',
		token = '',
		diolog = false,
		cmd = false,
		info = false,
		standart = false,
        platina = false,
        mask = false,
        donate = false,
		tainik = false,
		vice = false,
        clean = false,
        settingslavka = false,
        namelavkas = '',
        moneyvcs = true,
    }}, 'MiniHelper-CR.ini')
--������ CFG--




--������ 1 ��������--
local SliderOne = new.int(mainIni.main.autoeatmin)
local ComboTest = new.int((mainIni.main.ComboTest)) -- ������ ������ ��� �����
local lavka = new.bool() -- ����� ������ ��� ��������, ������� ���������� true/false
local radiuslavki = new.bool() -- ����� ������ ��� ��������, ������� ���������� true/false
local settingslavka = new.bool(mainIni.main.settingslavka) -- ����� ������ ��� ��������, ������� ���������� true/false
local namelavkas = new.char[256](u8(mainIni.main.namelavkas))
local clean = new.bool(mainIni.main.clean) -- ����� ������ ��� ��������, ������� ���������� true/false
local autoclean = new.bool(mainIni.main.autoclean) -- ����� ����� ��� ��������, ������� ���������� true/false
local autoeat = new.bool(mainIni.main.autoeat) -- ����� ������ ��� ��������, ������� ���������� true/false
local item_list = {u8'�������', u8'����� � �����'} -- ������ ������
local ImItems = imgui.new['const char*'][#item_list](item_list)
local pcoff = new.bool() -- ����� ������ ��� ��������, ������� ���������� true/false
local SliderTwo = new.int(0)
local SliderFri = new.int(0)
--������ 1 ��������--





---Chests---
local checkbox_standart = new.bool(mainIni.main.standart) -- ������ �������
local checkbox_donate = new.bool(mainIni.main.donate) -- ������ ���������� �������
local checkbox_tainik = new.bool(mainIni.main.tainik) -- ������ ������� (�����)
local checkbox_mask = new.bool(mainIni.main.mask) -- ������ ����� �����
local checkbox_platina = new.bool(mainIni.main.platina) -- ������ ��� �������
local checkbox_vice = new.bool(mainIni.main.vice) -- ������ Vice City
local textdraw = {
    [1] = {_, _, 1000},
    [2] = {_, _, 1000},
    [3] = {_, _, 1000},
    [4] = {_, _, 1000},
	[5] = {_, _, 1000},
	[6] = {_, _, 1000},
} 
local Chest = new.bool()
local sw, sh = getScreenResolution() 
local active_standart, active_mask, active_platina, active_donate, active_tainik, vice = false, false, false, false, false, false
local work = false
local workbotton = new.bool()
local timertrue = false
---Chests---

local WinState = imgui.new.bool()
local tab = 1 -- � ���� ���������� ����� �������� ����� �������� �������

local timechestto = new.char[256]() -- ������ ����� ��� ������
local delayedtimer = new.bool() -- ���� space
---Auto---
local autokey1 = new.bool() -- ���� space
local timekey1 = new.int(5) -- ������ ����� ��� SliderInt �� ��������� 2 �� ���������
local buttonkey1 = new.char[256]() -- ������ ����� ��� ������

local autokey2 = new.bool() -- ���� space
local timekey2 = new.int(5) -- ������ ����� ��� SliderInt �� ��������� 2 �� ���������
local buttonkey2 = new.char[256]() -- ������ ����� ��� ������
local timekey3 = new.int(5) -- ������ ����� ��� SliderInt �� ��������� 2 �� ���������
local buttonkey3 = new.char[256]() -- ������ ����� ��� ������
---Auto---

---4---
local moneyvcs = new.bool(mainIni.main.moneyvcs) -- ���� space
---4---

---Telegram---
local cmd = new.bool(mainIni.main.cmd)
local diolog = new.bool(mainIni.main.diolog) -- ����� ������ ��� ��������, ������� ���������� true/false
local chat_id = new.char[256](u8(mainIni.main.chat_id)) -- ������ ������ ��� ������
local token = new.char[256](u8(mainIni.main.token)) -- ������ ������ ��� ������
---Telegram---

--color--
        local show = imgui.new.bool(true)
        local changepos = false -- ������ �������������� ������� ������
        local posX, posY = 500, 500 -- ����� ��������� ������� ������� ������

--color--

imgui.OnFrame(function() return WinState[0] end, function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(500, 500), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(370, 320), imgui.Cond.Always)
    imgui.Begin(u8'������ Helper v'..thisScript().version, WinState, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
    for numberTab,nameTab in pairs({'Main','Chests','Auto','�� ��������','Telegram'}) do -- ������ � ������ ������� � ���������� ������� �������
        if imgui.Button(u8(nameTab), imgui.ImVec2(80,43)) then -- 2�� ���������� ������������� ������ ������ (��������� � ����� �� ������)
            tab = numberTab -- ������ �������� ���������� tab �� ����� ������� ������
        end
    end
    imgui.SetCursorPos(imgui.ImVec2(95, 28)) -- [��� ������] ������������� ������� ��� ������ ����
    if imgui.BeginChild('Name##'..tab, imgui.ImVec2(265, 280), true) then -- [��� ������] ������ ����� � ������� �������� ����������
        
        --- 1 �������� ����� ---
		if tab == 1 then
     
        if imgui.Checkbox(u8'������ �����', lavka) then
        end
		imgui.SameLine()
        imgui.TextQuestion(u8("Right Shift + 1"))
        imgui.Checkbox(u8'������ ����� �������', radiuslavki)
        imgui.SameLine()
        imgui.TextQuestion(u8("Right Shift + 2"))
		imgui.Checkbox(u8'�������� ������� � ��', clean)
        imgui.SameLine()
        imgui.TextQuestion(u8("Right Shift + 3"))
        if imgui.Checkbox(u8'����-��������', autoclean) then
            mainIni.main.autoclean = autoclean[0] 
		    inicfg.save(mainIni, "MiniHelper-CR")
        end
        if imgui.Checkbox(u8'����-�����', settingslavka) then
            
            mainIni.main.settingslavka = settingslavka[0] 
		    inicfg.save(mainIni, "MiniHelper-CR")
        end
        if imgui.InputText(u8"name-lavka", namelavkas, 256) then 
            mainIni.main.namelavkas = u8:decode(str(namelavkas))
            inicfg.save(mainIni, "MiniHelper-CR")
            end

		imgui.Separator()	
		if imgui.Checkbox(u8'����-���', autoeat) then
		mainIni.main.autoeat = autoeat[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
		imgui.SameLine()
        imgui.TextQuestion(u8("������ ����� ��� �����"))
		imgui.PushItemWidth(190)
		if imgui.SliderInt(u8'������.', SliderOne, 1, 60) then -- 3 ���������� �������� ����������� ��������, � 4 �������� ����� ������������ ��������
		mainIni.main.autoeatmin = SliderOne[0]
		inicfg.save(mainIni, "MiniHelper-CR")
		end
		imgui.PopItemWidth()
		if imgui.Combo(u8'##',ComboTest,ImItems, #item_list) then
		 mainIni.main.ComboTest = ComboTest[0]
		 inicfg.save(mainIni, "MiniHelper-CR")
		end

  
		--- 1 �������� ����� ---	
		
		
		


        --- 2 �������� ����� ---
		elseif tab == 2 then
		if imgui.Checkbox(u8'������ �������', checkbox_standart) then
		mainIni.main.standart = checkbox_standart[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
        end
		if imgui.Checkbox(u8'������ ���������� �������', checkbox_platina) then
	    mainIni.main.platina = checkbox_platina[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
		if imgui.Checkbox(u8'������ ������� (�����)', checkbox_donate) then
		mainIni.main.donate = checkbox_donate[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
		if imgui.Checkbox(u8'������ ����� �����', checkbox_mask) then
        mainIni.main.mask = checkbox_mask[0] 
	    inicfg.save(mainIni, "MiniHelper-CR")
        end	
		if imgui.Checkbox(u8'������ ��� �������', checkbox_tainik) then
	    mainIni.main.tainik = checkbox_tainik[0] 
	    inicfg.save(mainIni, "MiniHelper-CR")
	    end 	
		if imgui.Checkbox(u8'������ Vice City', checkbox_vice) then
	    mainIni.main.vice = checkbox_vice[0] 
	    inicfg.save(mainIni, "MiniHelper-CR")
        end 
        
        if imgui.Checkbox(u8'��������� ����-��������###777', workbotton) then
            work = true
       
        end
        imgui.SameLine()
        imgui.TextQuestion(u8("Right Shift + 4"))
        imgui.Separator()
        imgui.Text(u8'��������� �����:')
        imgui.SameLine()
        imgui.PushItemWidth(30)
        imgui.InputText(u8"���##15689", timechestto, 256, imgui.InputTextFlags.CharsDecimal)
        imgui.SameLine()
       
        imgui.Text('                  '..counter)
   
        imgui.PopItemWidth()
        if imgui.Checkbox(u8'���������� ������', delayedtimer) then
        end
        
        --- 2 �������� ����� ---
		
	
	    --- 3 �������� ����� ---
		elseif tab == 3 then
        imgui.Checkbox(u8'���� ������� 1 ������', autokey1)
		imgui.SliderInt(u8'������ � ��', timekey1, 5, 100) -- 3 ���������� �������� ����������� ��������, � 4 �������� ����� ������������ ��������
        imgui.InputTextWithHint(u8'HEX ���', u8'������� HEX ��� �������', buttonkey1, 256)
		imgui.Separator()
		 imgui.Checkbox(u8'���� ������� 2 ������###auto1', autokey2)
		imgui.SliderInt(u8'������ � ��###auto2', timekey2, 5, 100) -- 3 ���������� �������� ����������� ��������, � 4 �������� ����� ������������ ��������
        imgui.InputTextWithHint(u8'HEX ���###auto3', u8'������� HEX ��� �������', buttonkey2, 256)
		imgui.SliderInt(u8'������ � ��###auto4', timekey3, 5, 100) -- 3 ���������� �������� ����������� ��������, � 4 �������� ����� ������������ ��������
        imgui.InputTextWithHint(u8'HEX ���###auto5', u8'������� HEX ��� �������', buttonkey3, 256)
		imgui.Separator()
		if imgui.Button(u8'������ ����� ������', imgui.ImVec2(210, 25) ) then -- ������ ������ ��������� ��� ���������
       os.execute("start https://narvell.nl/keys")
	   end
        --- 3 �������� ����� ---
		
		
		--- 4 �������� ����� ---
        elseif tab == 4 then 
            
            if imgui.Button('open window') then -- ����� �� ��� ������, ����� �������� ������� ����
                show[0] = not show[0]
            end
        if imgui.Checkbox(u8'������� ����� VC � $', moneyvcs) then
        mainIni.main.moneyvcs = moneyvcs[0] 
        inicfg.save(mainIni, "MiniHelper-CR")
        end
        --- 4 �������� ����� ---
		
        if imgui.Button(u8'������') then
            name = sampGetCurrentServerName()
            sampAddChatMessage(""..name, -1)
        end

        if imgui.Button(u8('�������� �������'), imgui.ImVec2(170)) then
            marketShop = {}
            for i = 1, 5 do marketShop[i] = '�� ������ �������� ����� (1 ��.) � ������ Test �� $123.123.123.123' end
            

        end

        if imgui.Button(u8('�������� �������'), imgui.ImVec2(170)) then
        marketShop = {}
        end

        



	    --- 5 �������� ����� ---
	    elseif tab == 5 then
        if imgui.Checkbox(u8'��������� ������� �� TG', cmd) then
		mainIni.main.cmd = cmd[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
        if imgui.Checkbox(u8'���������� ������� � TG', diolog) then
		mainIni.main.diolog = diolog[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
	    end	
        if imgui.InputText(u8"TG ID", chat_id, 256) then 
	    mainIni.main.chat_id = u8:decode(str(chat_id))
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
	    if imgui.InputText(u8"TG TOKEN", token, 256) then
	    mainIni.main.token = u8:decode(str(token))
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
		if imgui.Button(u8'�������� ���������') then
        sendTelegramNotification('�������� ��������� �� '..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))) -- ���������� ��������� �����
	    end
        imgui.Text(u8'/help -- ������ ������.')
		end
        --- 5 �������� ����� ---

        
        imgui.EndChild()
		imgui.SetCursorPos(imgui.ImVec2(5, 270))
		if imgui.Button(('Reload'), imgui.ImVec2(80,44)) then
        sampAddChatMessage('������ ���������������', 0xFF0000)
	    thisScript():reload()
        end
        end
        imgui.End()
        end)

        
         
        imgui.OnFrame(function() return show[0] and not isGamePaused() end, function()
   
            local sizeX, sizeY = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        
        imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0, 0, 0, 0.5))
        imgui.Begin('market', market, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize)
     
        for i = #marketShop, 1, -1 do
            --imgui.Text(u8(marketShop[i]))
            imgui.PushFont(example)
            imgui.TextColoredRGB('{FFFF00}'..marketShop[i])
            imgui.PopFont() -- �������, ���������� ����� �������������
        end
        imgui.End()
        imgui.PopStyleColor()
        end).HideCursor = true -- HideCursor �������� �� ��, ����� ������ �� �����������


        
---����� ��� ����� � ���� �����������---

-- https://github.com/ass138/cr-helper-arz/tree/main
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('��������� %d �� %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('�������� ���������� ���������.')sampAddChatMessage(b..'���������� ���������!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'���������� ������ ��������. �������� ���������� ������..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': ���������� �� ���������.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, ������� �� �������� �������� ����������. ��������� ��� ��������� �������������� �� '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/ass138/cr-helper-arz/main/version.json?" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://github.com/ass138/cr-helper-arz/tree/main"
        end
    end
end
---����� ��� ����� � ���� �����������---

function main()
    while not isSampAvailable() do wait(100) end -- ��� ����� ���������� ����
	wait(500)
	sampAddChatMessage('� {00FF00}[������-Helper]{FFFFFF} ���������: {7FFF00}F2{FFFFFF} �', -1)
	getLastUpdate() -- �������� ������� ��������� ���������� ID ���������
    	          if autoupdate_loaded and enable_autoupdate and Update then
        pcall(Update.check, Update.json_url, Update.prefix, Update.url)
    end
		    lua_thread.create(get_telegram_updates) -- ������� ���� ������� ��������� ��������� �� �����	
			lua_thread.create(lavkirendor)
            lua_thread.create(radiuslavkis)
			lua_thread.create(cleanr)
			lua_thread.create(eat)
			lua_thread.create(autokeys)
			lua_thread.create(crtextdraw)
            lua_thread.create(chestss)
            lua_thread.create(delayedtimers)
            lua_thread.create(bind)
            lua_thread.create(sizewindow)
            lua_thread.create(lavkatextand)
     
           
        

         

		

			

			
	while true do wait(0)
	  if wasKeyPressed(VK_F2) and not sampIsCursorActive() then -- ���� ������ ������� R � �� ������� ���� ������
            WinState[0] = not WinState[0]  
            imgui.Process = main_window_state
            imgui.ShowCursor = false
            posX, posY = getCursorPos() -- ������� ��������� �������� ���������� ������� �� ������
            
                
            
end
end
end












local fontas = renderCreateFont("Arial", 10, 5)


function lavkatextand()
    while true do
        wait(0)
        for id = 0, 2048 do
            local result = sampIs3dTextDefined(id)
            if result then
                local text, color, posX, posY, posZ, distance, ignoreWalls, playerId, vehicleId = sampGet3dTextInfoById(id)
                if text:find("Papa_Prince") or text:find("Kevin_Halt") then
                    local playerX, playerY, playerZ = getCharCoordinates(PLAYER_PED)
                    local dist = getDistanceBetweenCoords3d(playerX, playerY, playerZ, posX, posY, posZ)
                    if dist <= 100.0 then
                        local wposX, wposY = convert3DCoordsToScreen(posX, posY, posZ)
                        local resX, resY = getScreenResolution()
                        if wposX < resX and wposY < resY and isPointOnScreen(posX, posY, posZ, 1) then
                            renderFontDrawText(fontas, text, wposX, wposY, 0xFF00FF00)
                        end
                    end
                end
            end
        end
    end
end

































function sizewindow()
    while true do wait(0)
        if changepos then -- �������������� ������� ������, ��� ����� �������� � � ��� ������
            posX, posY = getCursorPos() -- ������� ��������� �������� ���������� ������� �� ������
            if isKeyJustPressed(1) then -- ���� ������ ���, �� ��������� �������
                changepos = false
            end
        end
    end
end




function imgui.ColoredButton(text,hex,trans,size)
    local r,g,b = tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
    if tonumber(trans) ~= nil and tonumber(trans) < 101 and tonumber(trans) > 0 then a = trans else a = 60 end
    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(r/255, g/255, b/255, a/100))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(r/255, g/255, b/255, a/100))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(r/255, g/255, b/255, a/100))
    local button = imgui.Button(text, size)
    imgui.PopStyleColor(3)
    return button
end

function delayedtimers()
    while true do 
        wait(0)
        if delayedtimer[0] then	
            startTimes = os.time() + u8:decode(str(timechestto)) * 60 -- ������������� ������ �� 5 �����
            while os.time() < startTimes do
                wait(0)
                local timeRemainings = startTimes - os.time()
                local minutess = math.floor(timeRemainings / 60)
                local secondss = timeRemainings % 60
               
                local timeStrings = string.format("%02d:%02d", minutess, secondss)
                renderFontDrawText(font,'Timer '..timeStrings, 95, 510 + 80, 0xFF00FF00, 0x90000000)
            end
            -- �������� �� ���������� �������
            
            -- ����� ����� ���� ������ �������� � ����������� �� ����� ������
            workbotton = new.bool(true)
            work = true
            delayedtimer = new.bool(false)
            break -- ����� �� ����� ����� ���������� �������
        end
    end
end


function onReceivePacket(id)
    if id == 32 then
        sendTelegramNotification('C����� ������ ����������')
    end
    if id == 33 then
        sendTelegramNotification('C����� ������ ����������')
    end
end



-- ������� ���������� ��� �������� ���������� �� �����������
local circleCoordinates = {}

-- ������� ��� ���������� ���������� � ����� ����������
function addCircleInfo(x, y, radius)
    table.insert(circleCoordinates, {x, y, radius})
end




function radiuslavkis()
	while true do
		wait(0)
		if radiuslavki[0] then
			local myPos = {getCharCoordinates(1)}
	        for IDTEXT = 0, 2048 do
	            if sampIs3dTextDefined(IDTEXT) then
	                local text, color, posX, posY, posZ, distance, ignoreWalls, player, vehicle = sampGet3dTextInfoById(IDTEXT)
	                if text == "���������� ��������." and not isCentralMarket(posX, posY) then
	                    local distanceToText = getDistanceBetweenCoords3d(posX, posY, posZ, myPos[1], myPos[2], myPos[3])
	                    if distanceToText <= 20.0 then
	                        drawCircleIn3d(posX,posY,posZ-1.3,5,36,1.5,	getDistanceBetweenCoords3d(posX,posY,0,myPos[1],myPos[2],0) > 5 and 0xFFFFFFFF or 0xFFFF0000)
	                    end
	                end
	            end
	        end
	    end
	end
end


drawCircleIn3d = function(x, y, z, radius, polygons,width,color)
    local step = math.floor(360 / (polygons or 36))
    local sX_old, sY_old
    for angle = 0, 360, step do
        local lX = radius * math.cos(math.rad(angle)) + x
        local lY = radius * math.sin(math.rad(angle)) + y
        local lZ = z
        local _, sX, sY, sZ, _, _ = convert3DCoordsToScreenEx(lX, lY, lZ)
        if sZ > 1 then
            if sX_old and sY_old then
                renderDrawLine(sX, sY, sX_old, sY_old, width, color)
            end
            sX_old, sY_old = sX, sY
        end
    end
end

isCentralMarket = function(x, y)
	return (x > 1044 and x < 1197 and y > -1565 and y < -1403)
end









local TextDraw_Remove = {{4, 203, 347}, {4, 204, 349}, {2, 208, 351}}

function crtextdraw()
    while true do wait(0)
		for i = 1, 4096 do
			if sampTextdrawIsExists(i) then
				local style = sampTextdrawGetStyle(i)
				local x, y = sampTextdrawGetPos(i)
				local text = sampTextdrawGetString(i)
				for i_table = 1, #TextDraw_Remove do
					if (style == TextDraw_Remove[i_table][1] and math.floor(x) == TextDraw_Remove[i_table][2] and math.floor(y) == TextDraw_Remove[i_table][3]) then	
						sampTextdrawDelete(i)
					end
                end
            end
        end
    end
end

function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4
    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end
    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImVec4(r/255, g/255, b/255, a/255)
    end
    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(u8(w)) end
        end
    end
    render_text(text)
end


function imgui.TextQuestion(text)
    imgui.TextDisabled("(?)")
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(450)
        imgui.TextUnformatted(text)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end



function autokeys()
while true do wait(0)
if autokey1[0] then	
setVirtualKeyDown(u8:decode(str(buttonkey1)), true)
wait(timekey1[0]*1)
setVirtualKeyDown(u8:decode(str(buttonkey1)), false)
end
if autokey2[0] then	
setVirtualKeyDown(u8:decode(str(buttonkey2)), true)
wait(timekey2[0]*1)
setVirtualKeyDown(u8:decode(str(buttonkey2)), false)
setVirtualKeyDown(u8:decode(str(buttonkey3)), true)
wait(timekey3[0]*1)
setVirtualKeyDown(u8:decode(str(buttonkey3)), false)

end
end
end


function chestss()
    while true do
        wait(0)

        if work then
            sampCloseCurrentDialogWithButton(0)
            wait(200)
            sampCloseCurrentDialogWithButton(0)
            sampAddChatMessage('[����������] {FFFFFF}������ ��������� ���������.', 0xFFFF00)
            wait(1000)
            sampSendChat('/invent')
            wait(1000)
            for i = 1, 6 do
                if not work then break end
                sampSendClickTextdraw(textdraw[i][1])
                wait(textdraw[i][3])
                sampSendClickTextdraw(textdraw[i][2])
                wait(textdraw[i][3])
            end
            wait(100)
            sampAddChatMessage('[����������] {FFFFFF}������� ������ �� 1�.', 0xFFFF00)
            startTime = os.time() + 60 * 60 -- ������������� ������
            work = false
   
            startTime = os.time() + 60 * 60 -- ������������� ������ �� 5 �����
            while os.time() < startTime do
                wait(0)
                local timeRemaining = startTime - os.time()
                local minutes = math.floor(timeRemaining / 60)
                local seconds = timeRemaining % 60
               
                local timeString = string.format("%02d:%02d", minutes, seconds)
                renderFontDrawText(font,'Timer '..timeString, 95, 510 + 80, 0xFFFF1493, 0x90000000)
                
            end
            work = true -- ������������� ���� work � true ����� ���������� �������
        end
    end
end


   
   function ev.onShowTextDraw(id, data)

       if work then
           if checkbox_standart[0] and data.modelId == 19918 then textdraw[1][1] = id  end
           if checkbox_platina[0] and data.modelId == 1353 then textdraw[2][1] = id  end
           if checkbox_mask[0] and data.modelId == 1733 then textdraw[3][1] = id  end
           if checkbox_donate[0] and data.modelId == 19613 then textdraw[4][1] = id  end
           if checkbox_tainik[0] and data.modelId == 2887 then textdraw[5][1] = id  end
           if checkbox_vice[0] and data.modelId == 1333 then textdraw[6][1] = id  end
           if data.text == 'USE' or data.text == '�C�O���O�A��' then 
               textdraw[1][2] = id + 1
               textdraw[2][2] = id + 1
               textdraw[3][2] = id + 1
               textdraw[4][2] = id + 1
               textdraw[5][2] = id + 1
               textdraw[6][2] = id + 1
           end
       end
    end 







function bind()
    while true do wait(0)

    if isKeyDown(161) and isKeyDown(49) then 
        activediaq = not activediaq
        if activediaq then 
        sampAddChatMessage('{C71585}[Binder] {FFFFFF}������ ����� {00FF00}��������.', -1)
        lavka[0] = true
        wait(200) 
        else
        sampAddChatMessage('{C71585}[Binder] {FFFFFF}������ ����� {FF0000}���������.', -1)   
        lavka[0] = false
        wait(200) 
    end
end
    if isKeyDown(161) and isKeyDown(50) then 
        activediaw = not activediaw
        if activediaw then  
        sampAddChatMessage('{C71585}[Binder] {FFFFFF}������ ����� ������� {00FF00}��������.', -1)
        radiuslavki[0] = true
        wait(200)
        else 
        sampAddChatMessage('{C71585}[Binder] {FFFFFF}������ ����� ������� {FF0000}���������.', -1)   
        radiuslavki[0] = false
        wait(200)
    end
end

    if isKeyDown(161) and isKeyDown(51) then
        activediae = not activediae
        if activediae then
        sampAddChatMessage('{C71585}[Binder] {FFFFFF}�������� ������� � �� {00FF00}��������.', -1)
        clean[0] = true 
        wait(200)
        else 
        sampAddChatMessage('{C71585}[Binder] {FFFFFF}�������� ������� � �� {FF0000}���������.', -1)   
        clean[0] = false 
        wait(200)
    end
end
    if isKeyDown(161) and isKeyDown(52) then  
        workbotton[0] = true 
        work = true 
    end
    if isKeyDown(161) and isKeyDown(54) then  
        thisScript():reload() 
    end
end
end

    


   function lavkirendor()
    while true do wait(0)
            if lavka[0] then		
    local input = sampGetInputInfoPtr()
                local input = getStructElement(input, 0x8, 4)
                local PosX = getStructElement(input, 0x8, 4)
                local PosY = getStructElement(input, 0xC, 4)
                local lavki = 0
                
                for id = 0, 2304 do
                    if sampIs3dTextDefined(id) then
                        local text, _, posX, posY, posZ, _, _, _, _ = sampGet3dTextInfoById(id)
                        if (math.floor(posZ) == 17 or math.floor(posZ) == 1820) and text == '' then
                            lavki = lavki + 1
                            if isPointOnScreen(posX, posY, posZ, nil) then
                                local pX, pY = convert3DCoordsToScreen(getCharCoordinates(PLAYER_PED))
                                local lX, lY = convert3DCoordsToScreen(posX, posY, posZ)
                                renderFontDrawText(font, '��������', lX - 30, lY - 20, 0xFF16C910, 0x90000000)
                                renderDrawLine(pX, pY, lX, lY, 1, 0xFF52FF4D)
                                renderDrawPolygon(pX, pY, 10, 10, 10, 0, 0xFFFFFFFF)
                                renderDrawPolygon(lX, lY, 10, 10, 10, 0, 0xFFFFFFFF)  
                            end
                        end
                    end
                end
                local input = sampGetInputInfoPtr()
                local input = getStructElement(input, 0x8, 4)
                local PosX = getStructElement(input, 0x8, 4)
                local PosY = getStructElement(input, 0xC, 4)
                renderFontDrawText(font, '��������: '..lavki, 95, 510 + 80, 0xFFFF1493, 0x90000000)
        end
        end
    end       
  
    


function senddell()
    activedia = not activedia
    if activedia then 
    clean[0] = true
        
    sendTelegramNotification('�������� ������� � �� ��������.')
    else
    clean[0] = false
        
    sendTelegramNotification('�������� ������� � �� ���������.')
    end
end


function cleanr()
    while true do wait(0)
     if clean[0] then
    local removedPlayers = 0
            for i, v in ipairs(getAllChars()) do
                if doesCharExist(v) and i ~= 1 then
                    local _, id = sampGetPlayerIdByCharHandle(v)
                    if id ~= -1 then
                        removePlayer(id)
                        removedPlayers = removedPlayers + 1
                    end
                end
            end
            local removedVehicles = 0
            for i, v in ipairs(getAllVehicles()) do
                local res, id = sampGetVehicleIdByCarHandle(v)
                if res then
                    if (isCharInAnyCar(1) and storeCarCharIsInNoSave(1) ~= v) or not isCharInAnyCar(1) then
                        removeVehicle(id)
                        removedVehicles = removedVehicles + 1
                    end
                end
            end
            local result, ped = sampGetCharHandleBySampPlayerId(id)
            deleteChar(ped)
        end
    end 
    end
    
    function removePlayer(id)
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt16(bs, id)
        raknetEmulRpcReceiveBitStream(163, bs)
        raknetDeleteBitStream(bs)
    end
    
    function removeVehicle(id)
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt16(bs, id)
        raknetEmulRpcReceiveBitStream(165, bs)
        raknetDeleteBitStream(bs)
    end




function eat()
 while true do wait(0)
if autoeat[0] then
      if ComboTest[0] == 0 then
        sampSendChat('/jmeat')
      elseif ComboTest[0] == 1 then
        sampSendChat('/meatbag')
      end
	  wait(SliderOne[0]*60000)
    end
  end
  end



------------------------------------------------------------------------------------------------------------------------------------------------------------

local updateid -- ID ���������� ��������� ��� ���� ����� �� ���� �����

function threadHandle(runner, url, args, resolve, reject)
	local t = runner(url, args)
	local r = t:get(0)
	while not r do
		r = t:get(0)
		wait(0)
	end
	local status = t:status()
	if status == 'completed' then
		local ok, result = r[1], r[2]
		if ok then resolve(result) else reject(result) end
	elseif err then
		reject(err)
	elseif status == 'canceled' then
		reject(status)
	end
	t:cancel(0)
end



function requestRunner()
	return effil.thread(function(u, a)
		local https = require 'ssl.https'
		local ok, result = pcall(https.request, u, a)
		if ok then
			return {true, result}
		else
			return {false, result}
		end
	end)
end

function async_http_request(url, args, resolve, reject)
	local runner = requestRunner()
	if not reject then reject = function() end end
	lua_thread.create(function()
		threadHandle(runner, url, args, resolve, reject)
	end)
end

function encodeUrl(str)
	for c in str:gmatch('[%c%p%s]') do
		if c ~= '%' then
			local find = str:find(c, 1, true)
			if find then
				local char = str:sub(find, find)
				str = str:gsub(string.format('%%%s', char), ('%%%%%02X'):format(char:byte()))
			end
		end
	end
	return u8(str)
end






function sendTelegramNotification(msg) -- ������� ��� �������� ��������� �����
	msg = msg:gsub('{......}', '') --��� ���� ������� ����
	msg = encodeUrl(msg) -- �� ��� �� ���������� ������
	async_http_request('https://api.telegram.org/bot' .. u8:decode(str(token)) .. '/sendMessage?chat_id=' .. u8:decode(str(chat_id)) .. '&text='..msg,'', function(result) end) -- � ��� ��� ��������
end



function get_telegram_updates() -- ������� ��������� ��������� �� �����
    while not updateid do wait(1) end -- ���� ���� �� ������ ��������� ID
    local runner = requestRunner()
    local reject = function() end
    local args = ''
    while true do
        url = 'https://api.telegram.org/bot'..u8:decode(str(token))..'/getUpdates?chat_id='..u8:decode(str(chat_id))..'&offset=-1' -- ������� ������
        threadHandle(runner, url, args, processing_telegram_messages, reject)
        wait(0)
    end
end



function processing_telegram_messages(result) -- ������� ���������� ���� ��� �������� ���
    local proc_result, proc_table = pcall(decodeJson, result)
        if proc_result and proc_table and proc_table.ok then

        -- ���� �� ��������� ��� �� �����
        local proc_table = decodeJson(result)
        if proc_table.ok then
            if #proc_table.result > 0 then
                local res_table = proc_table.result[1]
                if res_table then
                    if res_table.update_id ~= updateid then
                        updateid = res_table.update_id
                        local message_from_user = res_table.message.text
						user_idtg = res_table.message.from.id

                         if message_from_user then
                            -- � ��� ���� ��� �������� ����� �� �������
                            local text = u8:decode(message_from_user) .. ' ' --��������� � ����� ������ ���� �� ��������� ���. ��������� � ���������(���� ���� !q �� ��������� ��� !qq)
                           

                                if text:match('^/stats') then
                                telegrams()
								elseif text:match('^/pcoff') then
								sendTelegramNotification('��������� ����� ������������� ��������')
                                pcoffs()
								elseif text:match('^/rec') then
								sendTelegramNotification('��������������� � ������� 15 ���')
                                rec()
								elseif text:match('^/status') then
								sendStatusTg()
                                elseif text:match('^/send') then
                                local argq = text:gsub('/send ','',1)
                                sampSendChat(argq)


                                elseif text:match('^/diolog') then
                                    sendDialog()
                                

                                elseif text:match('^/dell') then
                                senddell()

                                elseif text:match('^/monitoroff') then
                                os.execute([[ "powershell nircmd.exe monitor off" ]])
                                
                              
                                
                                elseif text:match('^/chest') then
                                    sampSendClickTextdraw(65535)
                                workbotton = new.bool(true)
                                work = true
                                sendTelegramNotification('���� �������� �������� ���')

                                elseif text:match('^/killdiolog') then
                                sampCloseCurrentDialogWithButton(0)
                                wait(200)
                                sampCloseCurrentDialogWithButton(0)
                                sendTelegramNotification('�������� ���� ��������')
              
                                elseif text:match('^/reload') then
                                    thisScript():reload()
                                sendTelegramNotification('������ ���������������')


                                elseif text:match('^/money') then
                                moneya = getPlayerMoney()
                                sendTelegramNotification('��������: $'..moneya)

                            

                           
								elseif text:match('^/help') then
								sendTelegramNotification('%E2%9D%97�������%E2%9D%97\n/stats -- ���������� ��������.\n/money -- ������ �� �����.\n/pc�ff -- ���������� ��.\n/re� -- ��������� �� ������ � ��������� 5 ���.\n/monitoroff -- ��������� �������(NirCmd)\n/status -- ������ �������.\n/diolog -- �������� ��� ��������� �������� �������� � TG.\n/killdiolog -- �������� ���� ��������\n/send -- �������� ��������� � ���.\n/dell --�������� ��� ��������� �������� ������� � ��.\n/chest -- ��������� ���� �������� ��������.\n/reload -- ������������� ������.')	 
                                else -- ���� �� �� �������� �� ���� �� ������ ����, ������� ���������
                                sendTelegramNotification('����������� �������!')
                           
                            
                        end
                    end
                end
            end
        end
    end
end
end



function getLastUpdate() -- ��� �� �������� ��������� ID ���������, ���� �� � ��� � ���� ����� ��������� ������ � chat_id, �������� ��� ������� ��� ���� ���� �������� ��������� ���������
    async_http_request('https://api.telegram.org/bot'..u8:decode(str(token))..'/getUpdates?chat_id='..u8:decode(str(chat_id))..'&offset=-1','',function(result)
        if result then
            local proc_table = decodeJson(result)
            if proc_table.ok then
                if #proc_table.result > 0 then
                    local res_table = proc_table.result[1]
                    if res_table then
                        updateid = res_table.update_id
                    end
                else
                    updateid = 1 -- ��� ������� �������� 1, ���� ������� ����� ������
                end
            end
        end
    end)
end
	
local bank_check = false
local payday_notification_str = '%E2%9D%97__________���������� ���__________%E2%9D%97\n'
local function collectAndSendPayDayData(text)
    local ptrs = {
        "��������������� ��������: %$[%d%.]+",
        "������� � �����: %$[%d%.]+",
        "����� � �������: %$[%d%.]+",
        "������� ����� � �����: %$[%d%.]+",
        "������� ����� �� ��������: %$[%d%.]+",
        "������� � �����: VC%$[%d%.]+",
        "����� � �������: VC%$[%d%.]+",
        "������� ����� � �����: VC%$[%d%.]+",
        "������� ����� �� ��������: VC%$[%d%.]+"
    }

    local text = text:gsub("{%x+}", "")
    for _, v in ipairs(ptrs) do
        if text:find(v) then
            payday_notification_str = ("%s\n%s"):format(payday_notification_str, text)
        end
    end

    if text:find("� ������ ������ � ��� %d") then
        payday_notification_str = ("%s\n%s"):format(payday_notification_str, text)
        if bank_check then
            sendTelegramNotification(("%s"):format(payday_notification_str)) -- copy string
            payday_notification_str = '%E2%9D%97__________���������� ���__________%E2%9D%97\n'
        end
        bank_check = false
    end
end







function sampev.onServerMessage(color, text)
    if text:find('���������� ���') then bank_check = true end
    if bank_check then collectAndSendPayDayData(text) end

    local message = ""

    if text:find('^%[����������%] %{ffffff%}�� ������������ ������ � ��������� � ��������') and color == 1941201407 then
        local drop_starter_donate = text:match('^%[����������%] %{ffffff%}�� ������������ ������ � ��������� � �������� (.+)!')
        message = message .. drop_starter_donate .. "\n"
    end
    
    if text:find('^%[����������%] %{ffffff%}�� ������������ ���������� ������ � ��������� � ��������') and color == 1941201407 then
        local drop_platinum = text:match('^%[����������%] %{ffffff%}�� ������������ ���������� ������ � ��������� � �������� (.+)!')
        message = message .. drop_platinum .. "\n"
    end 
    
    if text:find('^%[����������%] %{ffffff%}�� ������������ ������ ����� ����� � ��������') and color == 1941201407 then
        local drop_elon_musk = text:match('^%[����������%] %{ffffff%}�� ������������ ������ ����� ����� � �������� (.+)!')
        message = message .. drop_elon_musk .. "\n"
    end
    
    if (text:find('^�� ������� ������ ��� �������!') or text:find('^�� ������� ������ Vice City!')) and color == 1118842111 then
    elseif text:find('^%[����������%] %{ffffff%}��������: (.+) � (.+)!') and color == 1941201407 then
        local drop_ls_vc_1, drop_ls_vc_2 = text:match('^%[����������%] %{ffffff%}��������: (.+) � (.+)!')
        message = message .. drop_ls_vc_1 .. "\n" .. drop_ls_vc_2 .. "\n"
    end
    
    sendTelegramNotification(message)
    
    if text:find('^%[������%] %{ffffff%}����� ����� �������� ������������� ��� �� ������!') and color == -1104335361 then
        counter = counter + 1
        sendTelegramNotification('����� ����� �������� ������������� ��� �� ������!')  
    end

    local hookMarket = {
		{text = '^%s*(.+) ����� � ��� (.+), �� ��������(.+)$(.+) �� ������� %(�������� %d+ �������%(�%)%)$', color = -1347440641, key = 2},
		{text = '^%s*�� ������� ������� (.+) �������� (.+), � ������� ��������(.+)$(.+) %(�������� %d+ �������%(�%)%)$', color = -65281, key = 2},
		{text = '^%s*�� ������ (.+) � ������ (.+) ��(.+)$(.+)', color = -1347440641, key = 3},
		{text = '^%s*�� ������� ������ (.+) � (.+) ��(.+)$(.+)', color = -65281, key = 3}
	}

	for k, v in ipairs(hookMarket) do
		if string.find(text, v['text']) and v['color'] == color then
			local args = splitArguments({text:match(v['text'])}, text:find('����� � ���'))
			local textLog = getTypeMessageMarket(text, args)

            sendTelegramNotification(textLog)
			

			if #marketShop > 5  then marketShop = {} end
			table.insert(marketShop, textLog)


			end
		end
	
    if text:find('{FFFFFF}� ��� ���� 3 ������, ����� ��������� �����, ����� ������ ������ ����� ��������.') then
        lavka = new.bool(false) 
        show[0] = true
        sendTelegramNotification('[����������] �� ������ �����!')
        marketShop = {}
        if autoclean[0] then
            clean = new.bool(true)
            radiuslavki = new.bool(false)
            
           
    end    
end

local hookActionsShop = {
    '^%s*%[����������%] {FFFFFF}�� ���������� �� ������ �����!',
    '^%s*%[����������%] {FFFFFF}�� ����� �����!',
    '^%s*%[����������%] {FFFFFF}���� ����� ���� �������, ��%-�� ���� ��� �� � ��������!'
}

for k, v in ipairs(hookActionsShop) do
    if text:find(v) then
        show[0] = false       
        sendTelegramNotification(text)
        end
    end
end





function splitArguments(array, key)
	return {
		['name'] = (key and array[1] or array[2]),
		['item'] = (key and array[2] or array[1]),
		['ViceCity'] = array[3],
		['money'] = stringToCount(array[4])
	}
end

function getTypeMessageMarket(text, args)
	local array = {
		['����� � ���'] = '%s %s ����� "%s" ��%s$%s',
		['�� ������'] = '%s %s ������ "%s" ��%s$%s',
		['�� ������� �������'] = '%s [����� �����] %s ����� "%s" ��%s$%s',
		['�� ������� ������'] = '%s [����� �����] %s ������ "%s" ��%s$%s'
	}
	for k, v in pairs(array) do
		if text:find(k) then return string.format(v, os.date('[%H:%M:%S]'), args['name'], args['item'], args['ViceCity'], money_separator(args['money'])) end
	end
end

function stringToCount(text)
	local count = ''
	for line in text:gmatch('%d') do
		count = count .. line
	end
	return tonumber(count)
end

function money_separator(n)
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

---[����������] {ffffff}�� ������������ ������ � ��������� � �������� ���������� �������!

function telegrams()
if cmd[0] then
diolog[0] = true
sampSendChat('/stats')
wait(500)
diolog[0] = false
end
end


function pcoffs()
if cmd[0] then
os.execute('shutdown /h')
end
end

function rec()
if cmd[0] then
wait(1000)
sampDisconnectWithReason(quit)
wait(5000)
sampSetGamestate(1)
end
end

function getOnline()
	local countvers = 0
	for i = 0, 999 do
		if sampIsPlayerConnected(i) then
			countvers = countvers + 1
		end
	end
	return countvers
end

function sendStatusTg()
	local response = ''
	if sampGetCurrentServerName() then
		response = response .. 'Server: ' .. sampGetCurrentServerName() .. '\n'
	end
	response = response .. 'Online: ' .. getOnline() .. '\n'
	sendTelegramNotification(response)
end




function sendDialog()
	activedia = not activedia
	if activedia then 
        diolog[0] = true
        mainIni.main.diolog = diolog[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
    
        sendTelegramNotification('�������� �������� ��������.')
	else
        diolog[0] = false
        mainIni.main.diolog = diolog[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
    
        sendTelegramNotification('�������� �������� ���������.')
	end
end


------------------------------------------------------------------------------------------------------------------------------------------------------------
local sampev = require 'lib.samp.events'

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
if text:find('�����!') then 
		sampSendDialogResponse(id, 0, _, _)
		return false
	end

    if dialogId == 25194 then
        sampSendDialogResponse(dialogId,1,1,nil) 
        return false

    end

    if dialogId == 26011 then
        sampSendDialogResponse(dialogId,1,1,nil) 
        sampSendChat('/lock')
        return false

    end
    
if settingslavka[0] then
    if title:find ('{BFBBBA}�������� ��� ����� �����') then
		sampSendDialogResponse(dialogId,1,1,nil)
        return false
	end

   if text:find('{FFFFFF}������� �������� ����� �����') then
		sampSendDialogResponse(dialogId, 1, nil, mainIni.main.namelavkas); return false
	end

    if title == '{BFBBBA}�������� ����' and text:find('{E94E4E}|||||||||||||||||||') then
    sampSendDialogResponse(dialogId,1,15,nil)
    sampProcessChatInput('/plt')
    return false
    end
end



if diolog[0] then
if style == 1 or style == 3 then
			sendTelegramNotification('' .. title .. '\n' .. text .. '\n\n[______________]\n\n[' .. button1 .. '] | [' .. button2 .. ']' )
		else
			if style == 0 then
				sendTelegramNotification('' .. title .. '\n' .. text .. '\n\n[' .. button1 .. '] | [' .. button2 .. ']' )
			else
				sendTelegramNotification('' .. title .. '\n' .. text .. '\n\n[' .. button1 .. '] | [' .. button2 .. ']' )

end
end
end
end


imgui.OnInitialize(function()
  imgui.DarkTheme()
end)

function imgui.DarkTheme()
    local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
    example = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14)..'\\impact.ttf', 20, _, glyph_ranges)
        imgui.SwitchContext()
        --==[ STYLE ]==--
        imgui.GetStyle().WindowPadding = imgui.ImVec2(5, 5)
        imgui.GetStyle().FramePadding = imgui.ImVec2(5, 5)
        imgui.GetStyle().ItemSpacing = imgui.ImVec2(5, 5)
        imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(2, 2)
        imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
        imgui.GetStyle().IndentSpacing = 0
        imgui.GetStyle().ScrollbarSize = 10
        imgui.GetStyle().GrabMinSize = 10
    
        --==[ BORDER ]==--
        imgui.GetStyle().WindowBorderSize = 1
        imgui.GetStyle().ChildBorderSize = 1
        imgui.GetStyle().PopupBorderSize = 1
        imgui.GetStyle().FrameBorderSize = 1
        imgui.GetStyle().TabBorderSize = 1
    
        --==[ ROUNDING ]==--
        imgui.GetStyle().WindowRounding = 5
        imgui.GetStyle().ChildRounding = 5
        imgui.GetStyle().FrameRounding = 5
        imgui.GetStyle().PopupRounding = 5
        imgui.GetStyle().ScrollbarRounding = 5
        imgui.GetStyle().GrabRounding = 5
        imgui.GetStyle().TabRounding = 5
    
        --==[ ALIGN ]==--
        imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
        imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
        imgui.GetStyle().SelectableTextAlign = imgui.ImVec2(0.5, 0.5)
        
        --==[ COLORS ]==--
        imgui.GetStyle().Colors[imgui.Col.Text]                   = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
        imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
        imgui.GetStyle().Colors[imgui.Col.WindowBg]               = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
        imgui.GetStyle().Colors[imgui.Col.ChildBg]                = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
        imgui.GetStyle().Colors[imgui.Col.PopupBg]                = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
        imgui.GetStyle().Colors[imgui.Col.Border]                 = imgui.ImVec4(0.25, 0.25, 0.26, 0.54)
        imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
        imgui.GetStyle().Colors[imgui.Col.FrameBg]                = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
        imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = imgui.ImVec4(0.25, 0.25, 0.26, 1.00)
        imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = imgui.ImVec4(0.25, 0.25, 0.26, 1.00)
        imgui.GetStyle().Colors[imgui.Col.TitleBg]                = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
        imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
        imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
        imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
        imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
        imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
        imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = imgui.ImVec4(0.41, 0.41, 0.41, 1.00)
        imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = imgui.ImVec4(0.51, 0.51, 0.51, 1.00)
        imgui.GetStyle().Colors[imgui.Col.CheckMark]              = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
        imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
        imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
        imgui.GetStyle().Colors[imgui.Col.Button]                 = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
        imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
        imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = imgui.ImVec4(0.41, 0.41, 0.41, 1.00)
        imgui.GetStyle().Colors[imgui.Col.Header]                 = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
        imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = imgui.ImVec4(0.20, 0.20, 0.20, 1.00)
        imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = imgui.ImVec4(0.47, 0.47, 0.47, 1.00)
        imgui.GetStyle().Colors[imgui.Col.Separator]              = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
        imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
        imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
        imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = imgui.ImVec4(1.00, 1.00, 1.00, 0.25)
        imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = imgui.ImVec4(1.00, 1.00, 1.00, 0.67)
        imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = imgui.ImVec4(1.00, 1.00, 1.00, 0.95)
        imgui.GetStyle().Colors[imgui.Col.Tab]                    = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
        imgui.GetStyle().Colors[imgui.Col.TabHovered]             = imgui.ImVec4(0.28, 0.28, 0.28, 1.00)
        imgui.GetStyle().Colors[imgui.Col.TabActive]              = imgui.ImVec4(0.30, 0.30, 0.30, 1.00)
        imgui.GetStyle().Colors[imgui.Col.TabUnfocused]           = imgui.ImVec4(0.07, 0.10, 0.15, 0.97)
        imgui.GetStyle().Colors[imgui.Col.TabUnfocusedActive]     = imgui.ImVec4(0.14, 0.26, 0.42, 1.00)
        imgui.GetStyle().Colors[imgui.Col.PlotLines]              = imgui.ImVec4(0.61, 0.61, 0.61, 1.00)
        imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = imgui.ImVec4(1.00, 0.43, 0.35, 1.00)
        imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
        imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
        imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = imgui.ImVec4(1.00, 0.00, 0.00, 0.35)
        imgui.GetStyle().Colors[imgui.Col.DragDropTarget]         = imgui.ImVec4(1.00, 1.00, 0.00, 0.90)
        imgui.GetStyle().Colors[imgui.Col.NavHighlight]           = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
        imgui.GetStyle().Colors[imgui.Col.NavWindowingHighlight]  = imgui.ImVec4(1.00, 1.00, 1.00, 0.70)
        imgui.GetStyle().Colors[imgui.Col.NavWindowingDimBg]      = imgui.ImVec4(0.80, 0.80, 0.80, 0.20)
        imgui.GetStyle().Colors[imgui.Col.ModalWindowDimBg]       = imgui.ImVec4(0.00, 0.00, 0.00, 0.70)
end