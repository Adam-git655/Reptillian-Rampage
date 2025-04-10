extends CanvasLayer

func _ready() -> void:
	$WaveLabel.show()
	$WaveLabel.text = ("Wave " + str(Main.wave))
	$WaveLabelShowTimer.start()
	Main.connect("new_wave", _on_new_wave)
	$Panel.show()
	$DownButton.show()
	$UpButton.hide()
	
func _on_down_button_pressed() -> void:
	$Panel.hide()
	$DownButton.hide()
	$UpButton.show()

func _on_up_button_pressed() -> void:
	$Panel.show()
	$DownButton.show()
	$UpButton.hide()

func _process(delta: float) -> void:
	$ScalesLabel.text = ("Scales: " + str(Main.scales))
	$HealthLabel.text = ("Lair Health: " + str(Main.lair_health))
	

func _on_new_wave():
	$WaveLabel.show()
	if Main.wave == 5:
		$WaveLabel.text = ("Final Wave")
	else:
		$WaveLabel.text = ("Wave " + str(Main.wave))
	$WaveLabelShowTimer.start()


func _on_wave_label_show_timer_timeout() -> void:
	$WaveLabel.hide()
