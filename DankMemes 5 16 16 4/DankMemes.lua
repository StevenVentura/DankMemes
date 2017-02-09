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
print(c);
doTestRun(c);--for testing purposes!
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
--temp testing variables below
function CreateOptions()
--this is also where i load the saved options.
--[[if (not TrashTalkOptions or TrashTalkOptions["Kicked"] == nil) then
print("instantiating trashtalkoptions"); 
TrashTalkOptions = {["Hitmarker"] = true, ["SendUponSight"] = false,]]

--create the options interface screen for DankMemes

--create the slider





end--end function CreateOptions

function manageAboutToDie(elapsed)
--when the player is about to die, play a sound clip "ITS JUST A PRANK!! ITS JUST A PRANK!!"
--maybe play a sound clip of sodapoppin screaming, or that one sex video man moaning/screaming sound clip


end--end function manageAboutToDie
function manageShekelsBurst(elapsed)
--if the shekels timer > 0 then show the shekels image 

end

function LoadImageFrames()

cryingPepeImage = CreateFrame('Frame',nil, UIParent);
cryingPepeImage:SetPoint('CENTER',0,0);
cryingPepeImage:SetFrameStrata("HIGH");
cryingPepeImageObj = cryingPepeImage:CreateTexture();
cryingPepeImageObj:SetAllPoints();
cryingPepeImageObj:SetAlpha(1);
cryingPepeImageObj:SetTexture('Interface/AddOns/DankMemes/images/Crying_Pepe.tga');

end--end function LoadImageFrames

firstTimeDank = 1;

function DankMemes_OnUpdate(self, elapsed)--the control loop
if (firstTimeDank == 1) then
firstTimeDank = 0;
LoadImageFrames();
CreateOptions();
end--end firstTimeDank
checkForNewBuffs();
checkPlayerMoneyChanged();
checkSanicBuffEnded();
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
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\Mario_Jump.mp3', 'Master');
end--end MakeMemeNoise

DankMemes:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)


function DankMemes:PLAYER_ENTERING_WORLD()
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\YouveGotMail.mp3', 'Master');
end--end enter_world
function DankMemes:COMPANION_UPDATE()
if (isMounted())then

end--end is mounted
end--end player just mounted
function DankMemes:UNIT_SPELLCAST_START(...)
spellCaster, spellName, _, spellCount = ...;
if (spellName == "Chaos Bolt" or spellName == "Chaos Wave")
then
print("TACTICAL NUKE INCOMING!!");
--https://www.youtube.com/watch?v=IXTJlH7g0tw
end
end--end function DankMemes:UNIT_SPELLCAST_START
function DankMemes:UNIT_SPELLCAST_SUCCEEDED(...)
spellCaster, spellName, _, spellCount = ...;
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
--"CHAT_MSG_COMBAT_HONOR_GAIN"
if (event == "UNIT_DIED")
then
--print('something died kek');
end
if (event == "SWING_DAMAGE" or event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" or event == "RANGE_DAMAGE" or event == "DAMAGE_SPLIT" or event == "DAMAGE_SHIELD")
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


end--end "true hit something"








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
print("|cff00ff00" .. "卍卍卍DANK MEMES LOADED卐卐卐")
local frameMemeDamageDone = CreateFrame("FRAME","DankMemesFrame");--RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
DankMemes:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
DankMemes:RegisterEvent("PLAYER_ENTERING_WORLD");
DankMemes:RegisterEvent("PLAYER_LOGIN");
DankMemes:RegisterEvent("UNIT_SPELLCAST_START");
DankMemes:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
DankMemes:RegisterEvent("COMPANION_UPDATE");
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
--[[
testImage = CreateFrame('Frame',nil, UIParent);
testImage:SetPoint('CENTER',0,0);
	testImage:SetFrameStrata("LOW");
	testImage:SetSize(256,256);
	
	testImageObj = testImage:CreateTexture();
	testImageObj:SetAllPoints();
	testImageObj:SetAlpha(1);
	testImageObj:SetTexture('Interface/AddOns/DankMemes/images/AOL.tga');
	testImage:Show();
------
testImage2 = CreateFrame('Frame',nil, UIParent);
testImage2:SetPoint('CENTER',0,30);
	testImage2:SetFrameStrata("MEDIUM");
	local size = 165;
	testImage2:SetSize(size,size);
	
	testImage2Obj = testImage2:CreateTexture();
	testImage2Obj:SetAllPoints();
	testImage2Obj:SetAlpha(1.0);
	testImage2Obj:SetTexture('Interface/AddOns/DankMemes/images/confirmed.tga');
	testImage2:Show();
--]]
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



