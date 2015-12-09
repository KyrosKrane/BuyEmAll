local L = AceLibrary("AceLocale-2.0"):new("BuyEmAll")

--[[ Template

L:RegisterTranslations("*locale*", function() return {
    ["Max"] = "",
    ["Stack"] = "",
    ["Are you sure you want to buy\n %d × %s?"] = "",
    ["Stack size"] = "",
    ["Maximum purchase"] = "",
    ["You can fit"] = "",
    ["You can afford"] = "",
    ["Vendor has"] = "",
}end)

]]

L:RegisterTranslations("enUS", function() return {
    ["Max"] = "Max",
    ["Stack"] = "Stack",
    ["Are you sure you want to buy\n %d × %s?"] = "Are you sure you want to buy\n %d × %s?",
    ["Stack size"] = "Stack size",
    ["Maximum purchase"] = "Maximum purchase",
    ["You can fit"] = "You can fit",
    ["You can afford"] = "You can afford",
    ["Vendor has"] = "Vendor has",
}end)

L:RegisterTranslations("deDE", function() return {
    -- Thanks to JokerGermany
    ["Are you sure you want to buy\n %d × %s?"] = "Bist du sicher das du\n %d × %s kaufen willst?",
    ["Stack size"] = "Stack größe",
    ["Maximum purchase"] = "Größt möglcher Einkauf",
    ["You can fit"] = "Du hast Platz für",
    ["You can afford"] = "Du kannst dir leisten",
    ["Vendor has"] = "Der Verkäufer hat",
}end)

L:RegisterTranslations("frFR", function() return {
    -- Thanks to Layrajha
    ["Stack"] = "Pile",
    ["Are you sure you want to buy\n %d × %s?"] = "Voulez-vous vraiment acheter\n %d × %s?",
    ["Stack size"] = "Taille de pile",
    ["Maximum purchase"] = "Achat maximum",
    ["You can fit"] = "Vous pouvez transporter",
    ["You can afford"] = "Vous pouvez payer",
    ["Vendor has"] = "Le marchand a",
}end)

L:RegisterTranslations("zhCN", function() return {
    -- Thanks to q09q09
    ["Max"] = "\230\156\128\229\164\154",
    ["Stack"] = "\228\184\128\231\187\132",
    ["Are you sure you want to buy\n %d × %s?"] = "\230\152\175\229\144\166\231\161\174\229\174\158\232\166\129\228\185\176\n %2$s \195\151 %1$d\228\187\182?",
    ["Stack size"] = "\229\160\134\229\143\160\229\164\167\229\176\143",
    ["Maximum purchase"] = "\230\156\128\229\164\154\232\131\189\232\180\173\228\185\176",
    ["You can fit"] = "\232\131\189\229\164\159\228\185\176",
    ["You can afford"] = "\232\131\189\228\185\176\229\190\151\232\181\183",
    ["Vendor has"] = "\229\149\134\229\186\151\230\156\137",
}end)

L:RegisterTranslations("zhTW", function() return {
    ["Max"] = "\230\156\128\229\164\154",
    ["Stack"] = "\228\184\128\231\181\132",
    ["Are you sure you want to buy\n %d × %s?"] = "\230\152\175\229\144\166\231\162\186\229\175\166\232\166\129\232\178\183\n %2$s \195\151 %1$d\228\187\182?",
    ["Stack size"] = "\229\160\134\231\150\138\229\164\167\229\176\143",
    ["Maximum purchase"] = "\230\156\128\229\164\154\232\131\189\232\179\188\232\178\183",
    ["You can fit"] = "\232\131\189\229\164\160\232\178\183",
    ["You can afford"] = "\232\131\189\232\178\183\229\190\151\232\181\183",
    ["Vendor has"] = "\229\149\134\229\186\151\230\156\137",
}end)
