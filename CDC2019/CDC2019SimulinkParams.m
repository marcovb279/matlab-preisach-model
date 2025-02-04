%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
props = string(properties(preisachRelayModel));
for i = 1:length(props)
    propName = char(props(i,:));
    propVal = get(preisachRelayModel, propName);
    var = genvarname(propName);
    evalc([ var, ' = ', mat2str(propVal) ]);
end

preisachRelayModel.resetRelaysOn();
initialRelays = preisachRelayModel.relays;
inputMin = inputGrid(1);
inputMax = inputGrid(end);
inputAmp = dataHandler.inputAmp;
outputMin = dataHandler.outputMin;
outputMax = dataHandler.outputMax;
outputAmp = dataHandler.outputAmp;
inputFactor = 1.5;
outputFactor = 1.5;
simTotalTime = 10;
initialInput = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Linear system
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
s = tf('s');

poles = [-2.0000 + 2.0000i,
         -2.0000 - 2.0000i,
         -3.0000 + 0.0000i];
chi = poly(poles);

% Plant
% Gtf = 5/(s^3 + 7*s^2 + 16*s +10);
G0 = ss( tf(0.5*chi(end),chi) );
G0 = ss2ss(G0, inv(ctrb(G0.A, G0.B)));
GA = G0.A'; GB = G0.C'; GC = G0.B'; GD = G0.D;
% Gx0 = -0.8*(1./GC)/length(GC); Gx0(isinf(Gx0)) = 0;
Gx0 = [-0.7, -0.8, 0.9];

% Controller
% C0 = ss( 1/s );
% CA = C0.A; CB = C0.B; CC = C0.C; CD = C0.D;
% Cx0 = 0*(1./CC)/length(CC); Cx0(~isnumeric(Cx0)) = 0;

% No controller
CA = 0; CB = 0; CC = 0; CD = 1;
C0 = ss(CA, CB, CC, CD);
Cx0 = 0;

% Steady state gains
Gk = (-GC*inv(GA)*GB + GD);
Phik = -1/Gk;

% Stability conditions
lm = -2; lM = 2;
Gb = minreal((1+lM*G0*C0)/(1+lm*G0*C0));
disp(strcat('   Stable loop:', {' '}, string(isPassive(Gb))));
disp(strcat('   Phi_k:', {' '}, string(Phik)));
% figure; nyquist(Gb);
