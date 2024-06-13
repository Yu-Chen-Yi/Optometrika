function  bench = table2bench2(bench,Lens_Table,first_surface_position)
surface_count = 1;

while (surface_count < size(Lens_Table,1)+1)
    if string(Lens_Table(surface_count,2).Variables) == "Lens"
        % l = Lens( r, D, R, k, glass ) - object constructor
        % INPUT:
        % r - 1x3 position vector
        % D - diameter, 1x1 vector (outer) or 2x1 vector (inner, outer)
        % R - tangent sphere radius, [ Ry Rz ] vector for an astigmatic surface
        % k - conic coefficient, for astigmatic surface corresponds to the y-axis
        % glass - 1 x 2 cell array of strings, e.g., { 'air' 'acrylic' }
        r = [first_surface_position 0 0];
        D = Lens_Table(surface_count,7).Variables*2;
        R = Lens_Table(surface_count,3).Variables;
        k = Lens_Table(surface_count,8).Variables;
        glass = {string(Lens_Table(surface_count,5).Variables) ...
            string(Lens_Table(surface_count,6).Variables)};
        % front lens surface
        surface_temp = Lens( r, D, R, k, glass ); % parabolic surface
    elseif string(Lens_Table(surface_count,2).Variables) == "Plane"
        % p = Plane( r, D, glass ) - circular planar surface constructor
        % INPUT:
        % r - 1x3 position vector
        % D - diameter, 1x1 vector (outer) or 2x1 vector (inner, outer)
        % glass - 1 x 3 cell array of two strings, e.g., { 'air' 'acrylic' }
        r = [first_surface_position 0 0];
        D = Lens_Table(surface_count,7).Variables*2;
        glass = {string(Lens_Table(surface_count,5).Variables) ...
            string(Lens_Table(surface_count,6).Variables)};
        surface_temp = Plane( r, D, glass );
    elseif string(Lens_Table(surface_count,2).Variables) == "Aspherical"
    elseif string(Lens_Table(surface_count,2).Variables) == "Binary"
        br = [first_surface_position 0 0];
        bD = Lens_Table(surface_count,7).Variables*2;
        bR = Lens_Table(surface_count,3).Variables;
        bk = Lens_Table(surface_count,8).Variables;
        bavec = [Lens_Table(surface_count,9).Variables,Lens_Table(surface_count,10).Variables...
            Lens_Table(surface_count,11).Variables,Lens_Table(surface_count,12).Variables,Lens_Table(surface_count,13).Variables...
            Lens_Table(surface_count,14).Variables,Lens_Table(surface_count,15).Variables,Lens_Table(surface_count,16).Variables...
            Lens_Table(surface_count,17).Variables,Lens_Table(surface_count,18).Variables];
        bglass = {string(Lens_Table(surface_count,5).Variables) ...
            string(Lens_Table(surface_count,6).Variables)};

        surface_temp = Binary( br, bD, bR, bk, bavec, bglass )
    end
    first_surface_position = first_surface_position + Lens_Table(surface_count,4).Variables;
    surface_count = surface_count + 1;
    bench.append( surface_temp );
end