function [] = Clear_cells(X, Y, Theta) %Clear_cells(X, Y, Theta, X_p, Y_p, Theta_p)
    global map point_distance gridsize
    
    point_distance = sqrt((1/(gridsize*2))^2+(1/(gridsize*2))^2)+1/(gridsize*4);
    length_sq = floor(66/(100/gridsize));
    width_sq = floor (50/(100/gridsize));
    k=0;
%     [X_shift, Y_shift] = Center_of_cell(X,Y,gridsize);
%     if mod(width_sq,2) == 0
%        X_shift = X_shift -  (1/gridsize);
%        Y_shift = Y_shift - (1/gridsize);
%     end
X_shift = X;
Y_shift = Y;
probability_param = 0.45;
    for i=1:1:(length_sq-2)
        for j=2:1:(width_sq-1)
            k=k+1;
            sq_vector(k,1)=X_shift+cosd(Theta)*point_distance*(j-(1+floor(width_sq/2)))  +sind(Theta)*point_distance*(i-(1+(floor((16/66)*length_sq))));
            sq_vector(k,2)=Y_shift-sind(Theta)*point_distance*(j-(1+floor(width_sq/2)))  +cosd(Theta)*point_distance*(i-(1+(floor((16/66)*length_sq))));
            if i <= (length_sq/4) 
                occ_x = probability_param*1.25 - (probability_param*(i/(length_sq/2)));
                %occ_x = 0.25-0.2*(i/(length_sq/2));
            elseif i >= ((3*length_sq/4))
                occ_x = (probability_param*1.25-probability_param/2) + ((probability_param/2)*(i/(length_sq)));
                %occ_x = 0.15+0.1*(i/(length_sq));    
            else
                %occ_x = 0.1;
                occ_x = probability_param/2;
            end
            if j <= ((width_sq)/4) 
                occ_y = probability_param*1.25-(probability_param/2)*((j-1)/(width_sq/2));
                %occ_y = 0.25-0.1*((j-1)/(width_sq/2));
            elseif (j-1) > (((3*width_sq)/4))
                occ_y = (probability_param*1.25-(probability_param/2))+(probability_param/2)*((j-width_sq/2)/(width_sq/2));
                %occ_y = 0.15+0.1*((j-width_sq/2)/(width_sq/2));    
            else
                %occ_y = 0.1;
                occ_y = probability_param/2;
            end
            occval(k,1) = occ_x+occ_y;
            if occval(k,1)>0.5
                occval(k,1) = 0.5;
            end
        end
    end
    
    X_vector = sq_vector(:,1);
    Y_vector = sq_vector(:,2);
    
    ij=[X_vector, Y_vector];    
    updateOccupancy(map, ij, occval);

end