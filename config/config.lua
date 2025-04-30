Config = {}

Config.Locales = {
    Brigade = "Brigada",
    BusReady = "Autobus bol pripravený.",
    SpawnFull = "Spawn point nieje volny",
    BusStop = "Autobusová zastávka",
    Wait = "Čakáj na ludi",
    Complete = "Hotovo! Vráť sa na základňu pre výplatu",
    NextStop = "Choď na ďalšiu zastávkuS",
    StartWork = "Zacat robotu",
    AlredyWorking = "Už pracuješ",
    StartedWorking = "Začal si pracovať",
    StopWorking = "Prestat pracovat",
    NotWorking = "Momentálne nepracuješ",
    WorkEnded = "Práca ukončená.",
    NoIncome = "Nemas co ziskat",
    Income = "Ziskal si income",
    CollectIncome = "Collect Income",
    GuideBook = "Guide Book",
    Status = "Status",
    GuideBookContent = "A car will be spawned here and you will be able to drive to selected waypoint, once you complete all stops you will be notified and you can return to base",
}

Config.Stops = {
    vector3(796.905518, -1043.775878, 26.600708),
    vector3(788.070312, -896.782410, 25.033692),
    vector3(787.925292, -652.430786, 28.706910), -- add many more stops here
}

Config.CarSpawn = vector4(425.591218, -618.896728, 28.487916, 99.212594)

Config.PedCoords = vector3(436.470336, -640.338440, 27.723754)

Config.MoneyPerStop = math.random(30,50) -- set amount money per stop

Config.UseBlip = true -- set to true if you want to use blip on map
Config.Blip = "Brigade Bus" -- name of blip
