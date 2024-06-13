function [kx,ky] = binarygrad(xpoint,ypoint,avec)
%
% ASPHERIC describes a symmetric aspherical lens with sag given by
% s = r^2 / R / ( 1 + sqrt( 1 - ( k + 1 ) * r^2 / R^2 ) ) + a(1) * r^2 +
% a(2) * r^4 + ... + a(n) * r^2n

kx = 2*avec(1)*xpoint + 4*avec(2)*xpoint.^3 + 6*avec(3)*xpoint.^5 + 8*avec(4)*xpoint.^7+...
  10*avec(5)*xpoint.^9+ 12*avec(6)*xpoint.^11 + 14*avec(7)*xpoint.^13 + 16*avec(8)*xpoint.^15+...
  18*avec(9)*xpoint.^17 + 20*avec(10)*xpoint.^19;

ky = 2*avec(1)*ypoint + 4*avec(2)*ypoint.^3 + 6*avec(3)*ypoint.^5 + 8*avec(4)*ypoint.^7+...
  10*avec(5)*ypoint.^9+ 12*avec(6)*ypoint.^11 + 14*avec(7)*ypoint.^13 + 16*avec(8)*ypoint.^15+...
  18*avec(9)*ypoint.^17 + 20*avec(10)*ypoint.^19;

end