function  bench = table2bench(bench,Lens_Table,first_surface_position)
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
        lens1 = Lens( r, D, R, k, glass ); % parabolic surface
    elseif string(Lens_Table(surface_count,2).Variables) == "Aspherical"
    elseif string(Lens_Table(surface_count,2).Variables) == "Binary"
    end
    first_surface_position = first_surface_position + Lens_Table(surface_count,4).Variables;
    surface_count = surface_count + 1;
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
        lens2 = Lens( r, D, R, k, glass ); % parabolic surface
    elseif string(Lens_Table(surface_count,2).Variables) == "Aspherical"
    elseif string(Lens_Table(surface_count,2).Variables) == "Binary"
    end
    bench.append( { lens1, lens2 } );
    first_surface_position = first_surface_position + Lens_Table(surface_count,4).Variables;
    surface_count = surface_count + 1;
end