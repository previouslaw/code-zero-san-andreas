Config = {}

Config.MaxMessageLength = 180
Config.CooldownSeconds = 45
Config.BlipDurationMs = 120000
Config.BlipRadius = 90.0

Config.Calls = {
    ['911'] = {
        label = 'Emergency',
        jobs = { 'police', 'ambulance' },
        color = 1,
        sprite = 280,
    },
    ['311'] = {
        label = 'City Services',
        jobs = { 'mechanic', 'tow' },
        color = 3,
        sprite = 280,
    },
}
