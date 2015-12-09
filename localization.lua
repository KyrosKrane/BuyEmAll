BUYEMALL_MAX = "Max"
BUYEMALL_STACK = "Stack"
BUYEMALL_CONFIRMATION = "Are you sure you want to buy\n %d × %s?"
BUYEMALL_STACK_SIZE = "Stack Size"
BUYEMALL_CAN_BUY = "Maximum purchase"
BUYEMALL_CAN_FIT = "You can fit"
BUYEMALL_CAN_AFFORD = "You can afford"
BUYEMALL_AVAILABLE = "Vendor has"

local locale = GetLocale()
if locale == "deDE" then
    -- Thanks to JokerGermany
    BUYEMALL_CONFIRMATION = "Bist du sicher das du\n %d × %s kaufen willst?"
    BUYEMALL_STACK_SIZE = "Stack Größe"
    BUYEMALL_CAN_BUY = "Größt möglcher Einkauf"
    BUYEMALL_CAN_FIT = "Du hast Platz für"
    BUYEMALL_CAN_AFFORD = "Du kannst dir leisten"
    BUYEMALL_AVAILABLE = "Der Verkäufer hat"
elseif locale == "frFR" then
    -- Thanks to Layrajha
    BUYEMALL_STACK = "Pile"
    BUYEMALL_CONFIRMATION = "Voulez-vous vraiment acheter\n %d × %s?"
    BUYEMALL_STACK_SIZE = "Taille de pile"
    BUYEMALL_CAN_BUY = "Achat Maximum"
    BUYEMALL_CAN_FIT = "Vous pouvez transporter"
    BUYEMALL_CAN_AFFORD = "Vous pouvez payer"
    BUYEMALL_AVAILABLE = "Le marchand a"
elseif locale == "enGB" then
elseif locale == "koKR" then
elseif GetLocale()== "zhCN" then
    -- Thanks to q09q09
    BUYEMALL_MAX = "最多"
  	BUYEMALL_STACK = "一组"
	BUYEMALL_CONFIRMATION = "是否确实要买\n %2$s × %1$d件?"
	BUYEMALL_STACK_SIZE = "堆叠大小"
	BUYEMALL_CAN_BUY = "最多能购买"
	BUYEMALL_CAN_FIT = "能够买"
	BUYEMALL_CAN_AFFORD = "能买得起"
	BUYEMALL_AVAILABLE = "商店有"
	--[[
    BUYEMALL_MAX = "\230\156\128\229\164\154";
	BUYEMALL_STACK = "\228\184\128\231\187\132";
	BUYEMALL_CONFIRMATION = "\230\152\175\229\144\166\231\161\174\229\174\158\232\166\129\228\185\176\n %s \195\151 %d\228\187\182?";
	BUYEMALL_STACK_SIZE = "\229\160\134\229\143\160\229\164\167\229\176\143";
	BUYEMALL_CAN_BUY = "\230\156\128\229\164\154\232\131\189\232\180\173\228\185\176";
	BUYEMALL_CAN_FIT = "\232\131\189\229\164\159\228\185\176";
	BUYEMALL_CAN_AFFORD = "\232\131\189\228\185\176\229\190\151\232\181\183";
	BUYEMALL_AVAILABLE = "\229\149\134\229\186\151\230\156\137";]]
elseif GetLocale() == "zhTW" then
    -- Thanks to q09q09
	BUYEMALL_MAX = "最多"
	BUYEMALL_STACK = "一組"
	BUYEMALL_CONFIRMATION = "是否確實要買\n %2$s × %1$d件?"
	BUYEMALL_STACK_SIZE = "堆疊大小"
	BUYEMALL_CAN_BUY = "最多能購買"
	BUYEMALL_CAN_FIT = "能夠買"
	BUYEMALL_CAN_AFFORD = "能買得起"
	BUYEMALL_AVAILABLE = "商店有"
	--[[BUYEMALL_MAX = "\230\156\128\229\164\154";
	BUYEMALL_STACK = "\228\184\128\231\181\132";
	BUYEMALL_CONFIRMATION = "\230\152\175\229\144\166\231\162\186\229\175\166\232\166\129\232\178\183\n %s \195\151 %d\228\187\182?";
	BUYEMALL_STACK_SIZE = "\229\160\134\231\150\138\229\164\167\229\176\143";
	BUYEMALL_CAN_BUY = "\230\156\128\229\164\154\232\131\189\232\179\188\232\178\183";
	BUYEMALL_CAN_FIT = "\232\131\189\229\164\160\232\178\183";
	BUYEMALL_CAN_AFFORD = "\232\131\189\232\178\183\229\190\151\232\181\183";
	BUYEMALL_AVAILABLE = "\229\149\134\229\186\151\230\156\137";]]
elseif locale == "ruRU" then
end
