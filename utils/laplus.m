function [ laplus_u ] = laplus( u )
[m,n]=size(u);
%u(i,j+1)
B1=circshift(u,[0,-1]);B1(:,n)=B1(:,n-1);
%u(i,j-1)
B2=circshift(u,[0,1]);B2(:,1)=B2(:,2);
%u(i+1,j)
B3=circshift(u,[-1,0]);B3(m,:)=B3(m-1,:);
%u(i-1,j)
B4=circshift(u,[1,0]);B4(1,:)=B4(2,:);
laplus_u=B1+B2+B3+B4;
end

