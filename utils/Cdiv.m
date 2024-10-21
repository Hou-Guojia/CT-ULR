function d = Cdiv(u1,u2)
[m,n,x]=size(u1);
A1=circshift(u1,[0,-1]);A1(:,n,:)=A1(:,n-1,:);
A2=circshift(u1,[0,1]);A2(:,1,:)=A2(:,2,:);
A3=circshift(u2,[-1,0]);A3(m,:,:)=A3(m-1,:,:);
A4=circshift(u2,[1,0]);A4(1,:,:)=A4(2,:,:);
ux=(A1-A2)./2;
uy=(A3-A4)./2;
d = ux+uy;