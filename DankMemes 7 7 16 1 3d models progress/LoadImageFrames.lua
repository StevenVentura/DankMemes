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
CreateFrame('Frame','dankExplodeImage', UIParent);
dankExplodeImage:SetPoint('CENTER',0,0);
dankExplodeImage:SetFrameStrata('HIGH');
dankExplodeImage:SetSize(512,512);
dankExplodeImageObj = dankExplodeImage:CreateTexture();
dankExplodeImageObj:SetAllPoints();
dankExplodeImageObj:SetAlpha(0.75);
dankExplodeImageObj:SetTexture('Interface/AddOns/DankMemes/images/explode1.tga');
dankExplodeImage:Hide();

dankExplodeImage.fileNamePrefix = "explode";
dankExplodeImage.imageObj = dankExplodeImageObj;
dankExplodeImage.ruleName = "option_explode";
dankExplodeImage.ROTATION_MAX = 10;
dankExplodeImage.TIMER_MAX = 0.125*3;
dankExplodeImage:Hide();


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
dankFrogImage.TIMER_MAX = -1;--define elsewhere because it depends on the slider

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
WorldFrameMaxWidth = UIParent:GetWidth();--WorldFrame:GetWidth();
WorldFrameMaxHeight = UIParent:GetHeight();--WorldFrame:GetHeight();
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
MLGIntroImage:SetSize(WorldFrameMaxWidth,WorldFrameMaxHeight);
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
MoneyFallingImage:SetSize(WorldFrameMaxWidth, WorldFrameMaxHeight);
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
DatBoiImage:SetPoint("Center",WorldFrameMaxWidth/8,0);
DatBoiImage:SetFrameStrata("HIGH");
DatBoiImage:SetSize(300*2,200*2);
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
DatBoiImage.rarityStacks = 24;
DatBoiImage.RARITY_STACKS_MAX = 25;
DatBoiImage.rarityTimer = 0;
DatBoiImage.RARITY_TIMER_MAX = 0.030;
DatBoiImage:Hide();
--
CreateFrame('Frame','ClippyImage',UIParent);
ClippyImage:SetPoint("LEFT",100,0);
ClippyImage:SetFrameStrata("HIGH");
ClippyImage:SetSize(256,256);
ClippyImage:SetMovable(true);
ClippyImage:EnableMouse(true);
ClippyImage:RegisterForDrag("LeftButton");
ClippyImage:SetScript("OnDragStart", ClippyImage.StartMoving)
ClippyImage:SetScript("OnDragStop", ClippyImage.StopMovingOrSizing)
ClippyImage:SetClampedToScreen(true);
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
if (DankOptions["option_clippy"] == true) then
ClippyImage:Show();
end--end if
end--end function say

ClippyImage.quotes = { 
"I see that you are having trouble winning the game. Maybe you should try to 'Get Good' and not suck so badly.",
"I see you are STILL a virgin. Just pull a Bill Cosby -- you're hopeless\n[x]Don't talk to me or my son ever again",
"Why do they call it the 'xbox 360'?\n[x]When you walk up to it, you turn 360 degrees and walk away",
"Why do they call the mount 'invincible' when you can clearly see it?",
"I can't stand people who mix up your and you're. Their so stupid!",
"You have been flagged inactive as 'AFK'. To not be booted from the battleground, type '/afk'.",
"Sometimes I wonder...Is Metroid's gun part of his suit, or is attached to his arm like the guy in final fantasy 8?",
"Your DPS seems to be lacking. Press your 3 buttons harder and faster, retard " .. UnitClass('player'),


}
ClippyImage.rarityStacks = 0;
ClippyImage.rarityTimer = 0;
ClippyImage.RARITY_TIMER_MAX = 0.030;
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