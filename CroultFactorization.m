function [L,U] = croultFactorization (A) 
 L = zeros(size(A));
 U = zeros(size(A));
 [nRows, nColumns] = size(A);
 n = nRows;

 for k=1:n
        U(k,k)=1;
        sum=0;
        for p=1:k-1
            sum=sum+L(k,p)*U(p,k);
        end
        L(k,k)=(A(k,k)-sum); 
        for i=k+1:n
            sum=0;
            for r=1:k-1
                sum=sum+L(i,r)*U(r,k);
            end
            L(i,k)=(A(i,k)-sum); 
        end
        for j=k+1:n
            sum=0;
            for s=1:k-1
                sum=sum+L(k,s)*U(s,j);
            end
            U(k,j)=(A(k,j)-sum)/L(k,k); 
        end
 end