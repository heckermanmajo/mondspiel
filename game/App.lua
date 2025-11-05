--- @class App Singleton containing the whole Application state
App = {
    resources = {},
    MODES = {
        MENU = "menu",
        CAMP = "camp",
        SCENARIO = "scenario",
        BATTLE = "battle",
    },

    -- we initialize all menus at once for simplicity, then we select the current one
    -- has the nice side effect that we can keep state in menus when switching between them
    MENUS = {
        INTRO = IntroMenu.new(),
        MAIN = MainMenu.new(),
        LOAD_BATTLE = LoadBattleMenu.new(),
        LOAD_SCENARIO = LoadScenarioMenu.new(),
        LOAD_CAMP = LoadCampMenu.new(),
        START_CAMP = StartCampMenu.new(),
        START_SCENARIO = StartScenarioMenu.new(),
        START_BATTLE = StartBattleMenu.new(),
        APP_SETTINGS = AppSettingsMenu.new(),
    },
    current_mode = nil,
    current_menu = nil,
    current_camp = nil,
    current_scenario = nil,
    current_battle = nil,
}

App.resources = {
    images = {},
    sounds = {},
    fonts = {},
}