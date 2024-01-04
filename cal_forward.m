syms theta1 theta2 theta4 d3;
syms a1 a2 d1;

A01 = [cos(theta1)   -sin(theta1)    0   a1*cos(theta1)
       sin(theta1)   cos(theta1)     0   a1*sin(theta1)
       0             0               1   d1
       0             0               0   1              ];

A12 = [cos(theta2)   -sin(theta2)    0   a2*cos(theta2)
       sin(theta2)   cos(theta2)     0   a2*sin(theta2)
       0             0               1   0
       0             0               0   1              ];

A23 = [1   0   0   0
       0   1   0   0
       0   0   1   d3
       0   0   0   1];
  
A34 = [cos(theta4)  sin(theta4)   0   0
      sin(theta4)   -cos(theta4)  0   0
      0             0             1  0
      0             0             0   1];
  
T1 = A01;
T2 = T1*A12;
T3 = T2*A23;
T4 = T3*A34;
T1 = simplify(T1)
T2 = simplify(T2)
T3 = simplify(T3)
T4 = simplify(T4)
