function tonedImage = toneMapping(radianceMap , gamma)
    radianceMap = rescale(radianceMap);
    tempresult = radianceMap.^gamma;
    class(tempresult)
    tempresult = 255*tempresult;
    tonedImage = uint8(tempresult);
end
