close all
clear;

% create a container for optical elements (Bench class)
load('lens_DATA_ZH.mat')
Lens_DATA.THICKNESS(6) = 13.7;
Lens_DATA.THICKNESS(8) = 4.45;
Lens_DATA.('Semi-Diameter')(7) = 5;
Lens_DATA.('Semi-Diameter')(8) = 5;
Lens_DATA.Type{8} = "Plane";
Lens_DATA.A2(8) = 0;
Lens_DATA.A4(8) = 0;
Lens_DATA.A6(8) = 0;
bench = Bench;

% add optical elements in the order they are encountered by light rays

% aperture
aper = Aperture( [ -10 0 0 ], [ 7 20 ] ); % circular aperture
bench.append( aper );

start_z = 0;

surface_count = 1;
% table bulit
table2bench2(bench,Lens_DATA2,0);

% screen
Lx = 0.02;
Ly = 0.02;
N = 256;
spot.x = linspace(-Lx/2,Lx/2,N);
spot.y = linspace(-Ly/2,Ly/2,N);
screen = Screen( [ 42.1250 0 0 ], Lx, Ly, N, N );
bench.append( screen );

%bench.rotate( [ 0 0 1 ], 0.15 );

% create some rays
nrays = 1001;
         %Rays( cnt, geometry, pos, dir, diameter, rflag, glass, wavelength, acolor, adiopter )
rays_in = Rays( nrays, 'collimated', [ -20 0 0 ], [ 1 0 0 ], 5, 'hexagonal' , 'air' , 940e-9 , [0 0 1]);
rays_through = bench.trace( rays_in );    % repeat to get the min spread rays
% draw bench elements and draw rays as arrows
bench.draw( rays_through, 'lines' );  % display everything, the other draw option is 'lines'
% view([0,-1,0])
view([-0.5,-1,0.3])
axis on
grid on
% draw_lens_engineering( [ 0 4.5 ], [ 18 18 ], [ 27.2200000000000 -27.2200000000000], [ 0 0 ], [0 0]', 'sf11' );
figure( 'Name', 'Image on the screen, convergence focal point','color','w', 'NumberTitle', 'Off' );
imagesc(spot.x,spot.y,screen.image);colormap gray;axis equal;axis tight;
goodplot2('\itx axis (mm)','\ity axis (mm)','Spot diagram',20)


