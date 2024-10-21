function [ grad_u, U] = Cgrad(u)
[m,n,~]=size(u);

B1=circshift(u,[0,-1]); B1(:,n,:)=B1(:,n-1,:);
B2=circshift(u,[0,1]);  B2(:,1,:)=B2(:,2,:);
B3=circshift(u,[-1,0]); B3(m,:,:)=B3(m-1,:,:);
B4=circshift(u,[1,0]);  B4(1,:,:)=B4(2,:,:);

grad_u(:,:,:,1)=(B1-B2)./2;
grad_u(:,:,:,2)=(B3-B4)./2;
U=B1+B2+B3+B4;
end
