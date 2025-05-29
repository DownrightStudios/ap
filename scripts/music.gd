extends Node

func _ready() -> void :
    Global.player_death.connect(player_death)
    Global.player_win.connect(player_win)
    Global.player_land.connect(player_land)

    Global.pickup_coin.connect(coin)

func coin():
    $CoinSound.play()

func player_death():
    $DeathSound.play()

func player_win():
    $WinSound.play()

func player_land():
    $LandSound.play()
