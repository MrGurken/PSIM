Tile = setmetatable( {}, GameObject );
Tile.__index = Tile;
Tile.Size = 32;
Tile.SheetSize = 10;

function Tile.Create()
	local t = setmetatable( GameObject.Create(), Tile );
	t.id = 0;
	return t;
end

function Tile.Copy( base )
	local t = setmetatable( GameObject.Copy( base ), Tile );
	t.id = 0;
	return t;
end

function Tile:ComputeUV()
	local x = self.id-1;
	local y = 0;
	
	if x >= Tile.SheetSize then
		y = math.floor( x / Tile.SheetSize );
		x = math.fmod( x, Tile.SheetSize );
	end
	
	local uvlen = 1 / Tile.SheetSize;
	self:UVMin( x*uvlen, y*uvlen );
	self:UVLength( uvlen, uvlen );
end