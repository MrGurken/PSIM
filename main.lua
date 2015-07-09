Run( "D:/dev/Git/PSIM/keys.lua" );
Run( "D:/dev/Git/PSIM/tile.lua" );

if camera == nil then
	camera = Camera.Create();
	camera:Projection( 0, 640, 0, 480, -1, 1 );
	camera:Active();
end

if tiles == nil then
	local texture = Texture.Load( "./res/textures/tilesheet.png" );

	local mapWidth = Config.Width / Tile.Size;
	local mapHeight = Config.Height / Tile.Size;
	
	tiles = {};
	for y=1,mapHeight do
		tiles[y] = {};
		for x=1,mapWidth do
			tiles[y][x] = Tile.Create();
			tiles[y][x]:Alive( true );
			tiles[y][x]:Position( (x-1)*Tile.Size, (y-1)*Tile.Size );
			tiles[y][x]:Texture( texture );
			tiles[y][x].id = ((y-1)*mapWidth)+x;
			tiles[y][x]:ComputeUV();
		end
	end
end

function GameLoop()
	if KeyDown( Keys.Escape ) then
		Quit();
	end
	
	local mpos = MousePosition();
	local x = math.floor( mpos.x / Tile.Size )+1;
	local y = math.floor( mpos.y / Tile.Size )+1;
	if x > 0 and x <= 20 and y > 0 and y <= 20 then
		tiles[y][x]:Alive( false );
	end
end

if mainRef then
	Unrefer( mainRef );
end
mainRef = Refer( GameLoop );