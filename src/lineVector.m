function [x,y] = lineVector(xA, xB, yA, yB, param)

  nPts = round(param.lineTime*param.fs);
  t = (0:(nPts-1))'/param.fs;
  
  if strcmp(param.interpMode, 'sin')
    xRaw = sin(2*pi*t*param.fCarrier);
    yRaw = sin(2*pi*t*param.fCarrier);
    x = xA + (xRaw+1)*(xB-xA)/2;
    y = yA + (yRaw+1)*(yB-yA)/2;
  elseif strcmp(param.interpMode, 'lin')
    u = t/t(end);
    x = xA*(1-u) + xB*u;
    y = yA*(1-u) + yB*u;
  end

end

