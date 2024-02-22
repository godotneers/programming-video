class_name SayStep
extends RobotStep

var _text: String

func setup(text: String) -> SayStep:
	_text = text 
	return self


func play():
	await _owner._speech_bubble.say(_text)	

	
func describe() -> String:
	return "Say: " + _text
