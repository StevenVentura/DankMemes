--[[
World of Warcraft Addon "DankMemes" by Steven M. Ventura
First uploaded to www.curse.com on 10/11/2015
Enjoy!
]]--

local DankMemes_eventFrame = CreateFrame("Frame")
DankMemes_eventFrame:RegisterEvent("VARIABLES_LOADED")	--to get my update control loop functioning
DankMemes_eventFrame:SetScript("OnEvent",function(self,event,...) self[event](self,event,...);end)

function DankMemes_eventFrame:VARIABLES_LOADED()
DankMemes_eventFrame:SetScript("OnUpdate", function(self, elapsed) DankMemes_OnUpdate(self, elapsed) end)
end

SLASH_DankMemes1 = "/DankMemes";SLASH_DankMemes2 = "/Dank";
SlashCmdList["DankMemes"] = function(c)
InterfaceOptionsFrame_OpenToCategory(DankOptionsPanel);
end--end function slashcommand

--settings placeholder
local enableHitmarker=1; enablePepe=1; enableAOLintro=0;
enableMail=1; enableSanic=1; enableRoundWinningKill = 1;
enableShekelsBurst = 1;
--internal variables below
local tHitMarker = 0;hitMarkerEnabled = false;hitMarkerImage = nil;
local showCryingPepe = false; tPepe = 0;pepeSize = 5;cryingPepeImage = nil;
local showShekelsBurst = false; tShekels = 0; shekelsImage = nil;
local showSanic = false; sanicX = 0; sanicY = 0;sanicImage = nil;
local showAOL = false; AOLX = 0; AOLY = 0; AOLImage = nil;
local tConfirmed = 0; showConfirmed = false; confirmedX = 0; confirmedY = 0; confirmedImage = nil;
local tRWK = 0; showRWK = false; RWKImageTop = nil; RWKImageBottom = nil;
local playerMounted = nil;
--temp testing variables below


--DankOptionsPanel is a variable that is used in CreateOptions and AddDankOption.
DankOptionsPanel = CreateFrame("Frame","DankOptionsPanel",UIParent);
--[[
This function adds a checkbox to the options panel,
and also integrates it with the rest of the program.

]]
-->							sorted by dankness
local currentOptionsRows = {-1, -1, -1, -1, -1};
--dankFrameRowHandles is here for reverse setting the button frames and test values.
dankFrameRowHandles = {};
for iii = 1,5 do
dankFrameRowHandles[iii] = {}
end--end for
function AddDankOption(name,label,desc,dankness)
currentOptionsRows[dankness] = currentOptionsRows[dankness] + 1;
option_temp = CreateFrame("CheckButton",name,DankOptionsPanel,"OptionsCheckButtonTemplate");
dankFrameRowHandles[dankness][currentOptionsRows[dankness]+1] = option_temp;
option_temp.name = name;--for reverse lookup
_G[option_temp:GetName() .. "Text"]:SetText(label);
option_temp:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(desc);
end);
option_temp:SetPoint("TOPLEFT",20+120*(dankness-1),currentOptionsRows[dankness]*(-20)-20);
option_temp.setFunc = function(value) 
DankOptions[name] = value == "1"
end

--now load saved options
option_temp:SetChecked(DankOptions[name]);


end--end function AddDankOption

function CreateOptions()
--this is also where i load the saved options.

--if the options doesnt exist in saved variables, then make new options.
if (not DankOptions) then 
DankOptions = {["option_pepeDeath"] = true,
			   ["option_haloMultikill"] = true,
			   ["option_marioJump"] = true,
			   ["option_youveGotMail"] = true,
			   ["option_spartanLaser"] = true,
			   ["option_flare"] = true,
			   ["option_hitmarker"] = true,
			   ["option_pokemonCombat"] = true,
			   ["option_playerKillIntervention"] = true,
			   ["option_NPCKillIntervention"] = true
			   };
end--end if not dankoptions

--create panel to be placed into blizzard options UI 

--label
DankOptionsPanel.name = "Dank Memes /dank";


--create the options interface screen for DankMemes
AddDankOption("option_pepeDeath","Sad Pepe","Show crying Pepe when you die",1);
AddDankOption("option_haloMultikill","Halo Medals", "Show Halo Multikill medals when you kill players",2);
AddDankOption("option_marioJump","Mario Jump","Play SNES Mario jump soundfile when you jump",5);
AddDankOption("option_youveGotMail","Got Mail","Play AOL-themed 'Youve Got Mail' when loading finishes",5);
AddDankOption("option_spartanLaser","ChiknLazr","Player Halo3 spartan laser sound for laserchicken class",4);
AddDankOption("option_flare","UAV Flare", "Hunter Flare: Heads up! Enemy UAV Spo'tted!", 2);
AddDankOption("option_hitmarker","Hit Marker", "Show COD hitmarkers/sound when you deal damage",4);
AddDankOption("option_pokemonCombat","PokeBattle", "Play Pokemon intro song when you enter combat",5);
AddDankOption("option_playerKillIntervention","xXQuickScopeXx","Show quickscope animation and play sound when you land killing blow on a player",3);
AddDankOption("option_NPCKillIntervention","DANK SCOPED","Show quickscope animation on all kills, regardless of NPC or Player unit.",5);
--create the slider
CreateFrame("Slider","dankness_slider",DankOptionsPanel);
dankness_slider:SetPoint("BOTTOM",0,80);
dankness_slider:SetWidth(600)
dankness_slider:SetHeight(50)
dankness_slider:SetOrientation("HORIZONTAL")
dankness_slider:SetThumbTexture('Interface/AddOns/DankMemes/images/WeedLeafSlider.tga');--"Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
dankness_slider:SetMinMaxValues(1,5)
local xvalue = 3;
dankness_slider:SetValue(xvalue); lastSliderDankValue = xvalue;
dankness_slider:SetBackdrop({
  bgFile = "Interface\\Buttons\\UI-SliderBar-Background", 
  edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
  tile = true, tileSize = 8, edgeSize = 8, 
  insets = { left = 3, right = 3, top = 6, bottom = 6 }})

dankness_slider:SetValueStep(1)

--put the label on the slider -- its from www.cooltext.com LOL
coolText = CreateFrame('Frame',"coolText", DankOptionsPanel);
coolText:SetPoint("CENTER", 0, -375);
coolText:SetFrameStrata("HIGH");
coolText:SetSize(600,600);
coolTextObj = coolText:CreateTexture();
coolTextObj:SetAllPoints();
coolTextObj:SetAlpha(1);
coolTextObj:SetTexture('Interface/AddOns/DankMemes/images/CoolText.tga');
coolText:Show();



--add this options panel to the UI.
InterfaceOptions_AddCategory(DankOptionsPanel);
InterfaceAddOnsList_Update();

end--end function CreateOptions

function manageAboutToDie(elapsed)
--when the player is about to die, play a sound clip "ITS JUST A PRANK!! ITS JUST A PRANK!!"
--maybe play a sound clip of sodapoppin screaming, or that one sex video man moaning/screaming sound clip


end--end function manageAboutToDie
function manageShekelsBurst(elapsed)
--if the shekels timer > 0 then show the shekels image 

end

function LoadImageFrames()

cryingPepeImage = CreateFrame('Frame','cryingPepeImage', UIParent);
cryingPepeImage:SetPoint('CENTER',0,0);
cryingPepeImage:SetFrameStrata("HIGH");
cryingPepeImageObj = cryingPepeImage:CreateTexture();
cryingPepeImageObj:SetAllPoints();
cryingPepeImageObj:SetAlpha(1);
cryingPepeImageObj:SetTexture('Interface/AddOns/DankMemes/images/Crying_Pepe.tga');
--
dankSnoopImage = CreateFrame('Frame','dankSnoopImage', DankOptionsPanel);
dankSnoopImage:SetPoint('CENTER', 80,-240);
dankSnoopImage:SetFrameStrata("HIGH");
dankSnoopImage:SetSize(120,120);
dankSnoopImageObj = dankSnoopImage:CreateTexture();
dankSnoopImageObj:SetAllPoints();
dankSnoopImageObj:SetAlpha(1);
dankSnoopImageObj:SetTexture('Interface/AddOns/DankMemes/images/snoop1.tga');
dankSnoopImage:Show();

dankSnoopImage2 = CreateFrame('Frame','dankSnoopImage2', DankOptionsPanel);
dankSnoopImage2:SetPoint('CENTER', -80,-240);
dankSnoopImage2:SetFrameStrata("HIGH");
dankSnoopImage2:SetSize(120,120);
dankSnoopImageObj2 = dankSnoopImage2:CreateTexture();
dankSnoopImageObj2:SetAllPoints();
dankSnoopImageObj2:SetAlpha(1);
dankSnoopImageObj2:SetTexture('Interface/AddOns/DankMemes/images/snoop1.tga');
dankSnoopImage2:Show();


dankSnoopImage.rotation = 1;
dankSnoopImage.rotationDirection = 1;
dankSnoopImage.ROTATION_MAX = 8;
dankSnoopImage.timer = 0;
dankSnoopImage.TIMER_MAX = (dankness_slider:GetValue() / 5) * 250 / 500 / 2;
----
--intervention now
interventionImage = CreateFrame('Frame','interventionImage', UIParent);
interventionImage:SetPoint('CENTER', 0, 0);
interventionImage:SetFrameStrata("HIGH");
interventionImage:SetSize(512, 512);
interventionImageObj = interventionImage:CreateTexture();
interventionImageObj:SetAllPoints();
interventionImageObj:SetAlpha(1);
interventionImageObj:SetTexture('Interface/AddOns/DankMemes/images/int_1.tga');

interventionImage.rotation = 1;
interventionImage.rotationDirection = 1;
interventionImage.ROTATION_MAX = 4;
interventionImage.timer = 0;
interventionImage.TIMER_MAX = 0.25;


end--end function LoadImageFrames
function ManagePlayerJustMounted()
print("mounted up!!");
end--end function ManagePlayerJustMounted
function checkIfPlayerJustMounted()
if (playerMounted == nil or playerMounted == false) then
if (IsMounted()) then
playerMounted = true;
ManagePlayerJustMounted();
end--end ismounted
elseif (playerMounted) then
if (not(IsMounted())) then
print("just dismounteed");
playerMounted = false;
--player just dismounted.
end--end isnt mounted

end--end player wasnt mounted before this function call
end--end function checkIfPlayerJustMounted

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function checkIfDankSliderStateChanged()
local x = dankness_slider:GetValue();
if (lastSliderDankValue ~= x) then
--it changed
lastSliderDankValue = x;
--update the snoopdog image speeds
dankSnoopImage.TIMER_MAX = (5 / dankness_slider:GetValue()) * 250 / 2500;
--now update the options from the slider position
if (x > 1.11) then
for c=1, x do--do each column left to right up to this
rowLength = currentOptionsRows[c]+1
for r=1, rowLength do
handle = dankFrameRowHandles[c][r];
DankOptions[handle.name] = true;
handle:SetChecked(true);
end--end for
end--end for
end--end if x is high enough

--now make the values to the right of the slider be 0 and unchecked
for c=x+1,5 do
c = math.ceil(c);
rowLength = currentOptionsRows[c]+1;
for r=1,rowLength do
handle = dankFrameRowHandles[c][r];
DankOptions[handle.name] = false;
handle:SetChecked(false);
end--end for
end--end for

--now handle the slider==1 special case (disable addon)
if (x <= 1.11) then
c = 1;
rowLength = currentOptionsRows[c]+1
for r=1, rowLength do
handle = dankFrameRowHandles[c][r];
DankOptions[handle.name] = false;
handle:SetChecked(false);
end--end for
end--end x==1 case


end--end it changed

end--end function checkIfDankSliderStateChanged

function manageDankOptionsAnimations(elapsed)

dankSnoopImage.timer = dankSnoopImage.timer + elapsed;
--go to the next image in the cycle
if (dankSnoopImage.timer > dankSnoopImage.TIMER_MAX and dankSnoopImage:IsShown()) then
dankSnoopImage.timer = 0;
dankSnoopImageObj:SetTexture('Interface/AddOns/DankMemes/images/snoop' .. dankSnoopImage.rotation .. '.tga');
dankSnoopImageObj2:SetTexture('Interface/AddOns/DankMemes/images/snoop' .. dankSnoopImage.rotation .. '.tga');
dankSnoopImage.rotation = dankSnoopImage.rotation + dankSnoopImage.rotationDirection;
--cycle the image back from 8 to 1
if (dankSnoopImage.rotation > dankSnoopImage.ROTATION_MAX) then
dankSnoopImage.rotationDirection = -1;
dankSnoopImage.rotation = dankSnoopImage.ROTATION_MAX;
end--end if
if (dankSnoopImage.rotation < 1) then
dankSnoopImage.rotationDirection = 1;
dankSnoopImage.rotation = 1;
end--end if

end--end if timer > max


end--end function manageDankOptionsAnimations

function manageInterventionAnimation(elapsed)
--interventionImageObj:SetTexture('Interface/AddOns/DankMemes/images/int_1.tga');

interventionImage.timer = interventionImage.timer + elapsed;
--go to the next image in the cycle
if (interventionImage.timer > interventionImage.TIMER_MAX and interventionImage:IsShown()) then
interventionImage.timer = 0;
interventionImageObj:SetTexture('Interface/AddOns/DankMemes/images/int_' .. interventionImage.rotation .. '.tga');
interventionImage.rotation = interventionImage.rotation + interventionImage.rotationDirection;
end
--cycle the image back from 8 to 1
if (interventionImage.rotation > interventionImage.ROTATION_MAX) then
interventionImage.rotationDirection = -1;
interventionImage.rotation = interventionImage.ROTATION_MAX;
end--end if
if (interventionImage.rotation < 1) then
interventionImage.rotationDirection = 1;
interventionImage.rotation = 1;
interventionImage:Hide();--stop the animation
end--end if


end--end function manageInterventionAnimation
firstTimeDank = 1;

function DankMemes_OnUpdate(self, elapsed)--the control loop, the "begin" loop
if (firstTimeDank == 1) then
firstTimeDank = 0;
CreateOptions();
LoadImageFrames();
end--end firstTimeDank
checkIfDankSliderStateChanged();
checkForNewBuffs();
checkPlayerMoneyChanged();
checkSanicBuffEnded();
checkIfPlayerJustMounted();
manageDankOptionsAnimations(elapsed);
manageInterventionAnimation(elapsed);
manageRWK(elapsed);
manageHitmarkers(elapsed);
manageCryingPepe(elapsed);
manageShekelsBurst(elapsed);
manageAboutToDie(elapsed);
end--end function DankMemes_OnUpdate( , )
function manageCryingPepe(elapsed)
if (showCryingPepe == true)
then
if (cryingPepeImage ~= nil)
then cryingPepeImage:Hide(); end
tPepe = tPepe + elapsed;
if (tPepe > 0.125)--modulus 0.125 on tpepe for resizing
then
tPepe = 0.001;
pepeSize = pepeSize + (pepeSize/20)*1;
if (pepeSize > 500)
then
pepeSize = 500;
end--end pepesize max size
end--end modulus pepe size

cryingPepeImage:SetSize(pepeSize,pepeSize);

cryingPepeImage:Show();
end--end pepe management for showCryingPepe == true

end--end manageCryingPepe
function manageRWK(elapsed)


end--end function manageRWK

checkBuffNames = {"Burst of Speed","Sprint","Posthaste","Blazing Speed","Angelic Feather","Displacer Beast","Dash","Stampeding Roar"};--valid buff names that will trigger Sanic
checkLastTimeLeft = {0,0,0,0,0,0,0,0};-- for use in checkForNewBuffs()
greenDankZoneSong = nil;--the handle on the sound file for GreenDankZone
greenDankBuffIndex = -1;

function checkSanicBuffEnded()

if (greenDankZoneSong) then
	if (checkLastTimeLeft[greenDankBuffIndex] < 0.2) then
	StopSound(greenDankZoneSong);
	greenDankBuffIndex = -1;
	greenDankZoneSong = nil;
	end--end checkLastTimeLeft
end--end if greensong

end--end function checkSanicBuffEnded
function manageHitmarkers(elapsed)
if (hitMarkerEnabled)
then
tHitMarker = tHitMarker + elapsed;
if (tHitMarker > 0.75)--make the hitmarker disappear after this many seconds
then
hitMarkerEnabled = false;
tHitMarker = 0;
hitMarkerImage:Hide();
end
end--end hitmarker handler

end--end manageHitmarkers(Elapsed)
function checkForNewBuffs()
local currentTime = GetTime();


--check each sanic buff's new application
for Index, Value in pairs(checkBuffNames) do 
local _, _, _, _, _, duration, expirationTime = UnitAura("player",Value)

if (expirationTime ~= nil) then
local timeLeft = expirationTime - currentTime;
if (timeLeft > checkLastTimeLeft[Index]) --if (the spell was just cast)
then
--get a handle on the song, and begin playing it.
_, greenDankZoneSong = PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\DankSpeed30.mp3', 'Master');
greenDankBuffIndex = Index;--so i know which buff to track for ending the sound file
end--end spell was cast
checkLastTimeLeft[Index] = timeLeft;
 end --end expirationTime ~= nil

end--end for


end--end checkForNewBuffs()






DankMemes = CreateFrame("Frame")


function MakeMemeNoise()
if (IsFlying() or IsFalling()) then 
	return; end
if (DankOptions["option_marioJump"] == true) then	
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\Mario_Jump.mp3', 'Master');
end--end option is true
end--end MakeMemeNoise

DankMemes:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)

function DankMemes:PLAYER_REGEN_DISABLED()
--the player has entered combat.
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\WORTWORTWORT.mp3', 'Master');
if (DankOptions["option_pokemonCombat"] == true) then 
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\POKEMON_COMBAT.mp3', 'Master');
end--end if
end--end PLAYER_REGEN_DISABLED
function DankMemes:PLAYER_ENTERING_WORLD()
if (DankOptions["option_youveGotMail"] == true) then
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\YouveGotMail.mp3', 'Master');
end
end--end enter_world

LaserNoiseHandle = nil;
function DankMemes:UNIT_SPELLCAST_INTERRUPTED(...)
spellCaster, spellName, _, spellCount = ...;

--starfire cancel spartan laser noise
if (spellName == "Starfire" and DankOptions["option_spartanLaser"] == true) then
if (LaserNoiseHandle ~= nil) then StopSound(LaserNoiseHandle); LaserNoiseHandle = nil; end;--stop the charging noise
end--end starfire cancel noise

end--end function UNIT_SPELLCAST_INTERRUPTED
function DankMemes:UNIT_SPELLCAST_START(...)
spellCaster, spellName, _, spellCount = ...;


if (spellName == "Starfire" and DankOptions["option_spartanLaser"] == true) then
_, LaserNoiseHandle = PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\Spartan_Laser_Charge.mp3', 'Master');
end
if (spellName == "Chaos Bolt" or spellName == "Chaos Wave")
then
print("TACTICAL NUKE INCOMING!!");
--https://www.youtube.com/watch?v=IXTJlH7g0tw
end
end--end function DankMemes:UNIT_SPELLCAST_START
function DankMemes:UNIT_SPELLCAST_SUCCEEDED(...)
spellCaster, spellName, _, spellCount = ...;
if (spellName == "Flare" and DankOptions["option_flare"] == true) then
--Heads up! Enemy UAV Spo''ed!
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\Enemy_UAV_Spotted.mp3', 'Master');
end--end flare
if ((spellName == "Starsurge" or spellName == "Starfire") and DankOptions["option_spartanLaser"] == true) then
if (LaserNoiseHandle ~= nil) then StopSound(LaserNoiseHandle); LaserNoiseHandle = nil; end;--stop the charging noise
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\Spartan_Laser_Fire.mp3', 'Master');--fire the laser
end
if (spellName == "Chaos Bolt" or spellName == "Chaos Wave")
then
print("TACTICAL NUKE LAUNCHED!!");
--https://www.youtube.com/watch?v=IXTJlH7g0tw
end

end	--end DankMemes:UNIT_SPELLCAST_SUCCEEDED
function DankMemes:PLAYER_LOGIN()
if (enableAOLintro == 1) then
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\DialUpLong.mp3', 'Master');
end--end enableAOLintro
end--end PLAYER_LOGIN


function DankMemes:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)

if (event == "PARTY_KILL") then
--if it is a killing blow on a player
local doInterventionThing = false;
if (UnitIsPlayer(destGUID) and srcGUID == UnitGUID("player") and 
			DankOptions["option_playerKillIntervention"] == true) then
doInterventionThing = true;
print("Just killed a player");
elseif (srcGUID == UnitGUID("player") and DankOptions["option_NPCKillIntervention"] == true) then
doInterventionThing = true;
print("Just killed an NPC");
end--end if
if (doInterventionThing == true) then
--start intervention animation and play sound
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\INTERVENTION_BANG.mp3', 'Master');
--instantiate the interventionImage for starting up
interventionImage.timer = 0;
interventionImage.rotation = 1;
interventionImage.rotationDirection = 1;
print("showing intervention image");
interventionImage:Show();
end--end start intervention cycle
end--end PARTY_KILL
--the player is entering combat
if (event == "UNIT_DIED")
then
--print('something died kek');
end
if (DankOptions["option_hitmarker"] and (event == "SWING_DAMAGE" or event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" or event == "RANGE_DAMAGE" or event == "DAMAGE_SPLIT" or event == "DAMAGE_SHIELD"))
then
--swing damage is autos and maybe melee attacks
playersName, playersRealm = UnitName("player") -- the name of the user

if (srcName == playersName)
then
--print('user casted a damage');
randy = math.random(3);
if (randy == 1)
then
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\Hitmarker_Volume_1.mp3', 'Master');
end
if (randy == 2)
then
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\Hitmarker_Volume_2.mp3', 'Master');
end
if (randy == 3)
then
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\Hitmarker_Volume_3.mp3', 'Master');
end

if (hitMarkerEnabled)
then
hitMarkerImage:Hide();--only one can be out at a time.
tHitMarker = 0;--restart timer on deleting latest hitmarker
end
--now display a hitmarker for a few seconds
hitMarkerImage = CreateFrame('Frame',nil, UIParent);
leHitMarkerRange = 400;
hitMarkerImage:SetPoint('CENTER',math.random(leHitMarkerRange)-leHitMarkerRange/2,math.random(leHitMarkerRange)-leHitMarkerRange/2);
	hitMarkerImage:SetFrameStrata("HIGH");
	hitMarkerImage:SetSize(48,48);
	
	hitMarkerImageObj = hitMarkerImage:CreateTexture();
	hitMarkerImageObj:SetAllPoints();
	hitMarkerImageObj:SetAlpha(1);
	hitMarkerImageObj:SetTexture('Interface/AddOns/DankMemes/images/Le_Perfect_Hitmarker.tga');
	hitMarkerImage:Show();
	
	hitMarkerEnabled = true;
--all that to display hitmarker image.

end--end "draw hitmarker"


end--end "true hit something", if hitmarker option checked








end --end function framememe

function MemePlayerDied()
randy = math.random(2);
if (randy == 1)
then
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\Hello_Darkness_Pepe.mp3', 'Master');
end
if (randy == 2)
then
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\Sad_Violin.mp3', 'Master');
end


showCryingPepe=true;


end--end MemePlayerDied

function MemePlayerReleased()
print('player released, hiding pepe')
showCryingPepe = false;tPepe = 0;pepeSize = 5;--hide pepe, end songs
cryingPepeImage:Hide();

end--end MemePlayerReleased

local playerMoneyAmountLast = -1;

function checkPlayerMoneyChanged()

local currentMoney = GetMoney();
--special case that happens on /reload and login:
if (playerMoneyAmountLast == -1)
then
playerMoneyAmountLast = currentMoney;
end

if (currentMoney > playerMoneyAmountLast) then
--add in shekels image guy for a few seconds

		if (math.random(2) == 2) then
		PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\CoinGet.mp3', 'Master');
		else
		PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\RingGet.mp3', 'Master');
		end
end
if (currentMoney < playerMoneyAmountLast) then
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\RingLose.mp3', 'Master');
end

playerMoneyAmountLast = currentMoney;

end--end CheckPlayerMoneyChanged

function DankMemes_initialize()
print("|cff00ffff" .. ">DANK MEMES LOCKED&LOADED -- type /dank to configure")
local frameMemeDamageDone = CreateFrame("FRAME","DankMemesFrame");--RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
DankMemes:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
DankMemes:RegisterEvent("PLAYER_ENTERING_WORLD");
DankMemes:RegisterEvent("PLAYER_LOGIN");
DankMemes:RegisterEvent("UNIT_SPELLCAST_START");
DankMemes:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
DankMemes:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
DankMemes:RegisterEvent("PLAYER_REGEN_DISABLED");--detect if combat
hooksecurefunc('JumpOrAscendStart', MakeMemeNoise);
hooksecurefunc('RepopMe', MemePlayerReleased);
--http://wowprogramming.com/docs/api_categories#security



frameMemeDamageDone:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");


local frameDeath = CreateFrame("FRAME", "DankMemesFrame");
frameDeath:RegisterEvent("PLAYER_DEAD");
frameDeath:SetScript("OnEvent", MemePlayerDied);
--/eventtrace


end



--http://www.wowinterface.com/forums/showthread.php?t=40444 
--^ shows a whole bunch of interface stuff (buttons etc)
function doTestRun(x)--from slash commands right now
print("showing RWK");
showRWK = true;

frame:SetPoint('TOP',0,0);




end
local RWKFrame = CreateFrame('Frame','RWKFrame',UIParent);
local bgframe = CreateFrame('Frame','bgframe',UIParent);--movableFrame test

function test_createMovableFrame()
--bgframe = CreateFrame('Frame','bgframe',UIParent);
bgframe:SetPoint('CENTER',300,0);
bgframe:SetFrameStrata('HIGH');
bgframe:SetSize(200,200);

bgframe:SetMovable(true);
bgframe:EnableMouse(true);
bgframe:RegisterForDrag("LeftButton");
bgframe:SetScript("OnDragStart", bgframe.StartMoving)
bgframe:SetScript("OnDragStop", bgframe.StopMovingOrSizing)
local tex = bgframe:CreateTexture("ARTWORK");
 tex:SetAllPoints();
 tex:SetTexture(1.0, 0.5, 0); tex:SetAlpha(0.5);
 titleText = bgframe:CreateFontString("titleText",bgframe,"GameFontNormal");
 titleText:SetPoint("TOP",tex,"TOP",0,0);
 titleText:SetJustifyH("left")
titleText:SetText("B R A S I L");
titleText:Show();

bgframe:Show();



mybutton = CreateFrame("Button","mybutton",bgframe,"UIPanelButtonTemplate")
mybutton:SetText("kek");
--mybutton:SetAllPoints();
mybutton:SetWidth(80)
mybutton:SetHeight(22)
mybutton:SetScript("OnClick", function() ChatFrame1:AddMessage("Hello World") end)


bgframe:Show();
mybutton:Show();

end--end function


function bgframe:OnDragStart(self,...)
print('move pls');
bgframe:startMoving();
end
function bgframe:OnMouseDown(...)
print('kek');
end



