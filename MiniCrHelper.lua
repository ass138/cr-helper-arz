script_name("cr-helper-arz")
script_version("21.11.2023")

--õóé--
require 'lib.moonloader'
local imgui = require 'mimgui' -- ïîäêëþ÷àåì áèáëèîòåêó ìèìãóè
local encoding = require 'encoding' -- ïîäêëþ÷àåì áèáëèîòåêó äëÿ ðàáîòû ñ ðàçíûìè êîäèðîâêàìè
encoding.default = 'CP1251' -- çàäà¸ì êîäèðîâêó ïî óìîë÷àíèþ
local u8 = encoding.UTF8 -- ýòî ïîçâîëèò íàì ïèñàòü çàäàâàòü íàçâàíèÿ/òåêñò íà êèðèëëèöå
local new = imgui.new -- ñîçäà¸ì êîðîòêèé ïñåâäîíèì äëÿ óäîáñòâà
local WinState = new.bool() -- ñîçäà¸ì áóôôåð äëÿ îòêðûòèÿ îêíà
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
local lavki = {}
local keys = require "vkeys"
local ffi = require 'ffi'
local new, str = imgui.new, ffi.string
local effil = require("effil")
local encoding = require("encoding")
encoding.default = 'CP1251'
u8 = encoding.UTF8

local inicfg = require 'inicfg'
local mainIni = inicfg.load({
	main =
    {
		autoeatmin = 0, -- çíà÷åíèå èíïóòà
		ComboTest = 0,
		pcoff = 0,
		chat_id = '',
		token = '',
		diolog = false,
		cmd = false,
		payday = false,
    }}, 'MiniHelper-CR.ini')



local SliderOne = new.int(mainIni.main.autoeatmin)
local ComboTest = new.int((mainIni.main.ComboTest)) -- ñîçäà¸ì áóôôåð äëÿ êîìáî
---
local lavka = new.bool() -- ñîçä¸ì áóôôåð äëÿ ÷åêáîêñà, êîòîðûé âîçâðàùàåò true/false

local clean = new.bool() -- ñîçä¸ì áóôôåð äëÿ ÷åêáîêñà, êîòîðûé âîçâðàùàåò true/false
local autoeat = new.bool() -- ñîçä¸ì áóôôåð äëÿ ÷åêáîêñà, êîòîðûé âîçâðàùàåò true/false
local item_list = {u8'Îëåíèíà', u8'Ìåøîê ñ ìÿñîì'} -- ñîçäà¸ì ñïèñîê
local ImItems = imgui.new['const char*'][#item_list](item_list)
local pcoff = new.bool() -- ñîçä¸ì áóôôåð äëÿ ÷åêáîêñà, êîòîðûé âîçâðàùàåò true/false
local SliderTwo = new.int(0)
local SliderFri = new.int(0)
---

local ComboTesta = new.int(mainIni.main.pcoff) -- ñîçäà¸ì áóôôåð äëÿ êîìáî
local item_lista = {u8'âûêëþ÷åíèå ïê', u8'ãèáåðíàöèÿ'} -- ñîçäà¸ì ñïèñîê
local ImItemsa = imgui.new['const char*'][#item_lista](item_lista)



---¹2---
local cmd = new.bool(mainIni.main.cmd)

local diolog = new.bool(mainIni.main.diolog) -- ñîçä¸ì áóôôåð äëÿ ÷åêáîêñà, êîòîðûé âîçâðàùàåò true/false


local chat_id = new.char[256](u8(mainIni.main.chat_id)) -- ñîçäà¸ì áóôôåð äëÿ èíïóòà
local token = new.char[256](u8(mainIni.main.token)) -- ñîçäà¸ì áóôôåð äëÿ èíïóòà


local payday = new.bool(mainIni.main.payday) -- ñîçä¸ì áóôôåð äëÿ ÷åêáîêñà, êîòîðûé âîçâðàùàåò true/false

---¹2---

imgui.OnFrame(function() return WinState[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(1390,400), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5)) -- îòâå÷àåò çà ïîëîæåíèå îêíà íà ýêðàíå
        imgui.SetNextWindowSize(imgui.ImVec2(250, 280), imgui.Cond.Always) -- îòâå÷àåò çà ðàçìåð îêíà
        imgui.Begin(u8'MiniHelper-CR', WinState, imgui.WindowFlags.NoResize) -- îòâå÷àåò çà îòîáðàæåíèå îêíà, åãî çàãîëîâîê è ôëàãè
		if imgui.BeginTabBar('Tabs') then -- çàäà¸ì íà÷àëî âêëàäîê
    if imgui.BeginTabItem(u8'Îñíîâíûå') then -- ïåðâàÿ âêëàäêà
		imgui.Checkbox(u8'Ðåíäåð ëàâîê', lavka)
		imgui.Checkbox(u8'Óäàëåíèå Èãðîêîâ è ÒÑ', clean)
		imgui.Separator()
		

		imgui.Checkbox(u8'Â îïðåä. âðåìÿ', pcoff)
		if imgui.Combo(u8'###',ComboTesta,ImItemsa, #item_lista) then
		mainIni.main.pcoff = ComboTesta[0]
		inicfg.save(mainIni, "MiniHelper-CR")
		end
		imgui.PushItemWidth(190)
		imgui.SliderInt(u8'×àñû', SliderTwo, 0, 23) -- 3 àðãóìåíòîì ÿâëÿåòñÿ ìèíèìàëüíîå çíà÷åíèå, à 4 àðãóìåíò çàäà¸ò ìàêñèìàëüíîå çíà÷åíèå
		imgui.SliderInt(u8'Ìèíóòû', SliderFri, 0, 59) -- 3 àðãóìåíòîì ÿâëÿåòñÿ ìèíèìàëüíîå çíà÷åíèå, à 4 àðãóìåíò çàäà¸ò ìàêñèìàëüíîå çíà÷åíèå
		imgui.PopItemWidth()
		imgui.Separator()	
		imgui.Checkbox(u8'Àâòî-Åäà', autoeat)
		imgui.PushItemWidth(190)
		if imgui.SliderInt(u8'Ìèíóòû.', SliderOne, 1, 60) then -- 3 àðãóìåíòîì ÿâëÿåòñÿ ìèíèìàëüíîå çíà÷åíèå, à 4 àðãóìåíò çàäà¸ò ìàêñèìàëüíîå çíà÷åíèå
		mainIni.main.autoeatmin = SliderOne[0]
		inicfg.save(mainIni, "MiniHelper-CR")
		end
		imgui.PopItemWidth()
		
		if imgui.Combo(u8'##',ComboTest,ImItems, #item_list) then
		 mainIni.main.ComboTest = ComboTest[0]
		 inicfg.save(mainIni, "MiniHelper-CR")
		end
		   imgui.EndTabItem() -- êîíåö âêëàäêè
    end
 if imgui.BeginTabItem(u8'Telegram') then -- âòîðàÿ âêëàäêà

if imgui.Checkbox(u8'Ïðèíèìàòü êîìàíäû èç TG', cmd) then
		mainIni.main.cmd = cmd[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
		end


 if imgui.Checkbox(u8'Îòïðàâëÿòü äèàëîãè â TG', diolog) then
		mainIni.main.diolog = diolog[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
		end
		
		if imgui.Checkbox(u8'Îòïðàâ TG óâåä î ïîëó÷åíèè PD', payday) then
		mainIni.main.payday = payday[0] 
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
		
		if imgui.Button('test message') then

        sendTelegramNotification('Òåñòîâîå ñîîáùåíèå îò '..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))) -- îòïðàâëÿåì ñîîáùåíèå þçåðó
		
		end
		
		
		imgui.Text(u8'Êîìàíäû: /stats, /wbook, /pcoff, /rec')
		imgui.Text(u8'/status')
		
		
		
		
		
        imgui.EndTabItem() -- êîíåö âêëàäêè
    end
    imgui.EndTabBar() -- êîíåö âñåõ âêëàäîê
end

        imgui.End()
    end

)



-- https://github.com/ass138/cr-helper-arz/tree/main
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'Îáíàðóæåíî îáíîâëåíèå. Ïûòàþñü îáíîâèòüñÿ c '..thisScript().version..' íà '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('Çàãðóæåíî %d èç %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('Çàãðóçêà îáíîâëåíèÿ çàâåðøåíà.')sampAddChatMessage(b..'Îáíîâëåíèå çàâåðøåíî!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'Îáíîâëåíèå ïðîøëî íåóäà÷íî. Çàïóñêàþ óñòàðåâøóþ âåðñèþ..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': Îáíîâëåíèå íå òðåáóåòñÿ.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': Íå ìîãó ïðîâåðèòü îáíîâëåíèå. Ñìèðèòåñü èëè ïðîâåðüòå ñàìîñòîÿòåëüíî íà '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, âûõîäèì èç îæèäàíèÿ ïðîâåðêè îáíîâëåíèÿ. Ñìèðèòåñü èëè ïðîâåðüòå ñàìîñòîÿòåëüíî íà '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/ass138/cr-helper-arz/main/version.json?" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://github.com/ass138/cr-helper-arz/tree/main"
        end
    end
end

		


 
function main()
    while not isSampAvailable() do wait(100) end -- æä¸ì êîãäà çàãðóçèòñÿ ñàìï
	getLastUpdate() -- âûçûâàåì ôóíêöèþ ïîëó÷åíèÿ ïîñëåäíåãî ID ñîîáùåíèÿ
	          if autoupdate_loaded and enable_autoupdate and Update then
        pcall(Update.check, Update.json_url, Update.prefix, Update.url)
    end
		 lua_thread.create(get_telegram_updates) -- ñîçäàåì íàøó ôóíêöèþ ïîëó÷åíèÿ ñîîáùåíèé îò þçåðà	
			lua_thread.create(lavkirendor)
			lua_thread.create(cleanr)
			lua_thread.create(eat)
			lua_thread.create(pcoffe)
	while true do wait(0)
	  if wasKeyPressed(VK_F2) and not sampIsCursorActive() then -- åñëè íàæàòà êëàâèøà R è íå àêòèâåí ñàìï êóðñîð
            WinState[0] = not WinState[0]
      
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
							renderFontDrawText(font, 'Ñâîáîäíà', lX - 30, lY - 20, 0xFF16C910, 0x90000000)
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
			renderFontDrawText(font, 'Ñâîáîäíî: '..lavki, PosX, PosY + 80, 0xFFFFFFFF, 0x90000000)
		end
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






function pcoffe()
 while true do wait(0)
if pcoff[0] then
if os.date('%H:%M') == string.format("%02d", SliderTwo[0])..':'..string.format("%02d", SliderFri[0]) then
      if ComboTesta[0] == 0 then
        os.execute('shutdown /s')
      elseif ComboTesta[0] == 1 then
        os.execute('shutdown /h')
      end
	  end
	  end
	  end
	  end


------------------------------------------------------------------------------------------------------------------------------------------------------------

local updateid -- ID ïîñëåäíåãî ñîîáùåíèÿ äëÿ òîãî ÷òîáû íå áûëî ôëóäà

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

function sendTelegramNotification(msg) -- ôóíêöèÿ äëÿ îòïðàâêè ñîîáùåíèÿ þçåðó
	msg = msg:gsub('{......}', '') --òóò òèïî óáèðàåì öâåò
	msg = encodeUrl(msg) -- íó òóò ìû çàêîäèðóåì ñòðîêó
	async_http_request('https://api.telegram.org/bot' .. u8:decode(str(token)) .. '/sendMessage?chat_id=' .. u8:decode(str(chat_id)) .. '&text='..msg,'', function(result) end) -- à òóò óæå îòïðàâêà
end

function get_telegram_updates() -- ôóíêöèÿ ïîëó÷åíèÿ ñîîáùåíèé îò þçåðà
    while not updateid do wait(1) end -- æäåì ïîêà íå óçíàåì ïîñëåäíèé ID
    local runner = requestRunner()
    local reject = function() end
    local args = ''
    while true do
        url = 'https://api.telegram.org/bot'..u8:decode(str(token))..'/getUpdates?chat_id='..u8:decode(str(chat_id))..'&offset=-1' -- ñîçäàåì ññûëêó
        threadHandle(runner, url, args, processing_telegram_messages, reject)
        wait(0)
    end
end

function calc(str) --ýòî òåñòîâàÿ ôóíêöèÿ, å¸ íå òðåáóåòñÿ ïåðåíîñèòü â âàø êîä
    return assert(load("return "..str))()
end

function processing_telegram_messages(result) -- ôóíêöèÿ ïðîâåðÎ÷êè òîãî ÷òî îòïðàâèë ÷åë


        -- òóòà ìû ïðîâåðÿåì âñå ëè âåðíî
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
                            -- è òóò åñëè ÷åë îòïðàâèë òåêñò ìû ñâåðÿåì
                            local text = u8:decode(message_from_user) .. ' ' --äîáàâëÿåì â êîíåö ïðîáåë äàáû íå ïðîèçîøëè òåõ. øîêîëàäêè ñ êîìàíäàìè(òèïî ÷òîá !q íå ñ÷èòàëîñü êàê !qq)
                           

                            if text:match('^/stats') then
                                telegrams()
							elseif text:match('^/wbook') then
                                wbook()
								elseif text:match('^/pcoff') then
								sendTelegramNotification('êîìïüþòåð áóäåò àâòîìàòè÷åñêè âûêëþ÷åí')
                                pcoffs()
								elseif text:match('^/rec') then
								sendTelegramNotification('ïåðåïîäêëþ÷åíèå ê ñåðâåðó')
                                rec()
								elseif text:match('^/status') then
								sendStatusTg()
				
								 
                            else -- åñëè æå íå íàéäåòñÿ íè îäíà èç êîìàíä âûøå, âûâåäåì ñîîáùåíèå
                                sendTelegramNotification('Íåèçâåñòíàÿ êîìàíäà!')
                            
							end
                        end
                    end
                
            end
        end
    end
end

function getLastUpdate() -- òóò ìû ïîëó÷àåì ïîñëåäíèé ID ñîîáùåíèÿ, åñëè æå ó âàñ â êîäå áóäåò íàñòðîéêà òîêåíà è chat_id, âûçîâèòå ýòó ôóíêöèþ äëÿ òîãî ÷òîá ïîëó÷èòü ïîñëåäíåå ñîîáùåíèå
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
                    updateid = 1 -- òóò çàäàäèì çíà÷åíèå 1, åñëè òàáëèöà áóäåò ïóñòàÿ
                end
            end
        end
    end)
end



function sampev.onServerMessage(color, text)
    if text:find('^%[Èíôîðìàöèÿ%] {FFFFFF}Âàøà ëàâêà áûëà çàêðûòà') then
            sendTelegramNotification('Âàñ âûêèíóëè ñ âàøåé ëàâêè!')
        end
        if text:find('^.+ êóïèë ó âàñ .+, âû ïîëó÷èëè %$%d+ îò ïðîäàæè %(êîìèññèÿ %d ïðîöåíò%(à%)%)') then
            local name, product, money = text:match('^(.+) êóïèë ó âàñ (.+), âû ïîëó÷èëè %$([%d.,]+) îò ïðîäàæè %(êîìèññèÿ %d ïðîöåíò%(à%)%)')
            local reg_text = 'Âû ïðîäàëè: "'..product..'" çà '..money..'$ Èãðîêó: '..name..'.'
                sendTelegramNotification(reg_text)
            end
        if text:find('^Âû êóïèëè .+ ó èãðîêà .+ çà %$%d+') then
            local product, name, money = text:match('^Âû êóïèëè (.+) ó èãðîêà (.+) çà %$([%d.,]+)')
            local reg_text = 'Âû êóïèëè: "'..product..'" çà '..money..'$ Ó èãðîêà: '..name..'.'
                sendTelegramNotification(reg_text)
            end

zarplata = 0
depozpdtg = 0
zppdtg = 0
sumbank = 0
sumdepoz = 0
lvlpdtg = 0



if payday[0] then
	if text:find("Îðãàíèçàöèîííàÿ çàðïëàòà: $%d+.") then
	zarplata = tonumber(text:match("Îðãàíèçàöèîííàÿ çàðïëàòà: %$([%d.,]+)"))
				
	end
	if text:find("Äåïîçèò â áàíêå: $%d+.") then
	depozpdtg = tonumber(text:match("Äåïîçèò â áàíêå: %$([%d.,]+)"))
				
	end
	if text:find("Ñóììà ê âûïëàòå: %$%d+") then
        zppdtg = tonumber(text:match("Ñóììà ê âûïëàòå: %$([%d.,]+)"))
				

	end
	if text:find("Òåêóùàÿ ñóììà â áàíêå: $%d") then
		sumbank = tonumber(text:match("Òåêóùàÿ ñóììà â áàíêå: %$([%d.,]+)"))
					
    end
	if text:find("Òåêóùàÿ ñóììà íà äåïîçèòå: $%d") then
		sumdepoz = tonumber(text:match("Òåêóùàÿ ñóììà íà äåïîçèòå: %$([%d.,]+)"))
					
    end
	if text:find("Â äàííûé ìîìåíò ó âàñ %d") then
		lvlpdtg = tonumber(text:match("Â äàííûé ìîìåíò ó âàñ (%d+)"))
					sendTelegramNotification('%E2%9D%97__________Áàíêîâñêèé ÷åê__________%E2%9D%97\n\nÎðãàíèçàöèîííàÿ çàðïëàòà: '..zarplata..'\nÄåïîçèò â áàíêå: '..depozpdtg..'\nÑóììà ê âûïëàòå: '..zppdtg..'\nÒåêóùàÿ ñóììà â áàíêå: '..sumbank..'\nÒåêóùàÿ ñóììà íà äåïîçèòå: '..sumdepoz..'\nÂ äàííûé ìîìåíò ó âàñ '..lvlpdtg)
					end
					
					
	end
	end

 




function telegrams()
if cmd[0] then
sampSendChat('/stats')
end
end

function wbook()
if cmd[0] then
sampSendChat('/wbook')
sampSendDialogResponse(25228, 1, 0, 1); return false
end
end


function pcoffs()
if cmd[0] then
os.execute('shutdown /h')
end
end

function rec()
if cmd[0] then
sampSendChat('/rec')
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


------------------------------------------------------------------------------------------------------------------------------------------------------------


function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
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
  theme()
end)

function theme()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    -->> Sizez
    imgui.GetStyle().WindowPadding = imgui.ImVec2(4, 4)
    imgui.GetStyle().FramePadding = imgui.ImVec2(4, 3)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(8, 4)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(4, 4)
    imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)

    imgui.GetStyle().IndentSpacing = 21
    imgui.GetStyle().ScrollbarSize = 14
    imgui.GetStyle().GrabMinSize = 10

    imgui.GetStyle().WindowBorderSize = 0
    imgui.GetStyle().ChildBorderSize = 1
    imgui.GetStyle().PopupBorderSize = 1
    imgui.GetStyle().FrameBorderSize = 1
    imgui.GetStyle().TabBorderSize = 0

    imgui.GetStyle().WindowRounding = 5
    imgui.GetStyle().ChildRounding = 5
    imgui.GetStyle().PopupRounding = 5
    imgui.GetStyle().FrameRounding = 5
    imgui.GetStyle().ScrollbarRounding = 2.5
    imgui.GetStyle().GrabRounding = 5
    imgui.GetStyle().TabRounding = 5

    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.50, 0.50)

    -->> Colors
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)

    colors[clr.WindowBg]               = ImVec4(0.15, 0.16, 0.37, 1.00)
    colors[clr.ChildBg]                = ImVec4(0.17, 0.18, 0.43, 1.00)
    colors[clr.PopupBg]                = colors[clr.WindowBg]

    colors[clr.Border]                 = ImVec4(0.33, 0.34, 0.62, 1.00)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)

    colors[clr.TitleBg]                = ImVec4(0.18, 0.20, 0.46, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.18, 0.20, 0.46, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.18, 0.20, 0.46, 1.00)
    colors[clr.MenuBarBg]              = colors[clr.ChildBg]

    colors[clr.ScrollbarBg]            = ImVec4(0.14, 0.14, 0.36, 1.00)
    colors[clr.ScrollbarGrab]          = ImVec4(0.22, 0.22, 0.53, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.20, 0.21, 0.53, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.25, 0.25, 0.58, 1.00)

    colors[clr.Button]                 = ImVec4(0.25, 0.25, 0.58, 1.00)
    colors[clr.ButtonHovered]          = ImVec4(0.23, 0.23, 0.55, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.27, 0.27, 0.62, 1.00)

    colors[clr.CheckMark]              = ImVec4(0.39, 0.39, 0.83, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.39, 0.39, 0.83, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.48, 0.48, 0.96, 1.00)

    colors[clr.FrameBg]                = colors[clr.Button]
    colors[clr.FrameBgHovered]         = colors[clr.ButtonHovered]
    colors[clr.FrameBgActive]          = colors[clr.ButtonActive]

    colors[clr.Header]                 = colors[clr.Button]
    colors[clr.HeaderHovered]          = colors[clr.ButtonHovered]
    colors[clr.HeaderActive]           = colors[clr.ButtonActive]

    colors[clr.Separator]              = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.SeparatorHovered]       = colors[clr.SliderGrabActive]
    colors[clr.SeparatorActive]        = colors[clr.SliderGrabActive]

    colors[clr.ResizeGrip]             = colors[clr.Button]
    colors[clr.ResizeGripHovered]      = colors[clr.ButtonHovered]
    colors[clr.ResizeGripActive]       = colors[clr.ButtonActive]

    colors[clr.Tab]                    = colors[clr.Button]
    colors[clr.TabHovered]             = colors[clr.ButtonHovered]
    colors[clr.TabActive]              = colors[clr.ButtonActive]
    colors[clr.TabUnfocused]           = colors[clr.Button]
    colors[clr.TabUnfocusedActive]     = colors[clr.Button]

    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)

    colors[clr.TextSelectedBg]         = ImVec4(0.33, 0.33, 0.57, 1.00)
    colors[clr.DragDropTarget]         = ImVec4(1.00, 1.00, 0.00, 0.90)

    colors[clr.NavHighlight]           = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.NavWindowingHighlight]  = ImVec4(1.00, 1.00, 1.00, 0.70)
    colors[clr.NavWindowingDimBg]      = ImVec4(0.80, 0.80, 0.80, 0.20)

    colors[clr.ModalWindowDimBg]       = ImVec4(0.00, 0.00, 0.00, 0.90)
end
