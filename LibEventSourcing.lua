--[[
This file is used for direct inclusion outside WoW

]]--
if (GetTime == nil) then
    require "wow"
    require "libs/LibStub/LibStub"
    require "Util"
    require "SortedList"
    require "LogEntry"
    require "source/StartEntry"
    require "source/PlayerAmountEntry"
    require "source/PercentageDecayEntry"
    require "StateManager"
    require "source/Message"
    require "source/AdvertiseHashMessage"
    require "source/WeekDataMessage"
    require "source/RequestWeekMessage"
    require "source/BulkDataMessage"
    require "ListSync"
    require "LedgerFactory"
    math.randomseed(os.time())
end
