script_name("cr-helper-arz")
script_version("22.11.2023")

--���--
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
		autoeatmin = 0, -- �������� ������
		ComboTest = 0,
		pcoff = 0,
		chat_id = '',
		token = '',
		diolog = false,
		cmd = false,
		payday = false,
		info = false,
    }}, 'MiniHelper-CR.ini')



local SliderOne = new.int(mainIni.main.autoeatmin)
local ComboTest = new.int((mainIni.main.ComboTest)) -- ������ ������ ��� �����
---
local lavka = new.bool() -- ����� ������ ��� ��������, ������� ���������� true/false

local clean = new.bool() -- ����� ������ ��� ��������, ������� ���������� true/false
local autoeat = new.bool() -- ����� ������ ��� ��������, ������� ���������� true/false
local item_list = {u8'�������', u8'����� � �����'} -- ������ ������
local ImItems = imgui.new['const char*'][#item_list](item_list)
local pcoff = new.bool() -- ����� ������ ��� ��������, ������� ���������� true/false
local SliderTwo = new.int(0)
local SliderFri = new.int(0)
---

local ComboTesta = new.int(mainIni.main.pcoff) -- ������ ������ ��� �����
local item_lista = {u8'���������� ��', u8'����������'} -- ������ ������
local ImItemsa = imgui.new['const char*'][#item_lista](item_lista)


---�2---
local cmd = new.bool(mainIni.main.cmd)

local diolog = new.bool(mainIni.main.diolog) -- ����� ������ ��� ��������, ������� ���������� true/false


local chat_id = new.char[256](u8(mainIni.main.chat_id)) -- ������ ������ ��� ������
local token = new.char[256](u8(mainIni.main.token)) -- ������ ������ ��� ������


local payday = new.bool(mainIni.main.payday) -- ����� ������ ��� ��������, ������� ���������� true/false

---�2---

imgui.OnFrame(function() return WinState[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(1390,400), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5)) -- �������� �� ��������� ���� �� ������
        imgui.SetNextWindowSize(imgui.ImVec2(250, 280), imgui.Cond.Always) -- �������� �� ������ ����
        imgui.Begin(u8'MiniHelper-CR', WinState, imgui.WindowFlags.NoResize) -- �������� �� ����������� ����, ��� ��������� � �����
		if imgui.BeginTabBar('Tabs') then -- ����� ������ �������
    if imgui.BeginTabItem(u8'��������') then -- ������ �������
		imgui.Checkbox(u8'������ �����', lavka)
		imgui.Checkbox(u8'�������� ������� � ��', clean)
		imgui.Separator()
		

		imgui.Checkbox(u8'� �����. �����', pcoff)
		if imgui.Combo(u8'###',ComboTesta,ImItemsa, #item_lista) then
		mainIni.main.pcoff = ComboTesta[0]
		inicfg.save(mainIni, "MiniHelper-CR")
		end
		imgui.PushItemWidth(190)
		imgui.SliderInt(u8'����', SliderTwo, 0, 23) -- 3 ���������� �������� ����������� ��������, � 4 �������� ����� ������������ ��������
		imgui.SliderInt(u8'������', SliderFri, 0, 59) -- 3 ���������� �������� ����������� ��������, � 4 �������� ����� ������������ ��������
		imgui.PopItemWidth()
		imgui.Separator()	
		imgui.Checkbox(u8'����-���', autoeat)
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
		
		   imgui.EndTabItem() -- ����� �������
    end
	if imgui.BeginTabItem(u8'��� ������ ���') then -- ������ �������

	
	 imgui.EndTabItem() -- ����� �������
    end
	
	
 if imgui.BeginTabItem(u8'Telegram') then -- ������ �������

if imgui.Checkbox(u8'��������� ������� �� TG', cmd) then
		mainIni.main.cmd = cmd[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
		end


 if imgui.Checkbox(u8'���������� ������� � TG', diolog) then
		mainIni.main.diolog = diolog[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
		end
		
		if imgui.Checkbox(u8'������ TG ���� � ��������� PD', payday) then
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

        sendTelegramNotification('�������� ��������� �� '..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))) -- ���������� ��������� �����
		
		end
		
		
		imgui.Text(u8'�������: /stats, /wbook, /pcoff, /rec')
		imgui.Text(u8'/status')
		
		
		
		
		
        imgui.EndTabItem() -- ����� �������
    end
    imgui.EndTabBar() -- ����� ���� �������
end

        imgui.End()
    end

)



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

		


 
function main()
    while not isSampAvailable() do wait(100) end -- ��� ����� ���������� ����
	getLastUpdate() -- �������� ������� ��������� ���������� ID ���������
	          if autoupdate_loaded and enable_autoupdate and Update then
        pcall(Update.check, Update.json_url, Update.prefix, Update.url)
    end
		 lua_thread.create(get_telegram_updates) -- ������� ���� ������� ��������� ��������� �� �����	
			lua_thread.create(lavkirendor)
			lua_thread.create(cleanr)
			lua_thread.create(eat)
			lua_thread.create(pcoffe)
	while true do wait(0)
	  if wasKeyPressed(VK_F2) and not sampIsCursorActive() then -- ���� ������ ������� R � �� ������� ���� ������
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

function calc(str) --��� �������� �������, � �� ��������� ���������� � ��� ���
    return assert(load("return "..str))()
end

function processing_telegram_messages(result) -- ������� ���������� ���� ��� �������� ���


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
							elseif text:match('^/wbook') then
                                wbook()
								elseif text:match('^/pcoff') then
								sendTelegramNotification('��������� ����� ������������� ��������')
                                pcoffs()
								elseif text:match('^/rec') then
								sendTelegramNotification('��������������� � �������')
                                rec()
								elseif text:match('^/status') then
								sendStatusTg()
				
								 
                            else -- ���� �� �� �������� �� ���� �� ������ ����, ������� ���������
                                sendTelegramNotification('����������� �������!')
                            
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



function sampev.onServerMessage(color, text)
    if text:find('^%[����������%] {FFFFFF}���� ����� ���� �������') then
            sendTelegramNotification('��� �������� � ����� �����!')
        end
        if text:find('^.+ ����� � ��� .+, �� �������� %$%d+ �� ������� %(�������� %d �������%(�%)%)') then
            local name, product, money = text:match('^(.+) ����� � ��� (.+), �� �������� %$([%d.,]+) �� ������� %(�������� %d �������%(�%)%)')
            local reg_text = '�� �������: "'..product..'" �� '..money..'$ ������: '..name..'.'
                sendTelegramNotification(reg_text)
            end
        if text:find('^�� ������ .+ � ������ .+ �� %$%d+') then
            local product, name, money = text:match('^�� ������ (.+) � ������ (.+) �� %$([%d.,]+)')
            local reg_text = '�� ������: "'..product..'" �� '..money..'$ � ������: '..name..'.'
                sendTelegramNotification(reg_text)
            end

zarplata = 0
depozpdtg = 0
zppdtg = 0
sumbank = 0
sumdepoz = 0
lvlpdtg = 0



if payday[0] then
	if text:find("��������������� ��������: $%d+.") then
	zarplata = tonumber(text:match("��������������� ��������: %$([%d.,]+)"))
				
	end
	if text:find("������� � �����: $%d+.") then
	depozpdtg = tonumber(text:match("������� � �����: %$([%d.,]+)"))
				
	end
	if text:find("����� � �������: %$%d+") then
        zppdtg = tonumber(text:match("����� � �������: %$([%d.,]+)"))
				

	end
	if text:find("������� ����� � �����: $%d") then
		sumbank = tonumber(text:match("������� ����� � �����: %$([%d.,]+)"))
					
    end
	if text:find("������� ����� �� ��������: $%d") then
		sumdepoz = tonumber(text:match("������� ����� �� ��������: %$([%d.,]+)"))
					
    end
	if text:find("� ������ ������ � ��� %d") then
		lvlpdtg = tonumber(text:match("� ������ ������ � ��� (%d+)"))
					sendTelegramNotification('%E2%9D%97__________���������� ���__________%E2%9D%97\n\n��������������� ��������: '..zarplata..'\n������� � �����: '..depozpdtg..'\n����� � �������: '..zppdtg..'\n������� ����� � �����: '..sumbank..'\n������� ����� �� ��������: '..sumdepoz..'\n� ������ ������ � ��� '..lvlpdtg)
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