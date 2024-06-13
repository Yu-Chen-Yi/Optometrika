classdef Binary < GeneralLens
    % ASPHERICLENS Implements a lens surface given by a rotation of a conic curve
    % with additional polynomial terms, its sag given by
    % s = r^2 / R / ( 1 + sqrt( 1 - ( k + 1 ) * r^2 / R^2 ) ) + a(1) * r^2 +
    % a(2) * r^4 + ... + a(n) * r^2n, where
    % R is the tangent sphere radius, k is the aspheric factor:
    % 0 < k - oblate spheroid
    % k = 0 - sphere
    % -1 < k < 0 - prolate spheroid
    % k = -1 - parabola
    % k < -1 - hyperbola
    % and a(1) ... a(n) are the polynomial aspheric terms
    %
    % Member functions:
    %
    % l = AsphericLens( r, D, R, k, avec, glass ) - object constructor
    % INPUT:
    % r - 1x3 position vector
    % D - diameter
    % R - tangent sphere radius, [ Ry Rz ] vector for an astigmatic surface
    % k - conic coefficient, for astigmatic surface corresponds to the y-axis
    % avec - a vector of the polynomial terms
    % glass - 1 x 2 cell array of strings, e.g., { 'air' 'acrylic' }
    % OUTPUT:
    % l - lens surface object
    %
    % l.display() - displays the surface l information
    %
    % l.draw() - draws the surface l in the current axes
    %
    % l.rotate( rot_axis, rot_angle ) - rotate the surface l
    % INPUT:
    %   rot_axis - 1x3 vector defining the rotation axis
    %   rot_angle - rotation angle (radians)
    %
    % Copyright: Yury Petrov, 2016
    %

    properties
        avec = []; % vector of polynomial coeffeicient
    end

    methods
        function self = Binary( br, bD, bR, bk, bavec, bglass )
            if nargin == 0
                return;
            end
            if size( bD, 1 ) < size( bD, 2 )
                bD = bD';
            end
            if size( bD, 1 ) == 1
                bD = [ 0; bD ];
            end
            self.r = br;
            self.D = bD;
            self.R = bR;
            self.k = bk;
            if size( bavec, 1 ) > size( bavec, 2 )
                bavec = bavec';
            end
            self.avec = bavec;
            self.glass = bglass;
        end

        function display(self)
            fprintf( 'Position:\t [%.3f %.3f %.3f]\n', self.r );
            fprintf( 'Orientation:\t [%.3f %.3f %.3f]\n', self.n );
            fprintf( 'Diameter:\t %.3f\n', self.D );
            fprintf( 'Curv. radius:\t %.3f\n', self.R );
            fprintf( 'Asphericity:\t %.3f\n', self.k );
            fprintf( 'Polynomial coefficients:' );
            disp( self.avec );
            fprintf( 'Material:\t %s | %s\n', self.glass{ 1 }, self.glass{ 2 } );
        end

        %         function h = draw()
        %         end
    end
end
