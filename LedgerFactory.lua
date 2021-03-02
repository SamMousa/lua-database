

local LedgerFactory, _ = LibStub:NewLibrary("EventSourcing/LedgerFactory", 1)
if not LedgerFactory then
    return
end

local ListSync = LibStub("EventSourcing/ListSync")
local LogEntry = LibStub("EventSourcing/LogEntry")
local StateManager = LibStub("EventSourcing/StateManager")


LedgerFactory.createLedger = function(table, send, registerReceiveHandler)
    -- Support calls via : and .
    if (self ~= nil) then
        table = self
    end
    if type(table) ~= "table" then
        error("Must pass a table to LedgerFactory")
    end

    local sortedList = LogEntry.sortedList(table)
    local stateManager = StateManager:new(sortedList)
    --local listSync = ListSync:new

    stateManager:setUpdateInterval(1000)
    stateManager:setBatchSize(10)

    return {
        getStateManager = function()
            return stateManager
        end,
        registerMutator = function(metatable, mutatorFunc)
            stateManager:registerHandler(metatable, mutatorFunc)
        end,
        submitEntry = function(entry)
            return sortedList:uniqueInsert(entry)
        end,
        addStateChangedListener = function(callback)
            -- We hide the state manager from this callback
            --
            stateManager:addStateChangedListener(function(stateManager)
                local lag, uncommitted = stateManager:lag()
                return callback(lag, uncommitted)
            end)
        end



    }
end