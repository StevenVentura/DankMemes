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

SLASH_DankMemes1 = "/DankMemes";SLASH_DankMemes2 = "/Dank";SLASH_DankMemes3 = "/Meme";
SlashCmdList["DankMemes"] = function(c)
InterfaceOptionsFrame_OpenToCategory(DankOptionsPanel);
end--end function slashcommand

--settings placeholder
--internal variables below
local tHitMarker = 0;hitMarkerEnabled = false;hitMarkerImage = nil;
local showCryingPepe = false; tPepe = 0;pepeSize = 5;cryingPepeImage = nil;
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
			   ["option_haloMultikillNPCs"] = true,
			   ["option_marioJump"] = true,
			   ["option_youveGotMail"] = true,
			   ["option_spartanLaser"] = true,
			   ["option_UAV"] = true,
			   ["option_hitmarker"] = true,
			   ["option_pokemonCombat"] = true,
			   ["option_playerKillIntervention"] = true,
			   ["option_NPCKillIntervention"] = true,
			   ["option_KBSeizure"] = true,
			   ["option_KBCamera"] = true,
			   ["option_Thomas"] = true,
			   ["option_eliteAggro"] = true,
			   ["option_MLGIntro"] = true,
			   ["option_clippy"] = true,
			   ["option_shieldBreak"] = true,
			   ["option_fallingMoney"] = true,
			   ["option_spooky"] = true,
			   ["option_scorpion"] = true,
			   ["option_coinGet"] = true,
			   ["option_high"] = false,--actually gives me a headache lmao xd
			   ["option_sanic"] = true,
			   ["option_datboi"] = true,
			   ["option_explode"] = true
			   };
end--end if not dankoptions

--create panel to be placed into blizzard options UI 

--label
DankOptionsPanel.name = "Dank Memes /dank";


--create the options interface screen for DankMemes
AddDankOption("option_pepeDeath","Sad Pepe","Pepe feels for your loss. You will be remembered.",1);
AddDankOption("option_haloMultikill","KB Halo Medals", "Show Halo Multikill medals when you kill players",1);
AddDankOption("option_haloMultikillNPCs","NPC Halo Medals","Show Halo Multikill medals when you kill, regardless of NPC or player",4);
AddDankOption("option_marioJump","Mario Jump","Play SNES Mario jump soundfile when you jump",4);
AddDankOption("option_youveGotMail","Youve Got Mail","Play AOL-themed 'Youve Got Mail' if you have mail",1);
AddDankOption("option_spartanLaser","Laser Chickens","Player Halo3 spartan laser sound for laserchicken class",3);
AddDankOption("option_UAV","UAV Flare", "Hunter Flare: Heads up! Enemy UAV Spot'ed!", 3);
AddDankOption("option_hitmarker","Hit Marker", "Show COD hitmarkers/sound when you deal damage",2);
AddDankOption("option_pokemonCombat","PokeBattle", "Play Pokemon intro song when you enter combat",5);
AddDankOption("option_playerKillIntervention","xXQuickScopeX","Show quickscope animation and play sound when you land killing blow on a player",1);
AddDankOption("option_NPCKillIntervention","DANK SCOPED","Show quickscope animation on all kills, regardless of NPC or Player unit.",5);
AddDankOption("option_KBSeizure","KBSeizure","Be given an actual seizure when you get a KB on a player.",5);
AddDankOption("option_KBCamera","MOM CAMERA","MOM GET THE CAMERA!! when KB on a player",2);
AddDankOption("option_Thomas","Dank Engine","When you mount, Thomas the Dank engine makes his appearance.",4)
AddDankOption("option_eliteAggro","EliteSounds","When you aggro something, Halo1 elite aggro sounds play",2);
AddDankOption("option_MLGIntro","MLG Intro", "When you finish loading or log in, a dank MLG montage intro plays", 5);
AddDankOption("option_clippy","Clippy", "Clippy the Paperclip from Microsoft gives you tips",2);
AddDankOption("option_shieldBreak","HaloShields","Play halo shield noises for shield being broken and for recharging.",1)
AddDankOption("option_fallingMoney","Money Rain","Rain money from the sky when you make bank",2);
AddDankOption("option_spooky","Spooky Scary","When someone casts Fear, it plays 'spooky scary' dank song",3);
AddDankOption("option_scorpion","GET OVER HERE","When someone casts Death Grip, play Scorpion's 'GET OVER HERE'",3);
AddDankOption("option_coinGet","Coin Sounds","Play sonic or mario coin sound when you make or lose gold",1);
AddDankOption("option_high","Blaze 420","Tint the screen and distort it periodically",5)
AddDankOption("option_sanic","Sanic Hedgheg","When you go fast, Sanic the Hedgheg makes his appearance",2);
AddDankOption("option_datboi","Dat Boi","It's Dat Boi!! O Shit Waddup??",2);
AddDankOption("option_explode","Explosions","When you deal over 25% of your hp, show an explosion",4);
--create the slider
CreateFrame("Slider","dankness_slider",DankOptionsPanel);
dankness_slider:SetPoint("BOTTOM",0,10);
dankness_slider:SetWidth(600)
dankness_slider:SetHeight(120)
dankness_slider:SetFrameStrata("HIGH");
dankness_slider:SetOrientation("HORIZONTAL")
dankness_slider:SetThumbTexture('Interface/AddOns/DankMemes/images/GOLD_WEED_SLIDER.tga');
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


function StopGIF(gif)

gif.duration = 0;
gif.timer = 0;
gif:Hide();
gif.rotation = 1;

end--end function StopGIF

function manageGIF(gif, elapsed)
if (gif == DatBoiImage) then
if (math.random() < 0.01) then
DatBoiImage.rarityStacks = DatBoiImage.rarityStacks + 1;
if (DatBoiImage.rarityStacks == DatBoiImage.RARITY_STACKS_MAX) then
StartGIF(DatBoiImage,6*2);
end--end if
end--end if
end--end if gif == DatBoiImage
if (not(gif:IsShown())) then return end; 
if (not(DankOptions[gif.ruleName] == true)) then return end;
gif.timer = gif.timer + elapsed;
gif.duration = gif.duration + elapsed;
if (gif.duration > gif.DURATION_MAX) then
gif:Hide(); return;
end

if (gif.timer > gif.TIMER_MAX)
then
gif.timer = 0;
gif.rotation = gif.rotation + 1;
if (gif.rotation > gif.ROTATION_MAX) then
gif.rotation = 1;
end
gif.imageObj:SetTexture('Interface/AddOns/DankMemes/images/' .. gif.fileNamePrefix 
						.. '' .. gif.rotation .. '.tga');

end--end timer ticked over its modulus

end--end function manageGIF

function StartGIF(gif,DURATION_MAX)
if (not(DankOptions[gif.ruleName])) then return end;
gif.rotation = 1;
gif.DURATION_MAX = DURATION_MAX;
gif.timer = 0;
gif.duration = 0;
gif.rarityStacks = 0;--optional but i'll give it to all gifs.
gif:Show();
if (gif == MoneyFallingImage) then 

end--end case MoneyFallingImage
if (gif == DatBoiImage) then
end--end if datboi 

end

--had to be placed up here for larger scope / loading time.
CreateFrame('Frame',"MLGIntroImage",UIParent);

function LoadImageFrames()

CreateFrame('Frame','cryingPepeImage', UIParent);
cryingPepeImage:SetPoint('CENTER',0,0);
cryingPepeImage:SetFrameStrata("HIGH");
cryingPepeImageObj = cryingPepeImage:CreateTexture();
cryingPepeImageObj:SetAllPoints();
cryingPepeImageObj:SetAlpha(1);
cryingPepeImageObj:SetTexture('Interface/AddOns/DankMemes/images/Crying_Pepe.tga');
--
CreateFrame('Frame','SanicImage', UIParent);
SanicImage:SetPoint("BOTTOMLEFT",500,500);
SanicImage:SetSize(200,200);
SanicImage:SetFrameStrata("HIGH");
SanicImageObj = SanicImage:CreateTexture();
SanicImageObj:SetAllPoints();
SanicImageObj:SetAlpha(1);
SanicImageObj:SetTexture('Interface/AddOns/DankMemes/images/Sanic.tga');
SanicImage:Hide();
SanicImage.timer = 0;
SanicImage.TIMER_MAX = 0.00;--instant. gotta go fast!


SanicImage.x = 800*math.random();
SanicImage.y = 800*math.random();
--dx and dy are set upon showing sanic

--
CreateFrame('Frame','MLGBannerImage', DankOptionsPanel);
MLGBannerImage:SetAllPoints();
MLGBannerImage:SetSize(128,128);
MLGBannerImage:SetFrameStrata(DankOptionsPanel:GetFrameStrata());
MLGBannerImageObj = MLGBannerImage:CreateTexture();
MLGBannerImageObj:SetAllPoints();
MLGBannerImageObj:SetAlpha(0.25);
MLGBannerImageObj:SetTexture('Interface/AddOns/DankMemes/images/MLG_BANNER.tga')
MLGBannerImage:Show();
--
MLGBannerImage:CreateFontString("BannerImageText",MLGBannerImage,"GameFontNormalLarge");
BannerImageText:SetTextColor(1, 0.25, 0.25,1);
BannerImageText:SetPoint("TOPLEFT",20,-5);
BannerImageText:SetText(" Essential          Dank                 Class-Specific    Too Dank       Inject 420");
BannerImageText:Show();

--
CreateFrame('Frame','dankSnoopImage', DankOptionsPanel);
dankSnoopImage:SetPoint('CENTER', 200,20);
dankSnoopImage:SetFrameStrata("HIGH");
dankSnoopImage:SetSize(200,200);
dankSnoopImageObj = dankSnoopImage:CreateTexture();
dankSnoopImageObj:SetAllPoints();
dankSnoopImageObj:SetAlpha(1);
dankSnoopImageObj:SetTexture('Interface/AddOns/DankMemes/images/snoop1.tga');
dankSnoopImage:Show();

CreateFrame('Frame','dankSnoopImage2', DankOptionsPanel);
dankSnoopImage2:SetPoint('CENTER', -240,20);
dankSnoopImage2:SetSize(200,200);

dankSnoopImageObj2 = dankSnoopImage2:CreateTexture();
dankSnoopImageObj2:SetAllPoints();
dankSnoopImageObj2:SetAlpha(1);
dankSnoopImageObj2:SetTexture('Interface/AddOns/DankMemes/images/snoop1.tga');
dankSnoopImage2:Show();


dankSnoopImage.rotation = 1;
dankSnoopImage.rotationDirection = 1;
dankSnoopImage.ROTATION_MAX = 8;
dankSnoopImage.timer = 0;
dankSnoopImage.TIMER_MAX = (5 / dankness_slider:GetValue()) * 250 / 2500;

----
--frog now
CreateFrame('Frame','dankFrogImage', DankOptionsPanel);

dankFrogImage:SetPoint('CENTER', 0, 20);
dankFrogImage:SetFrameStrata("HIGH");
dankFrogImage:SetSize(200*(1920/1080),200);
dankFrogImageObj = dankFrogImage:CreateTexture();
dankFrogImageObj:SetAllPoints();
dankFrogImageObj:SetAlpha(1);
dankFrogImageObj:SetTexture('Interface/AddOns/DankMemes/images/frog1.tga');
dankFrogImage:Show();

dankFrogImage.rotation = 1;
dankFrogImage.ROTATION_MAX = 9;
dankFrogImage.timer = 0;
dankFrogImage.TIMER_MAX = -1;--define elsewhere

--intervention now
CreateFrame('Frame','interventionImage', UIParent);
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

interventionImage:Hide();
----

CreateFrame('Frame','multikillImage', UIParent);
multikillImage:SetPoint("BOTTOMLEFT",160,300);
multikillImage:SetFrameStrata("HIGH");
multikillImage:SetSize(80,80);
multikillImageObj = multikillImage:CreateTexture();
multikillImageObj:SetAllPoints();
multikillImageObj:SetAlpha(1);
multikillImageObj:SetTexture('Interface/AddOns/DankMemes/images/multi2.tga');
multikillImage:Hide();

--behavior:
--if the timeLeft is passed, then its set back to 10, and the streak is set to 0. image is hidden.
--if a new kill happens, then streak is + 1, and new image is displayed. timer set to timeAllowed.
--if kill > 10 then it stays at 10.
multikillImage.streak = 0;
multikillImage.timeAllowed = 20;
multikillImage.timeLeft = multikillImage.timeAllowed;


--
--the transparent cover screen images:
CreateFrame('Frame','seizureFrame',UIParent);
seizureFrame:SetAllPoints();--cover entire screen
seizureFrame:SetFrameStrata('HIGH');
seizureFrameObj = seizureFrame:CreateTexture("ARTWORK");
 seizureFrameObj:SetAllPoints();
 seizureFrameObj:SetTexture(0.168,0.059,0.004); seizureFrameObj:SetAlpha(0.40);
seizureFrame:Hide();

seizureFrame.timeLeft = 0;
seizureFrame.duration = 10*2;

--for returning screen back to normal
WorldFrameMaxWidth = WorldFrame:GetWidth();
WorldFrameMaxHeight = WorldFrame:GetHeight();
--
CreateFrame('Frame','thomasFrame',UIParent);
thomasFrame:SetPoint("CENTER",0,0);
thomasFrame:SetFrameStrata("HIGH");
thomasFrame.widthValue = 835/4;
thomasFrame.heightValue = 605/4;
thomasFrame:SetSize(thomasFrame.widthValue,thomasFrame.heightValue)--835,605 is original dimensions
thomasFrameObj = thomasFrame:CreateTexture();
thomasFrameObj:SetAllPoints();
thomasFrameObj:SetAlpha(1);
thomasFrameObj:SetTexture('Interface/Addons/DankMemes/images/Thomas_Dank.tga');
thomasFrame:Hide();

thomasFrame.xPos = WorldFrameMaxWidth;
thomasFrame.yPos = 3/8 * WorldFrameMaxHeight / 2;
thomasFrame.timer = 0;
thomasFrame.speed = 20;
--note: he just keeps flying across screen indefinitely until dismounted.

--CreateFrame('Frame',"MLGIntroImage",UIParent);
--special note for this frame: Had to be placed in larger scope to be loaded earlier.
MLGIntroImage:SetPoint("Center");
MLGIntroImage:SetFrameStrata("HIGH");
MLGIntroImage:SetSize(WorldFrameMaxWidth - 100,WorldFrameMaxHeight - 100);
MLGIntroImageObj = MLGIntroImage:CreateTexture();
MLGIntroImageObj:SetAllPoints();
MLGIntroImageObj:SetAlpha(1);
MLGIntroImageObj:SetTexture('Interface/Addons/DankMemes/images/intro1.tga');
MLGIntroImage:Hide();

MLGIntroImage.rotation = 1;
MLGIntroImage.ROTATION_MAX = 6;
MLGIntroImage.timer = 0;
MLGIntroImage.TIMER_MAX = 0.117420;
MLGIntroImage.duration = 0;
MLGIntroImage.DURATION_MAX = 10*2;--10 seconds hopefully
if (MLGIntroImage.showNextLoop == nil) then
MLGIntroImage.showNextLoop = false;--because i can't show it upon login, because it wouldnt be loaded yet.
end
--
--moneyfallingimage uses the new method
CreateFrame('Frame','MoneyFallingImage',UIParent);
MoneyFallingImage:SetPoint("Center");
MoneyFallingImage:SetFrameStrata("HIGH");
MoneyFallingImage:SetSize(WorldFrameMaxWidth - 100, WorldFrameMaxHeight - 100);
MoneyFallingImageObj = MoneyFallingImage:CreateTexture();
MoneyFallingImageObj:SetAllPoints();
MoneyFallingImageObj:SetAlpha(0.50);
MoneyFallingImageObj:SetTexture('Interface/Addons/DankMemes/images/money1.tga');
--these four are for compatibilty with my new generalized way of doing gifs
MoneyFallingImage.fileNamePrefix = "money";
MoneyFallingImage.imageObj = MoneyFallingImageObj;
MoneyFallingImage.ruleName = "option_fallingMoney";
MoneyFallingImage.ROTATION_MAX = 7;
MoneyFallingImage.TIMER_MAX = 0.125 * 2;
MoneyFallingImage:Hide();
--datboi is also going to use the new method
CreateFrame('Frame','DatBoiImage',UIParent);
DatBoiImage:SetPoint("Center");
DatBoiImage:SetFrameStrata("HIGH");
DatBoiImage:SetSize(230,230);
DatBoiImageObj = DatBoiImage:CreateTexture();
DatBoiImageObj:SetAllPoints();
DatBoiImageObj:SetAlpha(1);
DatBoiImageObj:SetTexture('Interface/Addons/DankMemes/images/datboi1.tga');
--these four are for compatibilty with my new generalized way of doing gifs
DatBoiImage.fileNamePrefix = "datboi";
DatBoiImage.imageObj = DatBoiImageObj;
DatBoiImage.ruleName = "option_datboi";
DatBoiImage.ROTATION_MAX = 7;
DatBoiImage.TIMER_MAX = 0.125*3;
DatBoiImage.rarityStacks = 0;
DatBoiImage.RARITY_STACKS_MAX = 50;
DatBoiImage:Hide();
--
CreateFrame('Frame','ClippyImage',UIParent);
ClippyImage:SetPoint("LEFT",100,0);
ClippyImage:SetFrameStrata("HIGH");
ClippyImage:SetSize(256,256);
ClippyImageObj = ClippyImage:CreateTexture();
ClippyImageObj:SetAllPoints();
ClippyImageObj:SetAlpha(1);
ClippyImageObj:SetTexture('Interface/AddOns/DankMemes/images/clippy_with_bubble.tga');

ClippyImage:CreateFontString("ClippyImageText",ClippyImage,"GameFontNormalLarge");
ClippyImageText:SetTextColor(0.11,0.11,0.11,1);
ClippyImageText:SetPoint("TOPLEFT",25,-12);
ClippyImageText:SetText("BRAZIL");
ClippyImageText:Show();

--clippy is special. he has text that shows up on his frame. it is typed over time.
ClippyImage.say = function(text)
ClippyImage.text = text;
ClippyImage.currentText = "";
ClippyImage.textIndex = 0;
ClippyImage.textLength = string.len(ClippyImage.text);
ClippyImage.timer = 0;
ClippyImage.TIMER_MAX = 0.25;

ClippyImageText:SetText("");
ClippyImageText:SetWidth(220);

ClippyImageText:SetWordWrap(true);
ClippyImageText:SetNonSpaceWrap(false);--dont wrap on middle of word.
ClippyImage:Show();
end--end function say

ClippyImage.quotes = { 
"I see that you are having trouble winning the game. Maybe you should try to 'Get Good' and not suck so badly.",
"I see you are STILL a virgin. Just pull a Bill Cosby -- you're hopeless\n[x]Don't talk to me or my son ever again",
"Why do they call it the 'xbox 360'?\n[x]When you walk up to it, you do 360° and walk away",
"Why do they call the mount 'invincible' when you can clearly see it?",
"I can't stand people who mix up your and you're. Their so stupid!",
"You have been flagged inactive as 'AFK'. To not be booted from the battleground, type '/afk'.",
"Sometimes I wonder...Is Metroid's gun part of his suit, or is attached to his arm like the guy in final fantasy 8?",
"Your DPS seems to be lacking. Press your 3 buttons harder and faster, retard " .. UnitClass('player'),


}
ClippyImage.rarityStacks = 0;
ClippyImage.RARITY_STACKS_MAX = 50;
ClippyImage.sayRandom = function()
local length = getn(ClippyImage.quotes);
ClippyImage.say(ClippyImage.quotes[math.random(length)]);
end--end function sayRandom


ClippyImage.say("Hello " .. UnitRace('player') .. ". How are you doing today? My name is Clippy and I will be here to annoy you periodically.");
if (DankOptions["option_clippy"] == false) then
ClippyImage:Hide();
end

--
CreateFrame("Frame","DankHighImage",UIParent);
DankHighImage:SetAllPoints();
DankHighImage:SetFrameStrata('HIGH');
DankHighImageObj = DankHighImage:CreateTexture("ARTWORK");
 DankHighImageObj:SetAllPoints();
 DankHighImageObj:SetTexture(0,1,0); DankHighImageObj:SetAlpha(0.40);
DankHighImage:Hide();
DankHighImage.red = 0;
DankHighImage.green = 1;
DankHighImage.blue = 0;
DankHighImage.trigLoop = 0;
--

seizureFrame:SetAllPoints();--cover entire screen
seizureFrame:SetFrameStrata('HIGH');
seizureFrameObj = seizureFrame:CreateTexture("ARTWORK");
 seizureFrameObj:SetAllPoints();
 seizureFrameObj:SetTexture(0.168,0.059,0.004); seizureFrameObj:SetAlpha(0.40);
seizureFrame:Hide();



end--end function LoadImageFrames


function manageClippy(elapsed)
if (not(ClippyImage:IsShown())) then 

if (math.random() < 0.01) then
 ClippyImage.rarityStacks = ClippyImage.rarityStacks + 1;
 if (ClippyImage.rarityStacks >= ClippyImage.RARITY_STACKS_MAX) then
 ClippyImage.rarityStacks = 0;
 ClippyImage.sayRandom();
 end--end if
end--end if


return; end;

ClippyImage.timer = ClippyImage.timer + elapsed;
if (ClippyImage.timer > ClippyImage.TIMER_MAX)
then
ClippyImage.timer = 0;
ClippyImage.textIndex = ClippyImage.textIndex + 1;
if (ClippyImage.textIndex <= ClippyImage.textLength) then
ClippyImage.currentText = ClippyImage.currentText .. 
			string.sub(ClippyImage.text, ClippyImage.textIndex, ClippyImage.textIndex);

ClippyImageText:SetText(ClippyImage.currentText);
end--otherwise dont do anything , just wait.

--use the textIndex as a timer at this point.
if (ClippyImage.textIndex > ClippyImage.textLength + 250/2/4) then
ClippyImage:Hide();
end

end




end--end function manageClippy

function ManagePlayerJustMounted()
if (DankOptions["option_Thomas"] == true) then
_, thomasIntro = PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\ThomasIntro.mp3', 'Master');
thomasFrame:Show();--begin showing thomas going across the screen
end--end if
end--end function ManagePlayerJustMounted
function checkIfPlayerJustMounted()
if (playerMounted == nil or playerMounted == false) then
if (IsMounted()) then
playerMounted = true;
ManagePlayerJustMounted();
end--end ismounted
elseif (playerMounted) then
if (not(IsMounted())) then
if (DankOptions["option_Thomas"] == true) then StopSound(thomasIntro); thomasFrame:Hide(); end
playerMounted = false;
--player just dismounted.
end--end isnt mounted

end--end player wasnt mounted before this function call
end--end function checkIfPlayerJustMounted

function managePlayerSeizure(elapsed)


seizureFrame.timeLeft = seizureFrame.timeLeft - elapsed;
if (seizureFrame.timeLeft+elapsed>0 and seizureFrame.timeLeft-elapsed<0 and DankOptions["option_KBSeizure"]) then
seizureFrame:Hide();
WorldFrame:SetAllPoints();
WorldFrame:SetSize(WorldFrameMaxWidth,WorldFrameMaxHeight);
return;
elseif (seizureFrame.timeLeft > 0) then --do the seizure thing
WorldFrame:ClearAllPoints(); 
WorldFrame:SetWidth(random()*WorldFrameMaxWidth + 150); 
WorldFrame:SetHeight(random()*WorldFrameMaxHeight + 150); 
WorldFrame:SetPoint("CENTER", 0, 32);

seizureFrameObj:SetTexture(random(),random(),random());

end


end--end function managePlayerSeizure

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
--if they slided it to the very end, play dank
if (x == 5) then PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\EVERY_DAY.mp3', 'Master'); end
if (x == 1) then PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\STEP_IT_UP.mp3', 'Master'); end
--update the snoopdog image speeds
dankSnoopImage.TIMER_MAX = (5 / dankness_slider:GetValue()) * 250 / 2500;
dankFrogImage.TIMER_MAX = dankSnoopImage.TIMER_MAX;
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

--note: manageDankOptionsAnimations handles both snoops and the frog on the same timer
function manageDankOptionsAnimations(elapsed)
if (not(dankSnoopImage:IsShown())) then return end;


dankSnoopImage.timer = dankSnoopImage.timer + elapsed;
--go to the next image in the cycle
if (dankSnoopImage.timer > dankSnoopImage.TIMER_MAX and dankSnoopImage:IsShown()) then
dankSnoopImage.timer = 0;
dankSnoopImageObj:SetTexture('Interface/AddOns/DankMemes/images/snoop' .. dankSnoopImage.rotation .. '.tga');
dankFrogImageObj:SetTexture('Interface/AddOns/DankMemes/images/frog' .. dankFrogImage.rotation .. '.tga');
dankSnoopImageObj2:SetTexture('Interface/AddOns/DankMemes/images/snoop' .. dankSnoopImage.rotation .. '.tga');
dankSnoopImage.rotation = dankSnoopImage.rotation + dankSnoopImage.rotationDirection;
dankFrogImage.rotation = dankFrogImage.rotation + 1;
--cycle the frog image 9 --> 1
if (dankFrogImage.rotation > dankFrogImage.ROTATION_MAX) then
dankFrogImage.rotation = 1;
end
--cycle the snoop image back from 8 to 1
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
if (interventionImage.timer > interventionImage.TIMER_MAX) then
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
function manageMultikills(elapsed)
--if the timeLeft is passed, then its set back to 10, and the streak is set to 0. image is hidden.
multikillImage.timeLeft = multikillImage.timeLeft - elapsed;
if (multikillImage.timeLeft < 0) then
multikillImage.streak = 0;
multikillImage:Hide();
end


end--end function manageMultikills

function manageThomasTheTrain(elapsed)--he cannot be managed. he will do as he pleases.
if (DankOptions["option_Thomas"] == false) then return end;
if (not (thomasFrame:IsShown())) then return end
----
thomasFrame.timer = thomasFrame.timer + elapsed;
if (thomasFrame.timer > 0.25/2/2) then
thomasFrame.timer = 0;
--he runs across the screen over and over
thomasFrame.xPos = thomasFrame.xPos - thomasFrame.speed;
if (thomasFrame.xPos < -thomasFrame:GetWidth()) then thomasFrame.xPos = WorldFrameMaxWidth; 
thomasFrame.yPos = math.random(WorldFrameMaxHeight * 3/8 * 3/4);
if (math.random(2) == 1) then thomasFrame.yPos = thomasFrame.yPos*-1; end
thomasFrame.speed = (math.random(20) + 20) / 2;
local sizeValue = math.random() + 0.5;--0.5 to 1.5
thomasFrame:SetSize(thomasFrame.widthValue * sizeValue, thomasFrame.heightValue * sizeValue);

end--end if reached left side of screen
thomasFrame:SetPoint("LEFT",thomasFrame.xPos,thomasFrame.yPos);
end--end timer tic
end--end function manageThomasTheTrain

function manageMLGIntro(elapsed)
if (DankOptions["option_MLGIntro"] == false) then return end;
if (MLGIntroImage.showNextLoop == true) then MLGIntroImage:Show(); MLGIntroImage.showNextLoop = false; end
if (not(MLGIntroImage:IsShown())) then return end
MLGIntroImage.timer = MLGIntroImage.timer + elapsed;
MLGIntroImage.duration = MLGIntroImage.duration + elapsed;
if (MLGIntroImage.duration > MLGIntroImage.DURATION_MAX) then StopGIF(MLGIntroImage); end
if (MLGIntroImage.timer > MLGIntroImage.TIMER_MAX) then
MLGIntroImage.rotation = MLGIntroImage.rotation + 1;
if (MLGIntroImage.rotation > 6) then MLGIntroImage.rotation = 1; end
MLGIntroImageObj:SetTexture('Interface/Addons/DankMemes/images/intro' .. MLGIntroImage.rotation .. '.tga');
end--end timer tic



end--end function manageMLGIntro


function DoFirstTimeThings()
if (DankOptions["option_youveGotMail"] == true) then
if (MiniMapMailFrame:IsShown()) then 
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\YouveGotMail.mp3', 'Master');
end
end


end--end function DoFirstTimeThings



function manageHaloShieldNoises(elapsed)
if (DankOptions["option_shieldBreak"] == false) then return end;

--hacky fix on crying pepe 
if (showCryingPepe == true) then
if (UnitHealth("player") > 0) then
showCryingPepe = false;tPepe = 0;pepeSize = 5;--hide pepe, end songs
cryingPepeImage:Hide();
end
end
healthPercentage = UnitHealth("player") / UnitHealthMax("player");
if (healthPercentage > HaloShieldFrame.HEALPOINT
    and HaloShieldFrame.IS_CHARGED == false) then
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\SHIELD_RECHARGE.mp3', 'Master');
HaloShieldFrame.IS_CHARGED = true;
end

HaloShieldFrame.timer = HaloShieldFrame.timer + elapsed;

if (HaloShieldFrame.timer > HaloShieldFrame.TIMER_MAX) then
if (healthPercentage < HaloShieldFrame.BREAKPOINT and UnitHealth("player") > 1) then
HaloShieldFrame.IS_CHARGED = false;
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\SHIELD_BROKEN.mp3', 'Master');
end
HaloShieldFrame.timer = 0;

end--end option
end--end function manageHaloShieldNoises

function LoadSoundFrames()
CreateFrame("Frame","HaloShieldFrame",nil);
HaloShieldFrame.timer = 0;
HaloShieldFrame.TIMER_MAX = 2 * 2 + 0.15;
HaloShieldFrame.BREAKPOINT = 0.25;
HaloShieldFrame.HEALPOINT = 0.325;
HaloShieldFrame.IS_CHARGED = true;

end--end function LoadSoundFrames

function manageBeingHigh(elapsed)
if (not(DankOptions["option_high"])) then 
if (DankHighImage:IsShown()) then 
DankHighImage:Hide();
end--end if
return end--end if
if (not(DankHighImage:IsShown())) then
DankHighImage:Show();
end--end if



DankHighImage.trigLoop = DankHighImage.trigLoop + elapsed;
DankHighImage.green = math.abs(math.cos(DankHighImage.trigLoop/7));
DankHighImage.green = DankHighImage.green / 2 + 0.5;--restrict it to [0.5,1]
DankHighImage.blue = math.abs(math.cos(DankHighImage.trigLoop/17));
DankHighImage.red = math.abs(math.sin(DankHighImage.trigLoop/13)) / 2;

DankHighImageObj:SetTexture(DankHighImage.red,DankHighImage.green,DankHighImage.blue);

end--end function manageBeingHigh

function manageSanic(elapsed)
if (not(DankOptions["option_sanic"])) then return end
--event is controlled by showing/hiding the image
if (not(SanicImage:IsShown())) then return end
SanicImage.x = SanicImage.x + SanicImage.dx;
SanicImage.y = SanicImage.y + SanicImage.dy;
local width, height = SanicImage:GetWidth(), SanicImage:GetHeight();
if (SanicImage.x < 0) then
SanicImage.x = 0;
SanicImage.dx = math.abs(SanicImage.dx);
end--end if
if (SanicImage.x + width*2 > WorldFrameMaxWidth) then
SanicImage.x = WorldFrameMaxWidth - width*2;
SanicImage.dx = -1*math.abs(SanicImage.dx);
end--end if
if (SanicImage.y + height*2 > WorldFrameMaxHeight) then
SanicImage.y = WorldFrameMaxHeight - height*2;
SanicImage.dy = -1*math.abs(SanicImage.dy);
end--end if
if (SanicImage.y < 0) then
SanicImage.y = 0;
SanicImage.dy = math.abs(SanicImage.dy);
end--end if

SanicImage:SetPoint("BOTTOMLEFT",SanicImage.x,SanicImage.y);

end--end function manageSanic


firstTimeDank = 1;
afterAWhileDank = 0;

function DankMemes_OnUpdate(self, elapsed)--the control loop, the "begin" loop

if (firstTimeDank == 1) then
firstTimeDank = 0;
CreateOptions();
LoadImageFrames();
LoadSoundFrames();

end--end firstTimeDank
if (afterAWhileDank < 3*2) then--wait for stuff to finish loading.
afterAWhileDank = afterAWhileDank + elapsed;
if (afterAWhileDank > 3*2) then
DoFirstTimeThings();--youve got mail!
end
end--end increment the afterAWhileDank counter
checkIfDankSliderStateChanged();
checkForNewBuffs();
checkPlayerMoneyChanged();
checkSanicBuffEnded();
checkIfPlayerJustMounted();
manageSanic(elapsed);
manageBeingHigh(elapsed);
manageClippy(elapsed);
manageGIF(MoneyFallingImage,elapsed);
manageGIF(DatBoiImage,elapsed);
manageHaloShieldNoises(elapsed);
manageMLGIntro(elapsed);
manageThomasTheTrain(elapsed);
managePlayerSeizure(elapsed);
manageMultikills(elapsed);
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

checkBuffNames = {"Burst of Speed","Sprint","Posthaste","Blazing Speed","Angelic Feather",
					"Displacer Beast","Dash","Stampeding Roar","Soulburn: Demonic Circle",
					"Darkflight", "Tiger's Lust"};--valid buff names that will trigger Sanic
checkLastTimeLeft = {0,0,0,0,0,0,0,0,0,0,0};-- for use in checkForNewBuffs()
greenDankZoneSong = nil;--the handle on the sound file for GreenDankZone
greenDankBuffIndex = -1;

function checkSanicBuffEnded()

if (greenDankZoneSong) then
	if (checkLastTimeLeft[greenDankBuffIndex] < 0.2) then
	StopSound(greenDankZoneSong);
	SanicImage:Hide();
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
if (DankOptions["option_sanic"]) then
if (math.random() < 0.5) then
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\youre_too_slow.mp3', 'Master');
_, greenDankZoneSong = PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\DankSpeed30.mp3', 'Master');
else
_, greenDankZoneSong = PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\gotta_go_fast.mp3', 'Master');
end--end if random
greenDankBuffIndex = Index;--so i know which buff to track for ending the sound file
SanicImage:Show(); SanicImage.dx = 8 + math.random()*40; SanicImage.dy = 8 + math.random()*40;
end--end if
end--end spell was cast
checkLastTimeLeft[Index] = timeLeft;
 end --end expirationTime ~= nil

end--end for


end--end checkForNewBuffs()






DankMemes = CreateFrame("Frame")

marioJumpSequence = 0;

function MakeMemeNoise()
if (IsFlying() or IsFalling()) then 
	return; end
if (DankOptions["option_marioJump"] == true) then	

if (marioJumpSequence == 0 and math.random(2) == 1) then
marioJumpSequence = 1;
end--end if randy

if (marioJumpSequence == 0) then
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\Mario_Jump.mp3', 'Master');
else
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\tripleJump' .. marioJumpSequence .. '.mp3', 'Master');
marioJumpSequence = marioJumpSequence + 1;
if (marioJumpSequence > 3) then
marioJumpSequence = 0;
end
end
end--end option is true
end--end MakeMemeNoise

DankMemes:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...)
end)
function DankMemes:PLAYER_REGEN_DISABLED()
--the player has entered combat.
randy = math.random(6);
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\elite_aggro' .. randy .. '.mp3', 'Master');
if (DankOptions["option_pokemonCombat"] == true) then 
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\POKEMON_COMBAT.mp3', 'Master');
end--end if
end--end PLAYER_REGEN_DISABLED
function DankMemes:PLAYER_ENTERING_WORLD()

if (DankOptions["option_MLGIntro"] == true) then 
MLGIntroImage.showNextLoop = true;
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\NEVER_DIE.mp3', 'Master');
end
end--end enter_world

LaserNoiseHandle = nil;
function DankMemes:UNIT_SPELLCAST_INTERRUPTED(...)
spellCaster, spellName, _, spellCount = ...;

if (spellName == "Fear" and DankOptions["option_spooky"] == true) then
if (FearNoiseHandle ~= nil) then StopSound(FearNoiseHandle); FearNoiseHandle = nil; end;
end
--starfire cancel spartan laser noise
if (spellName == "Starfire" and DankOptions["option_spartanLaser"] == true) then
if (LaserNoiseHandle ~= nil) then StopSound(LaserNoiseHandle); LaserNoiseHandle = nil; end;--stop the charging noise
end--end starfire cancel noise

end--end function UNIT_SPELLCAST_INTERRUPTED
function DankMemes:UNIT_SPELLCAST_START(...)
spellCaster, spellName, _, spellCount = ...;

if (spellName == "Fear" and DankOptions["option_spooky"] == true) then
_, FearNoiseHandle = PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\SPOOKY_CAST.mp3', 'MASTER');
end
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
if (spellName == "Flare" and DankOptions["option_UAV"] == true) then
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\Enemy_UAV_Spotted.mp3', 'Master');
end--end flare
if (spellName == "Death Grip" and DankOptions["option_scorpion"]) then
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\GET_OVER_HERE.mp3', 'Master');
end

if ((spellName == "Fear" or spellName == "Psychic Scream") and 
		DankOptions["option_spooky"]) then
	PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\SPOOKY_FINISH.mp3', 'Master');
		end
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

end--end PLAYER_LOGIN


function DankMemes:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)



if (event == "PARTY_KILL") then
--if it is a killing blow on a player
local doInterventionThing = false;
local countAsMultiKill = false;
local givePlayerSeizure = false;
if (bit.band(destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0 and srcGUID == UnitGUID("player") )then
--killing blow on a player
			if (DankOptions["option_playerKillIntervention"] == true) then doInterventionThing = true; end
		if (DankOptions["option_haloMultikill"] == true) then countAsMultiKill = true; end
		if (DankOptions["option_KBSeizure"] == true) then givePlayerSeizure = true; end
		if (DankOptions["option_KBCamera"] == true) then
		PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\GETTHECAMERA.mp3', 'Master');
		end
elseif (srcGUID == UnitGUID("player")) then
--killing blow on an NPC
			if (DankOptions["option_NPCKillIntervention"] == true) then doInterventionThing = true; end
		if (DankOptions["option_haloMultikillNPCs"] == true) then countAsMultiKill = true; end
end--end if


--now handle all the booleans we set
if (givePlayerSeizure == true) then
--set up for seizure event
seizureFrame:Show();
seizureFrame.timeLeft = seizureFrame.duration;
end--end if

if (countAsMultiKill == true) then
multikillImage.streak = multikillImage.streak + 1;
multikillImage.timeLeft = multikillImage.timeAllowed;
if (multikillImage.streak > 10) then multikillImage.streak = 10; end;
if (multikillImage.streak > 1) then
multikillImage:Show();
multikillImageObj:SetTexture('Interface/AddOns/DankMemes/images/multi' .. multikillImage.streak .. '.tga');
if (multikillImage.streak == 3) then
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\OH_BABY3.mp3', 'Master');
end
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\multi' .. multikillImage.streak .. '.mp3', 'Master');
end--end if > 1

end--end countAsMultiKill

if (doInterventionThing == true) then
--start intervention animation and play sound
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\INTERVENTION_BANG.mp3', 'Master');
--instantiate the interventionImage for starting up
interventionImage.timer = 0;
interventionImage.rotation = 1;
interventionImage.rotationDirection = 1;
interventionImage:Show();
end--end start intervention cycle
end--end PARTY_KILL
--the player is entering combat
if (event == "UNIT_DIED")
then

end
if (DankOptions["option_hitmarker"] and (event == "SWING_DAMAGE" or event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" or event == "RANGE_DAMAGE" or event == "DAMAGE_SPLIT" or event == "DAMAGE_SHIELD"))
then
--swing damage is autos and maybe melee attacks
playersName, playersRealm = UnitName("player") -- the name of the user
if (srcName == playersName)
then
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

if (greenDankZoneSong) then 
StopSound(greenDankZoneSong);
SanicImage:Hide();
end--end if

showCryingPepe=true;
end--end MemePlayerDied

function MemePlayerReleased()

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

if (DankOptions["option_coinGet"] == true) then
		if (math.random(2) == 2) then
		PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\CoinGet.mp3', 'Master');
		else
		PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\RingGet.mp3', 'Master');
		end--end if
	end--end if
		--start up the money gif
		StartGIF(MoneyFallingImage,6 * 2);
end
if (currentMoney < playerMoneyAmountLast) then
if (DankOptions["option_coinGet"] == true) then
PlaySoundFile('Interface\\AddOns\\DankMemes\\sounds\\RingLose.mp3', 'Master');
end--end if
end--end if

playerMoneyAmountLast = currentMoney;

end--end CheckPlayerMoneyChanged

function DankMemes_initialize()
print("|cff00ffff" .. ">DANK MEMES LOCKED&LOADED -- type /dank to configure")
local frameMemeDamageDone = CreateFrame("FRAME","DankMemesFrame");
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


end--end function DankMemes_initialize



--http://www.wowinterface.com/forums/showthread.php?t=40444 
--^ shows a whole bunch of interface stuff (buttons etc)