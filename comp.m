function [x,y] = comp(sinal, pos_inicial)

len_x=length(sinal)-pos_inicial;
x = zeros(len_x,pos_inicial);
y = zeros(len_x,1);
ix=1;
i=pos_inicial;
    
while(ix<len_x+1)
    j=1;
    jx=1;
    while(jx<pos_inicial+1)
        
        x(ix,jx)=sinal(i-pos_inicial+j);
       
        j=j+1;
        jx=jx+1;
    end
    
    y(ix)=sinal((pos_inicial)+ix);
 
    i=i+1;
    ix=ix+1;
end
end


