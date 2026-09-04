local FCC = {
	bg = { 0.984, 0.945, 0.780 },
	fg = { 0.235, 0.220, 0.212 },
	red = { 0.800, 0.141, 0.114 }, -- #cc241d
	red2 = { 0.616, 0.000, 0.024 }, -- #9d0006
	green = { 0.596, 0.592, 0.102 }, -- #98971a
	green2 = { 0.475, 0.455, 0.055 }, -- #79740e
	yellow = { 0.843, 0.600, 0.129 }, -- #d79921
	yellow2 = { 0.710, 0.463, 0.078 }, -- #b57614
	blue = { 0.271, 0.522, 0.533 }, -- #458588
	blue2 = { 0.027, 0.400, 0.471 }, -- #076678
	purple = { 0.694, 0.384, 0.525 }, -- #b16286
	purple2 = { 0.561, 0.247, 0.443 }, -- #8f3f71
	aqua = { 0.408, 0.616, 0.416 }, -- #689d6a
	aqua2 = { 0.259, 0.482, 0.345 }, -- #427b58
	orange = { 0.839, 0.365, 0.055 }, -- #d65d0e
	orange2 = { 0.686, 0.227, 0.012 }, -- #af3a03
	gray = { 0.573, 0.514, 0.455 }, -- #928374
}

function fcv(fcc, a)
	local fcc2 = FCC[fcc]
	fcc2[4] = a or 1
	return fcc2
end

function fcvlerp(fcva, fcvb, t)
	local fcv1 = fcv(fcva)
	local fcv2 = fcv(fcvb)
	return {
		fcv1[1] + t * (fcv2[1] - fcv1[1]),
		fcv1[2] + t * (fcv2[2] - fcv1[2]),
		fcv1[3] + t * (fcv2[3] - fcv1[3]),
		fcv1[4] + t * (fcv2[4] - fcv1[4]),
	}
end

return FCC
