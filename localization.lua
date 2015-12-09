BUYEMALL_LOCALS = {
	MAX 		= "Max",
	STACK 		= "Stack",
	CONFIRM 	= "Are you sure you want to buy\n %d × %s?",
	STACK_PURCH	= "Stack Purchase",
	STACK_SIZE 	= "Stack size",
	PARTIAL 	= "Partial stack",
	MAX_PURCH	= "Maximum purchase",
	FIT			= "You can fit",
	AFFORD		= "You can afford",
	AVAILABLE	= "Vendor has",
}

local locale, L = GetLocale(), BUYEMALL_LOCALS

--[[ Template

elsif locale == "xxXX" then
	L.MAX 			= ""
	L.STACK 		= ""
	L.CONFIRM 		= ""
	L.STACK_PURCH	= ""
	L.STACK_SIZE 	= ""
	L.PARTIAL 		= ""
	L.MAX_PURCH		= ""
	L.FIT			= ""
	L.AFFORD		= ""
	L.AVAILABLE		= ""

]]

if locale == "deDE" then
	-- Thanks to JokerGermany
	L.CONFIRM = "Bist du sicher das du\n %d × %s kaufen willst?"
	L.STACK_SIZE = "Stack größe"
	L.MAX_PURCH = "Größt möglcher Einkauf"
	L.FIT = "Du hast Platz für"
	L.AFFORD = "Du kannst dir leisten"
	L.AVAILABLE = "Der Verkäufer hat"
elseif locale == "frFR" then
	-- Thanks to Layrajha
	L.STACK 		= "Pile"
	L.CONFIRM 		= "Voulez-vous vraiment acheter\n %d × %s?"
	L.STACK_SIZE 	= "Taille de pile"
	L.MAX_PURCH		= "Achat maximum"
	L.FIT			= "Vous pouvez transporter"
	L.AFFORD		= "Vous pouvez payer"
	L.AVAILABLE		= "Le marchand a"
elseif locale == "zhCN" then
	-- Thanks to q09q09
	L.MAX			= "\230\156\128\229\164\154"
	L.STACK 		= "\228\184\128\231\187\132"
	L.CONFIRM 		= "\230\152\175\229\144\166\231\161\174\229\174\158\232\166\129\228\185\176\n %2$s \195\151 %1$d\228\187\182?"
	L.STACK_SIZE 	= "\229\160\134\229\143\160\229\164\167\229\176\143"
	L.MAX_PURCH		= "\230\156\128\229\164\154\232\131\189\232\180\173\228\185\176"
	L.FIT			= "\232\131\189\229\164\159\228\185\176"
	L.AFFORD		= "\232\131\189\228\185\176\229\190\151\232\181\183"
	L.AVAILABLE		= "\229\149\134\229\186\151\230\156\137"
elseif locale == "zhTW" then
	-- Thanks to q09q09
	L.MAX			= "\230\156\128\229\164\154"
	L.STACK 		= "\228\184\128\231\181\132"
	L.CONFIRM 		= "\230\152\175\229\144\166\231\162\186\229\175\166\232\166\129\232\178\183\n %2$s \195\151 %1$d\228\187\182?"
	L.STACK_SIZE 	= "\229\160\134\231\150\138\229\164\167\229\176\143"
	L.MAX_PURCH		= "\230\156\128\229\164\154\232\131\189\232\179\188\232\178\183"
	L.FIT			= "\232\131\189\229\164\160\232\178\183"
	L.AFFORD		= "\232\131\189\232\178\183\229\190\151\232\181\183"
	L.AVAILABLE		= "\229\149\134\229\186\151\230\156\137"
elseif locale == "koKR" then
	-- Thanks to sayclub
	L.MAX 			= "ìµœëŒ€"
	L.STACK 		= "ì„¸íŠ¸"
	L.CONFIRM 		= "ì •ë§ë¡œ ë‹¹ì‹ ì€ ë‹¤ìŒê³¼ ê°™ì´ êµ¬ë§¤ë¥¼ í¬ë§í•˜ì‹­ë‹ˆê¹Œ?\n[%d ê°œ Ã— %s ì•„ì´í…œ]"
	L.STACK_PURCH	= "ì„¸íŠ¸ êµ¬ìž…"
	L.STACK_SIZE 	= "ì„¸íŠ¸ ìˆ˜ëŸ‰"
	L.PARTIAL 		= "ë¶€ë¶„ ì„¸íŠ¸ êµ¬ìž…"
	L.MAX_PURCH		= "ìµœê³  êµ¬ìž…"
	L.FIT			= "êµ¬ìž… ê°€ëŠ¥ ìˆ˜ëŸ‰"
	L.AFFORD		= "í˜„ìž¬ ìžì‚°ìœ¼ë¡œ êµ¬ìž… ê°€ëŠ¥ ìˆ˜ëŸ‰"
	L.AVAILABLE		= "ìµœëŒ€ íŒë§¤ ìˆ˜ëŸ‰"
end
