function q5 = matrix_dec(originData,blockx)
%
%
    [m,n]=size(originData);
    r3=m/blockx;c3=n/blockx;q4=0;q1=0;
    for i=1:r3
       for j=1:c3
          for s=1:blockx
             for k=1:blockx
                p3=s+q4;
                q2=k+q1;
                q5(s,k,i,j)=originData(p3,q2);
             end
          end   
          q1=q1+blockx;   
       end
       q4=q4+blockx;q1=0;
end

