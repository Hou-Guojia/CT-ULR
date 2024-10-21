function DeNimg = Non_Local_Means(Nimg,PSH,WSH,Sigma)
% Non_Local_Means filter
% Function inputs:
%         Nimg:  Input image matrix + noisy image
%         PSH:  Size of the search window
%         WSH:  Size of the comparison window
%         Sigma: Variance
% Function output: 
%         DeNimg: Reconstructed denoised image

if ~isa(Nimg,'double')
    Nimg = double(Nimg)/255;
end

% Image dimensions
[Height,Width] = size(Nimg);
u = zeros(Height,Width); % Initialize denoised image matrix
M = u; % Initialize weight matrix
Z = M; % Initialize accumulated weights
% Avoid boundary effects
PP = padarray(Nimg,[PSH,PSH],'symmetric','both');
PW = padarray(Nimg,[WSH,WSH],'symmetric','both');

for dx = -WSH:WSH
    for dy = -WSH:WSH
        if dx ~= 0 || dy ~= 0
            Sd = integral_img(PP,dx,dy);
            % Obtain the squared difference matrix for corresponding pixels
            SDist = Sd(PSH+1:end-PSH,PSH+1:end-PSH)+Sd(1:end-2*PSH,1:end-2*PSH)-Sd(1:end-2*PSH,PSH+1:end-PSH)-Sd(PSH+1:end-PSH,1:end-2*PSH);       
            % Calculate weights for each pixel
            w = exp(-SDist/(2*Sigma^2));
            % Obtain corresponding noisy pixel
            v = PW((WSH+1+dx):(WSH+dx+Height),(WSH+1+dy):(WSH+dy+Width));
            % Update the denoised image matrix
            u = u+w.*v;
            % Update the weighted denoised image matrix
            M = max(M,w);
            % accumlated weights
            Z = Z+w;
        end
    end
end
% Reconstruct the image      
f = 1;
u = u+f*M.*Nimg;
u = u./(Z+f*M);
DeNimg = u; % Reconstructed denoised image

function Sd = integral_img(v,dx,dy)
t = img_Shift(v,dx,dy);
diff = (v-t).^2;
Sd = cumsum(diff,1);  
Sd = cumsum(Sd,2);

function t = img_Shift(v,dx,dy)
% Perform image transformation in the xy-coordinate system
t = zeros(size(v));
type = (dx>0)*2+(dy>0);
switch type
    case 0 % dx<0,dy<0: Shift down-right
        t(-dx+1:end,-dy+1:end) = v(1:end+dx,1:end+dy);
    case 1 % dx<0,dy>0: Shift down-left
        t(-dx+1:end,1:end-dy) = v(1:end+dx,dy+1:end);
    case 2 % dx>0,dy<0: Shift up-right
        t(1:end-dx,-dy+1:end) = v(dx+1:end,1:end+dy);
    case 3 % dx>0,dy>0: Shift up-left
        t(1:end-dx,1:end-dy) = v(dx+1:end,dy+1:end);
end
