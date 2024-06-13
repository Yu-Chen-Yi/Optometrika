% test a lens with polynomial aspheric terms
clf;clear;close all;
LENS_DATA = CY_Demo_LENS_DATA();
% create a container for optical elements (Bench class)
bench = Bench;
aper = Aperture( [ -0.1 0 0 ], [ 1.254 4 ] ); % circular aperture
bench.append( aper );
% add optical elements in the order they are encountered by light rays
final_position = 0;
for i = [1 3 5 7 9]
    s1_D = table2array(LENS_DATA(i,8))*2;
    s1_R = table2array(LENS_DATA(i,2));
    s1_conic = table2array(LENS_DATA(i,9));
    s1_A4 = table2array(LENS_DATA(i,10));
    s1_A6 = table2array(LENS_DATA(i,11));
    s1_A8 = table2array(LENS_DATA(i,12));
    s1_A10 = table2array(LENS_DATA(i,13));
    s1_A12 = table2array(LENS_DATA(i,14));
    s1_A14 = table2array(LENS_DATA(i,15));
    s1_A16 = table2array(LENS_DATA(i,16));
    s1_A18 = table2array(LENS_DATA(i,17));
    s1_A20 = table2array(LENS_DATA(i,18));
    s1_position = final_position;
    % front lens surface
    lens1 = AsphericLens( [ s1_position 0 0 ], s1_D, s1_R, s1_conic, [ 0 s1_A4 s1_A6 s1_A8 s1_A10 s1_A12 s1_A14 s1_A16 s1_A18 s1_A20 ], { 'air' 'pmma' } );
    bench.append( lens1 );
    % update lens position
    s2_D = table2array(LENS_DATA(i+1,8))*2;
    s2_R = table2array(LENS_DATA(i+1,2));
    s2_conic = table2array(LENS_DATA(i+1,9));
    s2_A4 = table2array(LENS_DATA(i+1,10));
    s2_A6 = table2array(LENS_DATA(i+1,11));
    s2_A8 = table2array(LENS_DATA(i+1,12));
    s2_A10 = table2array(LENS_DATA(i+1,13));
    s2_A12 = table2array(LENS_DATA(i+1,14));
    s2_A14 = table2array(LENS_DATA(i+1,15));
    s2_A16 = table2array(LENS_DATA(i+1,16));
    s2_A18 = table2array(LENS_DATA(i+1,17));
    s2_A20 = table2array(LENS_DATA(i+1,18));
    s2_position = final_position + table2array(LENS_DATA(i,3));
    % back lens surface
    lens2 = AsphericLens( [ s2_position 0 0 ], s2_D, s2_R, s2_conic, [ 0 s2_A4 s2_A6 s2_A8 s2_A10 s2_A12 s2_A14 s2_A16 s2_A18 s2_A20 ], { 'pmma' 'air' } ); % aspheric surface
    bench.append( lens2 );
    final_position = s2_position + table2array(LENS_DATA(i+1,3));
    %     draw_lens_engineering( [ s1_position s2_position ], [ s1_D s2_D ], [ s1_R s2_R ], [ s1_conic s2_conic ], [ 0 s1_A4 s1_A6 s1_A8 s1_A10 s1_A12 s1_A14 s1_A16 s1_A18 s1_A20; 0 s2_A4 s2_A6 s2_A8 s2_A10 s2_A12 s2_A14 s2_A16 s2_A18 s2_A20 ]', 'pmma' );
    %     fprintf( 'Engineering drawing saved in draw_lens_engineering.pdf\n' );
    %     pause(1)
end
% screen
screen = Screen( [ 3.781 0 0 ], 4, 4, 2048, 2048 );
bench.append( screen );
acolor = lines(4);
i = 1;
for field = [0 19 33.25]
    % create collimated rays with some slant
    nrays = 500;
    rays_in = Rays( nrays, 'collimated', [ -0.8 -0.7*tand(field) 0 ], [ 1 1*tand(field) 0 ], 1.2, 'hexagonal', [], [], acolor(i,:), [] );
    tic;
    fprintf( 'Tracing rays... ' );
    rays_through = bench.trace( rays_in );    % repeat to get the min spread rays
    % draw bench elements and draw rays as arrows
    figure(1)
    bench.draw(rays_through, [], [], [], 0 ) % display everything, the other draw option is 'lines'
    set(gca,'color','none');view(2);axis on;box on;grid on

    % % get the screen image in high resolution
    % nrays = 1000;
    % rays_in = Rays( nrays, 'collimated', [ -0.8 -0.7*tand(field) 0 ], [ 1 1*tand(field) 0 ], 1.2, 'hexagonal' );
    % bench.trace( rays_in );
    % figure( 'Name', 'Image on the screen', 'NumberTitle', 'Off' );
    % imshow( screen.image, [] );
    x = rays_through(1,13).r(:,2);
    y = rays_through(1,13).r(:,3);
    x(x==1) = [];
    y(y==1) = [];
    figure()
    plot(x,y,'.','color',acolor(i,:))
    axis equal
    goodplot2('x (mm)','y (mm)',round(field,2)+"\circ",12)
    toc;
    i = i+1;
end