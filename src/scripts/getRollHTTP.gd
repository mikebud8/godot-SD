extends HTTPRequest


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var rollButton: Button = get_parent().get_node("RollButton")

var httpAddress := "http://192.168.1.20:8080/"
var id := "1729768827276083868"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_use_threads(true)
	rollButton.connect("pressed",self, "requestRoll")
	self.connect("request_completed", self, "setLabelFromResponse")
	print("HTTP Request initialized")
	pass

func requestRoll() -> void:
	self.request( httpAddress + "testGame?id=" + id )
	pass # Replace with function body.
	
func newGame() -> void:
	self.request( httpAddress + "newGame")

func setLabelFromResponse(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	var data = body.get_string_from_utf8()
	var p = JSON.parse(data)
	
	print(data)
	get_parent().get_node("Label").text = str(p.result["homeTeam"]["scoreSheet"].scoresheet[0])
	
	get_parent().get_node("Scoreboard/HomeScore/InningOne").text = str(p.result["homeTeam"]["scoreSheet"].scoresheet[0])
	get_parent().get_node("Scoreboard/HomeScore/InningTwo").text = str(p.result["homeTeam"]["scoreSheet"].scoresheet[1])
	get_parent().get_node("Scoreboard/HomeScore/InningThree").text = str(p.result["homeTeam"]["scoreSheet"].scoresheet[2])
	get_parent().get_node("Scoreboard/HomeScore/InningFour").text = str(p.result["homeTeam"]["scoreSheet"].scoresheet[3])
	get_parent().get_node("Scoreboard/HomeScore/InningFive").text = str(p.result["homeTeam"]["scoreSheet"].scoresheet[4])
	get_parent().get_node("Scoreboard/HomeScore/InningSix").text = str(p.result["homeTeam"]["scoreSheet"].scoresheet[5])
	get_parent().get_node("Scoreboard/HomeScore/InningSeven").text = str(p.result["homeTeam"]["scoreSheet"].scoresheet[6])
	get_parent().get_node("Scoreboard/HomeScore/InningEight").text = str(p.result["homeTeam"]["scoreSheet"].scoresheet[7])
	get_parent().get_node("Scoreboard/HomeScore/InningNine").text = str(p.result["homeTeam"]["scoreSheet"].scoresheet[8])
	
	get_parent().get_node("Scoreboard/HomeScore/Runs").text = str(p.result["homeTeam"]["ts"].runs)
	get_parent().get_node("Scoreboard/HomeScore/Hits").text = str(p.result["homeTeam"]["ts"].hits)
	get_parent().get_node("Scoreboard/HomeScore/Errors").text = str(p.result["homeTeam"]["ts"].errors)
	
	get_parent().get_node("Scoreboard/AwayScore/InningOne").text = str(p.result["awayTeam"]["scoreSheet"].scoresheet[0])
	get_parent().get_node("Scoreboard/AwayScore/InningTwo").text = str(p.result["awayTeam"]["scoreSheet"].scoresheet[1])
	get_parent().get_node("Scoreboard/AwayScore/InningThree").text = str(p.result["awayTeam"]["scoreSheet"].scoresheet[2])
	get_parent().get_node("Scoreboard/AwayScore/InningFour").text = str(p.result["awayTeam"]["scoreSheet"].scoresheet[3])
	get_parent().get_node("Scoreboard/AwayScore/InningFive").text = str(p.result["awayTeam"]["scoreSheet"].scoresheet[4])
	get_parent().get_node("Scoreboard/AwayScore/InningSix").text = str(p.result["awayTeam"]["scoreSheet"].scoresheet[5])
	get_parent().get_node("Scoreboard/AwayScore/InningSeven").text = str(p.result["awayTeam"]["scoreSheet"].scoresheet[6])
	get_parent().get_node("Scoreboard/AwayScore/InningEight").text = str(p.result["awayTeam"]["scoreSheet"].scoresheet[7])
	get_parent().get_node("Scoreboard/AwayScore/InningNine").text = str(p.result["awayTeam"]["scoreSheet"].scoresheet[8])

	get_parent().get_node("Scoreboard/AwayScore/Runs").text = str(p.result["awayTeam"]["ts"].runs)
	get_parent().get_node("Scoreboard/AwayScore/Hits").text = str(p.result["awayTeam"]["ts"].hits)
	get_parent().get_node("Scoreboard/AwayScore/Errors").text = str(p.result["awayTeam"]["ts"].errors)
	
	var inningIdx : int = p.result["inning"].inningIdx
	
	if( inningIdx > 8 ):
		get_parent().get_node("Scoreboard/BoardLabels/InningExtra").text = str(inningIdx + 1)
		get_parent().get_node("Scoreboard/AwayScore/InningExtra").text = str(p.result["awayTeam"]["scoreSheet"].scoresheet[inningIdx])
		get_parent().get_node("Scoreboard/HomeScore/InningExtra").text = str(p.result["homeTeam"]["scoreSheet"].scoresheet[inningIdx])
	
	get_parent().get_node("PitcherCard/PCContainer/PlayerName").text = p.result["currentPitcher"].name
	get_parent().get_node("PitcherCard/PCContainer/PlayerInfo/Attributes/PitcherType").text = p.result["currentPitcher"]["positionsArray"][0].position
	get_parent().get_node("PitcherCard/PCContainer/PlayerInfo/Attributes/AttrDivider/AttrValues/onBase").text = str(p.result["currentPitcher"].onBaseControl)
	get_parent().get_node("PitcherCard/PCContainer/PlayerInfo/Attributes/AttrDivider/AttrValues/innings").text = str(p.result["currentPitcher"].speedInnings)
	get_parent().get_node("PitcherCard/PCContainer/PlayerInfo/Attributes/AttrDivider/AttrValues/cost").text = str(p.result["currentPitcher"].cost)

	var pRollStat =  JSON.parse(p.result["currentPitcher"]["formattedRollTableString"])
	
	get_parent().get_node("PitcherCard/PCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/poRange").text = pRollStat.result["PO"]
	get_parent().get_node("PitcherCard/PCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/soRange").text = pRollStat.result["SO"]
	get_parent().get_node("PitcherCard/PCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/gbRange").text = pRollStat.result["GB"]
	get_parent().get_node("PitcherCard/PCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/fbRange").text = pRollStat.result["FB"]
	get_parent().get_node("PitcherCard/PCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/walkRange").text = pRollStat.result["W"]
	get_parent().get_node("PitcherCard/PCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/singleRange").text = pRollStat.result["S"]
	get_parent().get_node("PitcherCard/PCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/doubleRange").text = pRollStat.result["D"]
	get_parent().get_node("PitcherCard/PCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/dingerRange").text = pRollStat.result["HR"]
	
	get_parent().get_node("BatterCard/BCContainer/PlayerName").text = p.result["currentBatter"].name
	get_parent().get_node("BatterCard/BCContainer/PlayerInfo/Attributes/AttrDivider/AttrValues/onBase").text = str(p.result["currentBatter"].onBaseControl)
	get_parent().get_node("BatterCard/BCContainer/PlayerInfo/Attributes/AttrDivider/AttrValues/speed").text = str(p.result["currentBatter"].speedInnings)
	get_parent().get_node("BatterCard/BCContainer/PlayerInfo/Attributes/AttrDivider/AttrValues/cost").text = str(p.result["currentBatter"].cost)
	
	var bRollStat =  JSON.parse(p.result["currentBatter"]["formattedRollTableString"])
	
	get_parent().get_node("BatterCard/BCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/soRange").text = bRollStat.result["SO"]
	get_parent().get_node("BatterCard/BCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/gbRange").text = bRollStat.result["GB"]
	get_parent().get_node("BatterCard/BCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/fbRange").text = bRollStat.result["FB"]
	get_parent().get_node("BatterCard/BCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/walkRange").text = bRollStat.result["W"]
	get_parent().get_node("BatterCard/BCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/singleRange").text = bRollStat.result["S"]
	get_parent().get_node("BatterCard/BCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/sPlusRange").text = bRollStat.result["S+"]
	get_parent().get_node("BatterCard/BCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/doubleRange").text = bRollStat.result["D"]
	get_parent().get_node("BatterCard/BCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/tripleRange").text = bRollStat.result["T"]
	get_parent().get_node("BatterCard/BCContainer/PlayerInfo/RollTable/RollTableDivider/RollTableRanges/dingerRange").text = bRollStat.result["HR"]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
