function result = showHarris(img,corners)
    result = img;
    rows = size(img,1);
    cols = size(img,2);
    npoints = size(corners,1);
    for i=1:npoints 
        px = corners(i,1);
        py = corners(i,2);
        minx= max(px-2,1);
        maxx = min(px+2,rows);
        miny= max(py-2,1);
        maxy = min(py+2,cols);
        for k = minx:maxx
            for j = miny:maxy
                result(k,j,:) = [255 0 0];
            end
        end
    end
end