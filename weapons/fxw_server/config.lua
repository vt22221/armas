fxwConfig = {
    discord_webhook = "https://discord.com/api/webhooks/SEU_WEBHOOK_AQUI",
    ui = {
        accent = tocolor(60,180,255,255),
        bg = tocolor(15,18,25,242),
        border = tocolor(0,0,0,210),
        font = "default-bold",
        radius = 20,
        shadow = tocolor(0,0,0,160)
    },
    economy = {
        starting_balance = 50000,
        coin_name = "Coins",
        vip_name = "VIPCoins",
        vip_color = tocolor(255,215,0),
        xp_per_kill = 40,
        xp_per_case = 100,
        prestige_cost = 10000
    },
    lootboxes = {
        ["premium"] = {
            price_game = 120000,
            price_vip = 25,
            rewards = {"neon", "inferno", "gelo", "ouro", "grip", "scope", "lanterna"},
            color = {220,0,255}
        },
        ["event"] = {
            price_game = 250000,
            price_vip = 50,
            rewards = {"badge_event", "rainbow", "dragon", "exclusive_sound", "mira_holo"},
            color = {255,150,0}
        }
    },
    marketplace = {
        fee_percent = 10,
        min_price = 5000,
        allow_auction = true
    },
    battlepass = {
        active = true,
        xp_per_action = 50,
        season_name = "Forja Suprema",
        season_end = "2025-08-31"
    },
    tickets = {
        active = true
    },
    permissions = {
        admin_acl = "Admin",
        add_vip_acl = "Admin"
    }
}
function fxwGetConfig() return fxwConfig end