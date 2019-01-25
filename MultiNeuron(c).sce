grand("setsd",2)
E=zeros(5,12);
N1=2;
N2=10;
N3=12;
N4=13;
N5=14;
N6=19;
N=[N1 N2 N3 N4 N5 N6];
for r=1:5
n=N(r);
M=128;
P1=[1/3; 1/3;1/3];
P2=[1/4;1/4;1/4;1/4];
P3=[1/5;1/5;1/5;1/5];
Q1 = (1/2)*P1;
Q2 = (1/3)*P2;
Q3 = (1/6)*P3;

a=3*[.2,.3,.4];
theta1=400;
theta2=1000;
theta3=1200;

Lambdan=[a(1)*(n*theta1)**(1),a(2)*(n*theta2)**(1),a(3)*(n*theta3)**(1)];
Rn=zeros(M);
for i=1:M
Z1 = grand(1, "poi", Lambdan(1));
Z2 = grand(1, "poi", Lambdan(2));
Z3 = grand(1, "poi", Lambdan(3));
Z = max([Z1 Z2 Z3]);
Q=[Q1;Q2;Q3];
Y = grand(Z, "mul", 5, Q);
Y1 = Y(1:3,1:Z1);
Y2= Y(4:7,1:Z2);
Y3 = Y(8:12,1:Z3);
//Y1 = grand(Z1, "mul", 3, P1);
//Y2 = grand(Z2, "mul", 4, P2);
//Y3 = grand(Z3, "mul", 5, P3);


Wn1=[sum(Y1(1,:)),sum(Y1(2,:)),sum(Y1(3,:))];
Wn2=[sum(Y2(1,:)),sum(Y2(2,:)),sum(Y2(3,:)),sum(Y2(4,:))];
Wn3=[sum(Y3(1,:)),sum(Y3(2,:)),sum(Y3(3,:)),sum(Y3(4,:)),sum(Y3(5,:))];
Lambdan;

mu1=[Wn1(1)/Lambdan(1),Wn1(2)/Lambdan(1),Wn1(3)/Lambdan(1)];
mu2=[Wn2(1)/Lambdan(2),Wn2(2)/Lambdan(2),Wn2(3)/Lambdan(2),Wn2(4)/Lambdan(2)];
mu3=[Wn3(1)/Lambdan(3),Wn3(2)/Lambdan(3),Wn3(3)/Lambdan(3),Wn3(4)/Lambdan(3),Wn3(5)/Lambdan(3)];

muesc1=sum(Wn1)/(3*Lambdan(1));
muesc2=sum(Wn2)/(4*Lambdan(2));
muesc3=sum(Wn3)/(5*Lambdan(3));

R11=Lambdan(1)*(mu1(1)-muesc1)**2/mu1(1);
R12=Lambdan(1)*(mu1(2)-muesc1)**2/mu1(2);
R13=Lambdan(1)*(mu1(3)-muesc1)**2/mu1(3);

R21=Lambdan(2)*(mu2(1)-muesc2)**2/mu2(1);
R22=Lambdan(2)*(mu2(2)-muesc2)**2/mu2(2);
R23=Lambdan(2)*(mu2(3)-muesc2)**2/mu2(3);
R24=Lambdan(2)*(mu2(4)-muesc2)**2/mu2(4);

R31=Lambdan(3)*(mu3(1)-muesc3)**2/mu3(1);
R32=Lambdan(3)*(mu3(2)-muesc3)**2/mu3(2);
R33=Lambdan(3)*(mu3(3)-muesc3)**2/mu3(3);
R34=Lambdan(3)*(mu3(4)-muesc3)**2/mu3(4);
R35=Lambdan(3)*(mu3(5)-muesc3)**2/mu3(5);
Rn(i)=sum([R11,R12,R13,R21,R22,R23,R24,R31,R32,R33,R34,R35]);
end
Rn;

T1=0;
T2=0;
T3=0;
T4=0;
T5=0;
T6=0;
T7=0;
T8=0;

h1=4.506956; 
h2=5.898826;
h3=7.116417;
h4=8.342833;
h5=9.703707;
h6=11.388751;
h7=13.925503;

for i=1:M
    if Rn(i)<h1 then T1=T1+1;
    end
    if h1<= Rn(i) & Rn(i) <=h2 then T2=T2+1;
    end
    if h2<= Rn(i) & Rn(i) <=h3 then T3=T3+1;
    end
    if h3<= Rn(i) & Rn(i) <=h4 then T4=T4+1;
    end
    if h4<= Rn(i) & Rn(i) <=h5 then T5=T5+1;
    end
    if h5<= Rn(i) & Rn(i) <=h6 then T6=T6+1;
    end
    if h6<= Rn(i) & Rn(i) <=h7 then T7=T7+1;    
    end
    if h7<= Rn(i) then T8=T8+1;
    end 
end
D=[T1,T2,T3,T4,T5,T6,T7,T8];
Percentage=(100/M)*D;
U=(Percentage-12.5).^2/12.5;

Percentage
D
[P,Q]=cdfchi("PQ", sum(U), 9)
ValorP=1-[P,Q]
sum(U)
E(r,:)=[Percentage sum(U) ValorP N(r)]
end
