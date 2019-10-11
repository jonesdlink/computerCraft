local modem = peripheral.wrap('back')

print('Door Remote v1')
print('(l)ock (u)lock, or (q)uit')
while true do
	local event, key = os.pullEvent('key')
	if key == keys.l then 
		modem.transmit(50,50,'lock')
	end
	if key == keys.u then
		modem.transmit(50,50,'unlock')
	end
	if key == keys.q then
		return
	end
end
