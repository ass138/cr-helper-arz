script_name("MiniCrHelper")
script_version("0.0.1")


--ебаные библиотеки--
require 'lib.moonloader'
local imgui = require 'mimgui' -- подключаем библиотеку мимгуи
local encoding = require 'encoding' -- подключаем библиотеку для работы с разными кодировками
encoding.default = 'CP1251' -- задаём кодировку по умолчанию
local u8 = encoding.UTF8 -- это позволит нам писать задавать названия/текст на кириллице
local new = imgui.new -- создаём короткий псевдоним для удобства
local WinState = new.bool() -- создаём буффер для открытия окна
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
local ev = require 'samp.events'
local lavki = {}
local keys = require "vkeys"
local ffi = require 'ffi'
local new, str = imgui.new, ffi.string
local effil = require("effil")
local encoding = require("encoding")
encoding.default = 'CP1251'
u8 = encoding.UTF8
--ебаные библиотеки--

--ебаный CFG--
local inicfg = require 'inicfg'
local mainIni = inicfg.load({
	main =
    {
	    autoeat = false,
		autoeatmin = 0, -- значение инпута
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
        color = 1.0, 1.0, 1.0, 1.0,
    }}, 'MiniHelper-CR.ini')
--ебаный CFG--




--ебаная 1 страница--
local SliderOne = new.int(mainIni.main.autoeatmin)
local ComboTest = new.int((mainIni.main.ComboTest)) -- создаём буффер для комбо
local lavka = new.bool() -- создём буффер для чекбокса, который возвращает true/false
local radiuslavki = new.bool() -- создём буффер для чекбокса, который возвращает true/false
local clean = new.bool(mainIni.main.clean) -- создём буффер для чекбокса, который возвращает true/false
local autoclean = new.bool(mainIni.main.autoclean) -- создём буфер для чекбокса, который возвращает true/false
local autoeat = new.bool(mainIni.main.autoeat) -- создём буффер для чекбокса, который возвращает true/false
local item_list = {u8'Оленина', u8'Мешок с мясом'} -- создаём список
local ImItems = imgui.new['const char*'][#item_list](item_list)
local pcoff = new.bool() -- создём буффер для чекбокса, который возвращает true/false
local SliderTwo = new.int(0)
local SliderFri = new.int(0)
--ебаная 1 страница--





---Chests---
local checkbox_standart = new.bool(mainIni.main.standart) -- Сундук рулетки
local checkbox_donate = new.bool(mainIni.main.donate) -- Сундук платиновой рулетки
local checkbox_tainik = new.bool(mainIni.main.tainik) -- Сундук рулетки (донат)
local checkbox_mask = new.bool(mainIni.main.mask) -- Тайник Илона Маска
local checkbox_platina = new.bool(mainIni.main.platina) -- Тайник Лос Сантоса
local checkbox_vice = new.bool(mainIni.main.vice) -- Тайник Vice City
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
local tab = 1 -- в этой переменной будет хранится номер открытой вкладки

local timechestto = new.char[256]() -- создаём буфер для инпута
local delayedtimer = new.bool() -- авто space
---Auto---
local autokey1 = new.bool() -- авто space
local timekey1 = new.int(5) -- создаём буфер для SliderInt со значением 2 по умолчанию
local buttonkey1 = new.char[256]() -- создаём буфер для инпута

local autokey2 = new.bool() -- авто space
local timekey2 = new.int(5) -- создаём буфер для SliderInt со значением 2 по умолчанию
local buttonkey2 = new.char[256]() -- создаём буфер для инпута
local timekey3 = new.int(5) -- создаём буфер для SliderInt со значением 2 по умолчанию
local buttonkey3 = new.char[256]() -- создаём буфер для инпута
---Auto---

--ADD-VIP--

--ADD-VIP--

---Telegram---
local cmd = new.bool(mainIni.main.cmd)
local diolog = new.bool(mainIni.main.diolog) -- создём буффер для чекбокса, который возвращает true/false
local chat_id = new.char[256](u8(mainIni.main.chat_id)) -- создаём буффер для инпута
local token = new.char[256](u8(mainIni.main.token)) -- создаём буффер для инпута
---Telegram---

--color--


--color--

imgui.OnFrame(function() return WinState[0] end, function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(500, 500), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(370, 320), imgui.Cond.Always)
    imgui.Begin(u8'Залупа Helper от '..thisScript().version, WinState, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
    for numberTab,nameTab in pairs({'Main','Chests','Auto','Не заходить','Telegram'}) do -- создаём и парсим таблицу с названиями будущих вкладок
        if imgui.Button(u8(nameTab), imgui.ImVec2(80,43)) then -- 2ым аргументом настраивается размер кнопок (подробнее в гайде по мимгуи)
            tab = numberTab -- меняем значение переменной tab на номер нажатой кнопки
        end
    end
    imgui.SetCursorPos(imgui.ImVec2(95, 28)) -- [Для декора] Устанавливаем позицию для чайлда ниже
    if imgui.BeginChild('Name##'..tab, imgui.ImVec2(265, 280), true) then -- [Для декора] Создаём чайлд в который поместим содержимое
        
        --- 1 страница ебать ---
		if tab == 1 then
        imgui.Checkbox(u8'Рендер лавок', lavka)
		imgui.SameLine()
        imgui.TextQuestion(u8("Спалят будут БАН нахуй"))
        imgui.Checkbox(u8'Радиус между переносными лавками', radiuslavki)
		imgui.Checkbox(u8'Удаление Игроков и ТС', clean)
        if imgui.Checkbox(u8'Авто-Удаление', autoclean) then
            mainIni.main.autoclean = autoclean[0] 
		    inicfg.save(mainIni, "MiniHelper-CR")
        end
		imgui.Separator()	
		if imgui.Checkbox(u8'Авто-Еда', autoeat) then
		mainIni.main.autoeat = autoeat[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
		imgui.SameLine()
        imgui.TextQuestion(u8("Спалят будут БАН нахуй"))
		imgui.PushItemWidth(190)
		if imgui.SliderInt(u8'Минуты.', SliderOne, 1, 60) then -- 3 аргументом является минимальное значение, а 4 аргумент задаёт максимальное значение
		mainIni.main.autoeatmin = SliderOne[0]
		inicfg.save(mainIni, "MiniHelper-CR")
		end
		imgui.PopItemWidth()
		if imgui.Combo(u8'##',ComboTest,ImItems, #item_list) then
		 mainIni.main.ComboTest = ComboTest[0]
		 inicfg.save(mainIni, "MiniHelper-CR")
		end

  
		--- 1 страница ебать ---	
		
		
		


        --- 2 страница ебать ---
		elseif tab == 2 then
		if imgui.Checkbox(u8'Сундук рулетки', checkbox_standart) then
		mainIni.main.standart = checkbox_standart[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
        end
		if imgui.Checkbox(u8'Сундук платиновой рулетки', checkbox_platina) then
	    mainIni.main.platina = checkbox_platina[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
		if imgui.Checkbox(u8'Сундук рулетки (донат)', checkbox_donate) then
		mainIni.main.donate = checkbox_donate[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
		if imgui.Checkbox(u8'Тайник Илона Маска', checkbox_mask) then
        mainIni.main.mask = checkbox_mask[0] 
	    inicfg.save(mainIni, "MiniHelper-CR")
        end	
		if imgui.Checkbox(u8'Тайник Лос Сантоса', checkbox_tainik) then
	    mainIni.main.tainik = checkbox_tainik[0] 
	    inicfg.save(mainIni, "MiniHelper-CR")
	    end 	
		if imgui.Checkbox(u8'Тайник Vice City', checkbox_vice) then
	    mainIni.main.vice = checkbox_vice[0] 
	    inicfg.save(mainIni, "MiniHelper-CR")
        end 
        
        if imgui.Checkbox(u8'Запустить Авто-Открытие###777', workbotton) then
            work = true
       
        end
        imgui.Separator()
        imgui.Text(u8'Запустить через:')
        imgui.SameLine()
        imgui.PushItemWidth(30)
        imgui.InputText(u8"мин##15689", timechestto, 256, imgui.InputTextFlags.CharsDecimal)
        imgui.PopItemWidth()
        if imgui.Checkbox(u8'Отложенный Запуск', delayedtimer) then

        end
        --- 2 страница ебать ---
		
	
	    --- 3 страница ебать ---
		elseif tab == 3 then
        imgui.Checkbox(u8'Авто нажатие 1 кнопки', autokey1)
		imgui.SliderInt(u8'задерж в мс', timekey1, 5, 100) -- 3 аргументом является минимальное значение, а 4 аргумент задаёт максимальное значение
        imgui.InputTextWithHint(u8'HEX код', u8'Введите HEX код клавиши', buttonkey1, 256)
		imgui.Separator()
		 imgui.Checkbox(u8'Авто нажатие 2 кнопок###auto1', autokey2)
		imgui.SliderInt(u8'задерж в мс###auto2', timekey2, 5, 100) -- 3 аргументом является минимальное значение, а 4 аргумент задаёт максимальное значение
        imgui.InputTextWithHint(u8'HEX код###auto3', u8'Введите HEX код клавиши', buttonkey2, 256)
		imgui.SliderInt(u8'задерж в мс###auto4', timekey3, 5, 100) -- 3 аргументом является минимальное значение, а 4 аргумент задаёт максимальное значение
        imgui.InputTextWithHint(u8'HEX код###auto5', u8'Введите HEX код клавиши', buttonkey3, 256)
		imgui.Separator()
		if imgui.Button(u8'СПИСОК КОДОВ КЛАВИШ', imgui.ImVec2(210, 25) ) then -- размер указал потомучто так привычней
       os.execute("start https://narvell.nl/keys")
	   end
        --- 3 страница ебать ---
		
		
		--- 4 страница ебать ---
        elseif tab == 4 then 
            if imgui.ColoredButton(u8'Не нажимать', 'F94242', 70,imgui.ImVec2(200,50)) then
            sampAddChatMessage('{FF0000}ДОЛБАЁБ ГОВОРЮ ЖЕ НЕ НАЖИМАЙ', -1)
            sampAddChatMessage('{FF0000}ДОЛБАЁБ ГОВОРЮ ЖЕ НЕ НАЖИМАЙ', -1)
            sampAddChatMessage('{FF0000}ДОЛБАЁБ ГОВОРЮ ЖЕ НЕ НАЖИМАЙ', -1)
            sampAddChatMessage('{FF0000}ДОЛБАЁБ ГОВОРЮ ЖЕ НЕ НАЖИМАЙ', -1)
            sampAddChatMessage('{FF0000}ДОЛБАЁБ ГОВОРЮ ЖЕ НЕ НАЖИМАЙ', -1)
            sampAddChatMessage('{FF0000}ДОЛБАЁБ ГОВОРЮ ЖЕ НЕ НАЖИМАЙ', -1)
            sampAddChatMessage('{FF0000}ДОЛБАЁБ ГОВОРЮ ЖЕ НЕ НАЖИМАЙ', -1)
            sampAddChatMessage('{FF0000}ДОЛБАЁБ ГОВОРЮ ЖЕ НЕ НАЖИМАЙ', -1)
            sampAddChatMessage('{FF0000}ДОЛБАЁБ ГОВОРЮ ЖЕ НЕ НАЖИМАЙ', -1)
            sampAddChatMessage('{FF0000}ДОЛБАЁБ ГОВОРЮ ЖЕ НЕ НАЖИМАЙ', -1)
            sampAddChatMessage('{FF0000}ДОЛБАЁБ ГОВОРЮ ЖЕ НЕ НАЖИМАЙ', -1)
            sampAddChatMessage('{FF0000}ДОЛБАЁБ ГОВОРЮ ЖЕ НЕ НАЖИМАЙ', -1)
            sampAddChatMessage('{FF0000}ДОЛБАЁБ ГОВОРЮ ЖЕ НЕ НАЖИМАЙ', -1)
            end
        --- 4 страница ебать ---
		

	    --- 5 страница ебать ---
	    elseif tab == 5 then
        if imgui.Checkbox(u8'Принимать команды из TG', cmd) then
		mainIni.main.cmd = cmd[0] 
		inicfg.save(mainIni, "MiniHelper-CR")
	    end
        if imgui.Checkbox(u8'Отправлять диалоги в TG', diolog) then
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
		if imgui.Button(u8'Тестовое сообщение') then
        sendTelegramNotification('Тестовое сообщение от '..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))) -- отправляем сообщение юзеру
	    end
        imgui.Text(u8'/help -- Список команд.')
		imgui.Text(u8'/stats -- Статистика аккаунта.')
        imgui.Text(u8'/pcoff -- Выключение Пк.')
        imgui.Text(u8'/rec -- Перезайти на сервер.')
        imgui.Text(u8'/status -- Статус сервера.')
        imgui.Text(u8'/send -- Написать сообщение в чат.')
        imgui.Text(u8'/dell -- Удаление Игроков и Тс ВКЛ.')
        imgui.Text(u8'/offdell -- Удаление Игроков и Тс ВЫКЛ.')
        imgui.Text(u8'/chest -- Авто открытие Сундуков.')
        imgui.Text(u8'/reload -- Перезапустить Скрипт.')
		end
        --- 5 страница ебать ---

        
        imgui.EndChild()
		imgui.SetCursorPos(imgui.ImVec2(5, 270))
		if imgui.Button(('Reload'), imgui.ImVec2(80,44)) then
        sampAddChatMessage('Скрипт перезагружается', 0xFF0000)
	    thisScript():reload()
        end
        end
        imgui.End()
        end)




---ебать эта хуйня с авто обновлением---

-- https://github.com/ass138/cr-helper-arz/tree/main
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('Загружено %d из %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('Загрузка обновления завершена.')sampAddChatMessage(b..'Обновление завершено!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'Обновление прошло неудачно. Запускаю устаревшую версию..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': Обновление не требуется.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, выходим из ожидания проверки обновления. Смиритесь или проверьте самостоятельно на '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/ass138/cr-helper-arz/main/version.json?" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://github.com/ass138/cr-helper-arz/tree/main"
        end
    end
end
---ебать эта хуйня с авто обновлением---

function main()
    while not isSampAvailable() do wait(100) end -- ждём когда загрузится самп
	wait(500)
	sampAddChatMessage('• {00FF00}[Залупа-Helper]{FFFFFF} Активация: {7FFF00}F2{FFFFFF} •', -1)
	getLastUpdate() -- вызываем функцию получения последнего ID сообщения
    	          if autoupdate_loaded and enable_autoupdate and Update then
        pcall(Update.check, Update.json_url, Update.prefix, Update.url)
    end
		    lua_thread.create(get_telegram_updates) -- создаем нашу функцию получения сообщений от юзера	
			lua_thread.create(lavkirendor)
            lua_thread.create(radiuslavkis)
			lua_thread.create(cleanr)
			lua_thread.create(eat)
			lua_thread.create(autokeys)
			lua_thread.create(crtextdraw)
            lua_thread.create(chestss)
            lua_thread.create(delayedtimers)
        

         

		

			

			
	while true do wait(0)
	  if wasKeyPressed(VK_F2) and not sampIsCursorActive() then -- если нажата клавиша R и не активен самп курсор
            WinState[0] = not WinState[0]  
		
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
            startTimes = os.time() + u8:decode(str(timechestto)) * 60 -- Устанавливаем таймер на 5 минут
            while os.time() < startTimes do
                wait(0)
                local timeRemainings = startTimes - os.time()
                local minutess = math.floor(timeRemainings / 60)
                local secondss = timeRemainings % 60
               
                local timeStrings = string.format("%02d:%02d", minutess, secondss)
                renderFontDrawText(font,'Timer '..timeStrings, 95, 510 + 80, 0xFF00FF00, 0x90000000)
            end
            -- Действия по завершению таймера
            
            -- Здесь могут быть другие действия в зависимости от вашей логики
            workbotton = new.bool(true)
            work = true
            delayedtimer = new.bool(false)
            break -- Выход из цикла после завершения таймера
        end
    end
end


function onReceivePacket(id)
    if id == 32 then
        sendTelegramNotification('CЕРВЕР ЗАКРЫЛ СОЕДИНЕНИЕ')
    end
    if id == 33 then
        sendTelegramNotification('CЕРВЕР ЗАКРЫЛ СОЕДИНЕНИЕ')
    end
end




function radiuslavkis()
	while true do wait(0)
		if radiuslavki[0] then
	        for IDTEXT = 0, 2048 do
	            if sampIs3dTextDefined(IDTEXT) then
	                local text, color, posX, posY, posZ, distance, ignoreWalls, player, vehicle = sampGet3dTextInfoById(IDTEXT)
	                if text ==  "Управления товарами." and not isCentralMarket(posX, posY) then
						local myPos = {getCharCoordinates(1)}
	                    drawCircleIn3d(posX,posY,posZ-1.3,5,36,1.5,	getDistanceBetweenCoords3d(posX,posY,0,myPos[1],myPos[2],0) > 5 and 0xFFFFFFFF or 0xFFFF0000)
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

function crtextdraw()
 while true do
        wait(0)
        sampTextdrawDelete(532)
        sampTextdrawDelete(536)
        sampTextdrawDelete(535)
        sampTextdrawDelete(675)
        sampTextdrawDelete(533)
        sampTextdrawSetPos(534, 112, 313)
        sampTextdrawSetPos(535, 112, 313)
        sampTextdrawSetPos(536, 112, 313)
        sampTextdrawSetPos(537, 112, 313)
        sampTextdrawSetPos(538, 112, 313)
        sampTextdrawSetPos(539, 112, 313)
        sampTextdrawSetPos(540, 112, 313)
        sampTextdrawSetPos(541, 112, 313)
        sampTextdrawSetPos(542, 112, 313)
        sampTextdrawSetPos(543, 112, 313)
        sampTextdrawSetPos(544, 112, 313)
        sampTextdrawSetPos(545, 112, 313)
        sampTextdrawSetPos(546, 112, 313)
        sampTextdrawSetPos(547, 112, 313)
        sampTextdrawSetPos(548, 112, 313)
        sampTextdrawSetPos(549, 112, 313)
        sampTextdrawSetPos(550, 112, 313)
        sampTextdrawSetPos(551, 112, 313)
        sampTextdrawSetPos(552, 112, 313)
        sampTextdrawSetPos(553, 112, 313)
        sampTextdrawSetPos(554, 112, 313)
        sampTextdrawSetPos(555, 112, 313)
        sampTextdrawSetPos(556, 112, 313)
        sampTextdrawSetPos(557, 112, 313)
        sampTextdrawSetPos(558, 112, 313)
        sampTextdrawSetPos(559, 112, 313)
        sampTextdrawSetPos(560, 112, 313)
        sampTextdrawSetPos(561, 112, 313)
        sampTextdrawSetPos(562, 112, 313)
        sampTextdrawSetPos(563, 112, 313)
        sampTextdrawSetPos(564, 112, 313)
        sampTextdrawSetPos(565, 112, 313)
        sampTextdrawSetPos(566, 112, 313)
        sampTextdrawSetPos(567, 112, 313)
        sampTextdrawSetPos(568, 112, 313)
        sampTextdrawSetPos(569, 112, 313)
        sampTextdrawSetPos(570, 112, 313)
        sampTextdrawSetPos(571, 112, 313)
        sampTextdrawSetPos(572, 112, 313)
        sampTextdrawSetPos(573, 112, 313)
        sampTextdrawSetPos(574, 112, 313)
        sampTextdrawSetPos(620, 112, 313)
        
    end    
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
            sampAddChatMessage('[Информация] {FFFFFF}Сейчас откроется инвентарь.', 0xFFFF00)
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
            sampAddChatMessage('[Информация] {FFFFFF}Запушен таймер на 1ч.', 0xFFFF00)
            startTime = os.time() + 60 * 60 -- перезапускаем таймер
            work = false
   
            startTime = os.time() + 60 * 60 -- Устанавливаем таймер на 5 минут
            while os.time() < startTime do
                wait(0)
                local timeRemaining = startTime - os.time()
                local minutes = math.floor(timeRemaining / 60)
                local seconds = timeRemaining % 60
               
                local timeString = string.format("%02d:%02d", minutes, seconds)
                renderFontDrawText(font,'Timer '..timeString, 95, 510 + 80, 0xFFFF1493, 0x90000000)
                
            end
            work = true -- Устанавливаем флаг work в true после завершения таймера
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
           if data.text == 'USE' or data.text == '…CЊO‡’€O‹AЏ’' then 
               textdraw[1][2] = id + 1
               textdraw[2][2] = id + 1
               textdraw[3][2] = id + 1
               textdraw[4][2] = id + 1
               textdraw[5][2] = id + 1
               textdraw[6][2] = id + 1
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
                                renderFontDrawText(font, 'Свободна', lX - 30, lY - 20, 0xFF16C910, 0x90000000)
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
                renderFontDrawText(font, 'Свободно: '..lavki, 95, 510 + 80, 0xFFFF1493, 0x90000000)
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



------------------------------------------------------------------------------------------------------------------------------------------------------------

local updateid -- ID последнего сообщения для того чтобы не было флуда

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






function sendTelegramNotification(msg) -- функция для отправки сообщения юзеру
	msg = msg:gsub('{......}', '') --тут типо убираем цвет
	msg = encodeUrl(msg) -- ну тут мы закодируем строку
	async_http_request('https://api.telegram.org/bot' .. u8:decode(str(token)) .. '/sendMessage?chat_id=' .. u8:decode(str(chat_id)) .. '&text='..msg,'', function(result) end) -- а тут уже отправка
end

function get_telegram_updates() -- функция получения сообщений от юзера
    while not updateid do wait(1) end -- ждем пока не узнаем последний ID
    local runner = requestRunner()
    local reject = function() end
    local args = ''
    while true do
        url = 'https://api.telegram.org/bot'..u8:decode(str(token))..'/getUpdates?chat_id='..u8:decode(str(chat_id))..'&offset=-1' -- создаем ссылку
        threadHandle(runner, url, args, processing_telegram_messages, reject)
        wait(0)
    end
end

function calc(str) --это тестовая функция, её не требуется переносить в ваш код
    return assert(load("return "..str))()
end

function processing_telegram_messages(result) -- функция проверОчки того что отправил чел


        -- тута мы проверяем все ли верно
        local proc_table = decodeJson(result)
        local proc_result, proc_table = pcall(decodeJson, result)
        if proc_result and proc_table and proc_table.ok then
        if proc_table.ok then
            if #proc_table.result > 0 then
                local res_table = proc_table.result[1]
                if res_table then
                    if res_table.update_id ~= updateid then
                        updateid = res_table.update_id
                        local message_from_user = res_table.message.text
						user_idtg = res_table.message.from.id

                         if message_from_user then
                            -- и тут если чел отправил текст мы сверяем
                            local text = u8:decode(message_from_user) .. ' ' --добавляем в конец пробел дабы не произошли тех. шоколадки с командами(типо чтоб !q не считалось как !qq)
                           

                                if text:match('^/stats') then
                                telegrams()
								elseif text:match('^/pcoff') then
								sendTelegramNotification('компьютер будет автоматически выключен')
                                pcoffs()
								elseif text:match('^/rec') then
								sendTelegramNotification('переподключение к серверу 15 сек')
                                rec()
								elseif text:match('^/status') then
								sendStatusTg()
                                elseif text:match('^/send') then
                                local argq = text:gsub('/send ','',1)
                                sampSendChat(argq)


                                elseif text:match('^/diolog') then
                                diolog = new.bool(true)
                                sendTelegramNotification('Диалоги включены')

                                elseif text:match('^/offdiolog') then
                                diolog = new.bool(false)
                                sendTelegramNotification('Диалоги выключены')


                                elseif text:match('^/dell') then
                                clean = new.bool(true)
                                sendTelegramNotification('Удалил игроков и тс ВКЛ')

                                elseif text:match('^/offdell') then
                                clean = new.bool(false)  
                                sendTelegramNotification('Удалил игроков и тс ВЫКЛ')    
                                
                                elseif text:match('^/chest') then
                                    sampSendClickTextdraw(65535)
                                workbotton = new.bool(true)
                                work = true
                                sendTelegramNotification('Авто открытие сундуков ВКЛ')

                                elseif text:match('^/killdiolog') then
                                sampCloseCurrentDialogWithButton(0)
                                wait(200)
                                sampCloseCurrentDialogWithButton(0)
                                sendTelegramNotification('Закрытие всех диологов')
              
                                elseif text:match('^/reload') then
                                    thisScript():reload()
                                sendTelegramNotification('Скрипт перезагружается')

                           
								elseif text:match('^/help') then
								sendTelegramNotification('Команды: /stats -- Статистика аккаунта.  /pcоff -- Выключение Пк.  /reс -- Перезайти на сервер с задержкой 5 сек.  /status -- Статус сервера.  /diolog -- Включить диалоги.  /offdiolog -- Выключить диалоги.  /killdiolog -- Закрытие всех диологов  /send -- Написать сообщение в чат.  /dell -- Удаление Игроков и Тс Вкл.  /offdell -- Удаление Игроков и Тс ВЫКЛ.  /chest -- Запустить Авто открытие Сундуков.  /reload -- Перезапустить Скрипт.')	 
                                else -- если же не найдется ни одна из команд выше, выведем сообщение
                                sendTelegramNotification('Неизвестная команда!')
                           
                            
                        end
                    end
                end
            end
        end
    end
end
end


function getLastUpdate() -- тут мы получаем последний ID сообщения, если же у вас в коде будет настройка токена и chat_id, вызовите эту функцию для того чтоб получить последнее сообщение
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
                    updateid = 1 -- тут зададим значение 1, если таблица будет пустая
                end
            end
        end
    end)
end
	
local bank_check = false
local payday_notification_str = '%E2%9D%97__________Банковский чек__________%E2%9D%97\n'
local function collectAndSendPayDayData(text)
    local ptrs = {
        "Организационная зарплата: %$[%d%.]+",
        "Депозит в банке: %$[%d%.]+",
        "Сумма к выплате: %$[%d%.]+",
        "Текущая сумма в банке: %$[%d%.]+",
        "Текущая сумма на депозите: %$[%d%.]+",
        "Депозит в банке: VC%$[%d%.]+",
        "Сумма к выплате: VC%$[%d%.]+",
        "Текущая сумма в банке: VC%$[%d%.]+",
        "Текущая сумма на депозите: VC%$[%d%.]+"
    }

    local text = text:gsub("{%x+}", "")
    for _, v in ipairs(ptrs) do
        if text:find(v) then
            payday_notification_str = ("%s\n%s"):format(payday_notification_str, text)
        end
    end

    if text:find("В данный момент у вас %d") then
        payday_notification_str = ("%s\n%s"):format(payday_notification_str, text)
        if bank_check then
            sendTelegramNotification(("%s"):format(payday_notification_str)) -- copy string
            payday_notification_str = '%E2%9D%97__________Банковский чек__________%E2%9D%97\n'
        end
        bank_check = false
    end
end


function sampev.onServerMessage(color, text)
    if text:find('Банковский чек') then bank_check = true end
    if bank_check then collectAndSendPayDayData(text) end
    if text:find('{FFFFFF}Вы успешно арендовали лавку для продажи/покупки товара!') then
    sendTelegramNotification('Ебать молодец словил лавку')
    end
    if text:find('^%[Информация%] {FFFFFF}Ваша лавка была закрыта') then
        sendTelegramNotification('Вас выкинули с вашей лавки!')
    end



    if text:find('^%[Информация%] %{ffffff%}Вы использовали сундук с рулетками и получили') and color == 1941201407 then
        local drop_starter_donate = text:match('^%[Информация%] %{ffffff%}Вы использовали сундук с рулетками и получили (.+)!')
        sendTelegramNotification(drop_starter_donate)
    end

    if text:find('^%[Информация%] %{ffffff%}Вы использовали платиновый сундук с рулетками и получили') and color == 1941201407 then
        local drop_platinum = text:match('^%[Информация%] %{ffffff%}Вы использовали платиновый сундук с рулетками и получили (.+)!')
        sendTelegramNotification(drop_platinum)
    end 

    if text:find('^%[Информация%] %{ffffff%}Вы использовали тайник Илона Маска и получили') and color == 1941201407 then
        local drop_elon_musk = text:match('^%[Информация%] %{ffffff%}Вы использовали тайник Илона Маска и получили (.+)!')
        sendTelegramNotification(drop_elon_musk)
    end

    if text:find('^Вы открыли Тайник Лос Сантоса!') or text:find('^Вы открыли Тайник Vice City!') and color == 1118842111 then
	elseif text:find('^%[Информация%] %{ffffff%}Получено: (.+) и (.+)!') and color == 1941201407 then
		local drop_ls_vc_1, drop_ls_vc_2 = text:match('^%[Информация%] %{ffffff%}Получено: (.+) и (.+)!')
        sendTelegramNotification(drop_ls_vc_1)
        sendTelegramNotification(drop_ls_vc_2)
    end





    if text:find('^%[Ошибка%] %{ffffff%}Время после прошлого использования ещё не прошло!') and color == -1104335361 then
        sendTelegramNotification('Время после прошлого использования ещё не прошло!')  
    end

    
    if text:find('^.+ купил у вас .+, вы получили %$%d+ от продажи %(комиссия %d процент%(а%)%)') then
        local name, product, money = text:match('^(.+) купил у вас (.+), вы получили %$([%d.,]+) от продажи %(комиссия %d процент%(а%)%)')
        local reg_text = 'Вы продали: "'..product..'" за '..money..'$ Игроку: '..name..'.'
            sendTelegramNotification(reg_text)
        end
    if text:find('^.+ купил у вас .+, вы получили VC%$%d+ от продажи %(комиссия %d процент%(а%)%)') then
        local name, product, money = text:match('^(.+) купил у вас (.+), вы получили VC%$([%d.,]+) от продажи %(комиссия %d процент%(а%)%)')
        local reg_text = 'Вы продали: "'..product..'" за '..money..'VC$ Игроку: '..name..'.'
            sendTelegramNotification(reg_text)
        end    
    if text:find('^Вы купили .+ у игрока .+ за %$%d+') then
        local product, name, money = text:match('^Вы купили (.+) у игрока (.+) за %$([%d.,]+)')
        local reg_text = 'Вы купили: "'..product..'" за '..money..'$ У игрока: '..name..'.'
        sendTelegramNotification(reg_text)
    end
    if text:find('^Вы купили .+ у игрока .+ за VC%$%d+') then
        local product, name, money = text:match('^Вы купили (.+) у игрока (.+) за VC%$([%d.,]+)')
        local reg_text = 'Вы купили: "'..product..'" за '..money..'VC$ У игрока: '..name..'.'
        sendTelegramNotification(reg_text)
    end
    if text:find('{FFFFFF}У вас есть 3 минуты, чтобы настроить товар, иначе аренда ларька будет отменена.') then
        lavka = new.bool(false) 
        if autoclean[0] then
            clean = new.bool(true)
            radiuslavki = new.bool(false)
    end    
end
end
---[Информация] {ffffff}Вы использовали сундук с рулетками и получили платиновую рулетку!

function telegrams()
if cmd[0] then
sampSendChat('/stats')
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



------------------------------------------------------------------------------------------------------------------------------------------------------------
local sampev = require 'lib.samp.events'

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
if text:find('Удача!') then 
		sampSendDialogResponse(id, 0, _, _)
		return false
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