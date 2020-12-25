ESX = nil
local RegisteredSocieties = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local function getMoneyFromUser(id_user)
	local xPlayer = ESX.GetPlayerFromId(id_user)
	return xPlayer.getMoney()

end

local function getMoneyFromUser(id_user)
	local xPlayer = ESX.GetPlayerFromId(id_user)
	return xPlayer.getMoney()

end

local function getBlackMoneyFromUser(id_user)
		local xPlayer = ESX.GetPlayerFromId(id_user)
		local account = xPlayer.getAccount('black_money')
	return account.money

end

local function getBankFromUser(id_user)
		local xPlayer = ESX.GetPlayerFromId(id_user)
		local account = xPlayer.getAccount('bank')
	return account.money

end
	
RegisterCommand("showjob'", function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.label
    local jobgrade = xPlayer.job.grade_label
    if Config.MythicNotify then
      TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('job') .. job .. ' - ' .. jobgrade})
    else
      TriggerClientEvent('esx:showNotification', _source, _U('job')  .. job .. ' - ' .. jobgrade)
    end  
end, false)

RegisterCommand("showcash", function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local wallet 		= getMoneyFromUser(_source)
    if Config.MythicNotify then
      TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('cash') .. wallet .. _U('currency')})
    else
      TriggerClientEvent('esx:showNotification', _source, _U('cash') .. wallet .. _U('currency'))
    end
end, false)

RegisterCommand("showbank", function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local bank 			= getBankFromUser(_source)
    if Config.MythicNotify then
      TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('bank') .. bank .. _U('currency')})
    else
      TriggerClientEvent('esx:showNotification', _source, _U('bank') .. bank .. _U('currency'))
    end
end, false)

RegisterCommand("showdirty", function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local black_money 	= getBlackMoneyFromUser(_source)
    if Config.MythicNotify then
      TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('dirty') .. black_money .. _U('currency')})
    else
      TriggerClientEvent('esx:showNotification', _source, _U('dirty') .. black_money .. _U('currency'))
    end
end, false)

RegisterCommand("showinfo", function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.label
    local jobgrade = xPlayer.job.grade_label
    local wallet 		= getMoneyFromUser(_source)
    local bank 			= getBankFromUser(_source)
    local black_money 	= getBlackMoneyFromUser(_source)
		local society = GetSociety(xPlayer.job.name)

		  if society ~= nil then
			  TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
				  money = account.money
			  end)
	  	else
			  money = 0
      end
      
      if Config.MythicNotify then       
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('job') .. job .. ' - ' .. jobgrade})
                Citizen.Wait(3500)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('cash') .. wallet .. _U('currency')})
                Citizen.Wait(3500)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('bank') .. bank .. _U('currency')})
                Citizen.Wait(3500)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('dirty') .. black_money .. _U('currency')})
                if xPlayer.job.grade_name == 'boss' then
                  Citizen.Wait(3500)
                  TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('society') .. money .. _U('currency')})
                end
      else
                TriggerClientEvent('esx:showNotification', _source, _U('job') .. job .. ' -' .. jobgrade)	         
                Citizen.Wait(3500)
                TriggerClientEvent('esx:showNotification', _source, _U('cash') .. wallet .. _U('currency'))
                Citizen.Wait(3500)
                TriggerClientEvent('esx:showNotification', _source, _U('bank') .. bank .. _U('currency'))
                Citizen.Wait(3500)
                TriggerClientEvent('esx:showNotification', _source, _U('dirty') .. black_money .. _U('currency'))
                if xPlayer.job.grade_name == 'boss' then
                  Citizen.Wait(3500)
                  TriggerClientEvent('esx:showNotification', _source, _U('society') .. money .. _U('currency'))
                end
			end														
end, false)

RegisterCommand("showsociety", function(source)
	local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.job.grade_name == 'boss' then
		local society = GetSociety(xPlayer.job.name)

		if society ~= nil then
			TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
				money = account.money
			end)
		else
			money = 0
		end
    
    if Config.MythicNotify then
	    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = _U('society') .. money .. _U('currency')})
    else
      TriggerClientEvent('esx:showNotification', _source, _U('society') .. money .. _U('currency'))
    end															
	else
    if Config.MythicNotify then
      TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('permissions')})
    else
      TriggerClientEvent('esx:showNotification', _source, _U('permissions'))
    end																		
	end
end, false)

TriggerEvent('esx_society:getSocieties', function(societies) 
	RegisteredSocieties = societies
end)

function GetSociety(name)
  for i=1, #RegisteredSocieties, 1 do
    if RegisteredSocieties[i].name == name then
      return RegisteredSocieties[i]
    end
  end
end
