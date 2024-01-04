classdef Arm_scara
    properties
        d, theta, a, alpha, n
        T, x
        roll_end, pitch_end, yaw_end
        x_end, y_end, z_end
    end
    methods

        function obj = Arm_scara(d, theta, a, alpha)
            obj.d = d; 
            obj.theta = deg2rad(theta);           
            obj.a = a;
            obj.alpha = deg2rad(alpha);
            obj.n = length(d);
        end

        %% Cập nhật thông số robot        
        function obj = set_joint(obj, index, value)
            if index  == 1
                obj.theta(1) = value;
            elseif index == 2
                obj.theta(2) = value;
            elseif index == 3
                obj.d(3) = value;   
            elseif index == 4
                obj.theta(4) = value;
            end
        end

        function obj = update(obj)
            obj.T = forward(obj.n, obj.d, obj.theta, obj.a, obj.alpha);
            for i = 1:obj.n+1
                obj.x(:,i) = (obj.T(1:3,4,i));
            end
            cos_phi = sqrt(obj.T(3,2,obj.n+1)^2 + obj.T(3,3,obj.n+1)^2);
            obj.x_end = obj.x(1,obj.n+1);
            obj.y_end = obj.x(2,obj.n+1);
            obj.z_end = obj.x(3,obj.n+1);
%             obj.roll_end = atan2(obj.T(3,2,obj.n+1), obj.T(3,2,obj.n+1));
%             obj.pitch_end = atan2(-(obj.T(3,1,obj.n+1)), -(sqrt((obj.T(3,2,obj.n+1))^2 + (obj.T(3,3,obj.n+1))^2)));
%             obj.yaw_end = atan2(obj.T(2,1,obj.n+1), obj.T(1,1,obj.n+1));
            obj.yaw_end = atan2(obj.T(2,1,obj.n+1)/cos_phi, obj.T(1,1,obj.n+1)/cos_phi);
%             obj_yaw_end = obj.theta(1) + obj.theta(2) + obj.theta(4);
        end

        %% Vẽ các trục toạ độ
        function plot_coords(obj, axes)
            vx = zeros(3, obj.n+1);
            vy = zeros(3, obj.n+1);
            vz = zeros(3, obj.n+1);
            for i = 1:obj.n+1
                vx(:,i) = obj.T(1:3,1:3,i)*[1; 0; 0];
                vy(:,i) = obj.T(1:3,1:3,i)*[0; 1; 0];
                vz(:,i) = obj.T(1:3,1:3,i)*[0; 0; 1];
            end
            vx(:,obj.n) = [0, 0, 0];
            vy(:,obj.n) = [0, 0, 0];
            vz(:,obj.n) = [0, 0, 0];

            axis_scale = 2/3;
            quiver3(axes, obj.x(1,:), obj.x(2,:), obj.x(3,:), vx(1,:), vx(2,:), vx(3,:), axis_scale, 'r', 'LineWidth', 2);
            quiver3(axes, obj.x(1,:), obj.x(2,:), obj.x(3,:), vy(1,:), vy(2,:), vy(3,:), axis_scale, 'g', 'LineWidth', 2);
            quiver3(axes, obj.x(1,:), obj.x(2,:), obj.x(3,:), vz(1,:), vz(2,:), vz(3,:), axis_scale, 'b', 'LineWidth', 2);
        end

        function plot_arm(obj, axes)
            % Set thông số kĩ thuật
            W2 = 200;               %độ rộng link 2,3
            R1 = 125;               %độ dài link 1 
            R2 = W2/2;              %độ rộng link 1
            H2 = 50;                %chiều cao link 2
            H1 = obj.d(1) - H2;     %chiều cao link 1
            L2 = obj.a(1);          %chiều dài link 2
            H3 = 300;               %chiều cao link 3
            L3 = obj.a(2);          %chiều dài link 3
        %% Vẽ robot
            % Link 1
            X = obj.x(1,1);     % Lấy tọa độ x của joint đầu tiên
            Y = obj.x(2,1);     % Lấy tọa độ y của joint đầu tiên
            Z = H1;             % Lấy chiều cao của link 1

            % Tạo các đỉnh của hình hộp chữ nhật
            vertices = [X - R1, X + R1, X + R1, X - R1;
                        Y - R2, Y - R2, Y + R2, Y + R2;
                        Z, Z, Z, Z];
            vertices1 = [X - R1, X + R1, X + R1, X - R1;
                        Y - R2, Y - R2, Y + R2, Y + R2;
                        Z-H1, Z-H1, Z-H1, Z-H1];
            vertices2 = [X - R1, X + R1, X + R1, X - R1;
                        Y + R2, Y + R2, Y + R2, Y + R2;
                        0, 0, Z, Z];    
            vertices3 = [X - R1, X + R1, X + R1, X - R1;
                        Y - R2, Y - R2, Y - R2, Y - R2;
                        0, 0, Z, Z];
            vertices4 = [X + R1, X + R1, X + R1, X + R1;
                        Y + R2, Y - R2, Y - R2, Y + R2;
                        0, 0, Z, Z];
            vertices5 = [X - R1, X - R1, X - R1, X - R1;
                        Y + R2, Y - R2, Y - R2, Y + R2;
                        0, 0, Z, Z];
                    
            % Vẽ hình hộp chữ nhật
            fill3(axes, vertices(1, :), vertices(2, :), vertices(3, :), 'w');
            fill3(axes, vertices1(1, :), vertices1(2, :), vertices1(3, :), 'w');
            fill3(axes, vertices2(1, :), vertices2(2, :), vertices2(3, :), 'w');
            fill3(axes, vertices3(1, :), vertices3(2, :), vertices3(3, :), 'w');
            fill3(axes, vertices4(1, :), vertices4(2, :), vertices4(3, :), 'w');
            fill3(axes, vertices5(1, :), vertices5(2, :), vertices5(3, :), 'w');

            % Link 2
            X = obj.x(1,1);
            Y = obj.x(2,1);
            Z1 = obj.x(3,2) - H2;
            Z2 = obj.x(3,2);
            yaw = obj.theta(1);
            
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L2*cos(yaw)+W2/2*sin(yaw), X+L2*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw)], [Z1, Z1, Z1, Z1], 'w')
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L2*cos(yaw)+W2/2*sin(yaw), X+L2*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw)], [Z2, Z2, Z2, Z2], 'w')
            fill3(axes, [X+W2/2*sin(yaw), X+W2/2*sin(yaw)+L2*cos(yaw), X+W2/2*sin(yaw)+L2*cos(yaw), X+W2/2*sin(yaw)], [Y-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y-W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], 'w')
            fill3(axes, [X-W2/2*sin(yaw), X-W2/2*sin(yaw)+L2*cos(yaw), X-W2/2*sin(yaw)+L2*cos(yaw), X-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw), Y+W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], 'w')
            
            th = linspace(pi+yaw-pi/2, 2*pi+yaw-pi/2, 100);
            X = R2*cos(th) + obj.x(1,1);
            Y = R2*sin(th) +  obj.x(2,1);
            Z1 = ones(1,size(th,2))*(obj.x(3,2) - H2);
            Z2 = ones(1,size(th,2))*obj.x(3,2);
            
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', 'b', 'EdgeColor', 'none')
            fill3(axes, X, Y, Z1, 'b');
            fill3(axes, X, Y, Z2, 'b');
            
            th = linspace(0+yaw-pi/2, pi+yaw-pi/2, 100);
            X = R2*cos(th) + obj.x(1,2);
            Y = R2*sin(th) + obj.x(2,2);

            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', 'b', 'EdgeColor', 'none')
            fill3(axes, X, Y, Z1,'b');
            fill3(axes, X, Y, Z2, 'b');

            % Link 3
            X = obj.x(1,2);
            Y = obj.x(2,2);
            Z1 = obj.x(3,3);
            Z2 = obj.x(3,3) + H3;
            yaw = obj.theta(1) + obj.theta(2) + obj.theta(3);

            fill3(axes, [X-W2/2 *sin(yaw), X+W2/2*sin(yaw), X+L3*cos(yaw)+W2/2*sin(yaw), X+L3*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw)], [Z1, Z1, Z1, Z1], 'b')
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L3*cos(yaw)+W2/2*sin(yaw), X+L3*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw)], [Z2, Z2, Z2, Z2], 'b')
            fill3(axes, [X+W2/2*sin(yaw), X+W2/2*sin(yaw)+L3*cos(yaw), X+W2/2*sin(yaw)+L3*cos(yaw), X+W2/2*sin(yaw)], [Y-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y-W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], 'b')
            fill3(axes, [X-W2/2*sin(yaw), X-W2/2*sin(yaw)+L3*cos(yaw), X-W2/2*sin(yaw)+L3*cos(yaw), X-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw), Y+W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], 'b')

            th = linspace(pi+yaw-pi/2, 2*pi+yaw-pi/2, 100);
            X = R2*cos(th) + obj.x(1,2);
            Y = R2*sin(th) + obj.x(2,2);
            Z1 = ones(1,size(th,2))*obj.x(3,3);
            Z2 = ones(1,size(th,2))*(obj.x(3,3) + H3);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', 'b', 'EdgeColor', 'none');
            fill3(axes, X , Y , Z1, 'b');
            fill3(axes, X , Y , Z2, 'b');

            th = linspace(0+yaw-pi/2, pi+yaw-pi/2, 100);
            X = R2*cos(th) + obj.x(1,4);
            Y = R2*sin(th) + obj.x(2,4);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', 'b', 'EdgeColor', 'none');
            fill3(axes, X , Y , Z1, 'b');
            fill3(axes, X , Y , Z2, 'b');

            % END
            th = linspace(0+yaw-pi, 2*pi+yaw-pi, 100);
            X = 20*cos(th) + obj.x(1,5);
            Y = 20*sin(th) + obj.x(2,5);
            Z1 = ones(1,size(th,2))*obj.x(3,5);
            Z2 = ones(1,size(th,2))*(obj.x(3,5) + 450);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', 'k', 'EdgeColor', 'none');
            fill3(axes, X , Y , Z1, 'r');
            fill3(axes, X , Y , Z2, 'r');

        end

        %% Vẽ workspace
        function plot_workspace(obj,axes)

                theta1_max = 125*pi/180;
                theta2_max = 145*pi/180;
                d3_max = 150;
                ws1 = linspace(-theta1_max,theta1_max,100);

                fill3([(obj.a(1)+obj.a(2))*cos(ws1) 0],[(obj.a(1)+obj.a(2))*sin(ws1) 0],(obj.d(1)- d3_max)*ones(1,101),'r','FaceAlpha',0.3);
                fill3([(obj.a(1)+obj.a(2))*cos(ws1) 0],[(obj.a(1)+obj.a(2))*sin(ws1) 0],obj.d(1)*ones(1,101),'r','FaceAlpha',0.3);

                ws2 = linspace(0,theta2_max,100);
    
                fill3([obj.a(1)*cos(theta1_max)+obj.a(2)*cos(theta1_max+ws2) obj.a(1)*cos(theta1_max)],[obj.a(1)*sin(theta1_max)+obj.a(2)*sin(theta1_max+ws2) obj.a(1)*sin(theta1_max)],(obj.d(1)-d3_max)*ones(1,101),'r','FaceAlpha',0.3);
                fill3([obj.a(1)*cos(theta1_max)+obj.a(2)*cos(theta1_max+ws2) obj.a(1)*cos(theta1_max)],[obj.a(1)*sin(theta1_max)+obj.a(2)*sin(theta1_max+ws2) obj.a(1)*sin(theta1_max)],obj.d(1)*ones(1,101),'r','FaceAlpha',0.3);

                ws3 = linspace(0,-theta2_max,100);

                fill3([obj.a(1)*cos(-theta1_max)+obj.a(2)*cos(-theta1_max+ws3) obj.a(1)*cos(-theta1_max)],[obj.a(1)*sin(-theta1_max)+obj.a(2)*sin(-theta1_max+ws3) obj.a(1)*sin(-theta1_max)],(obj.d(1)-d3_max)*ones(1,101),'r','FaceAlpha',0.3);
                fill3([obj.a(1)*cos(-theta1_max)+obj.a(2)*cos(-theta1_max+ws3) obj.a(1)*cos(-theta1_max)],[obj.a(1)*sin(-theta1_max)+obj.a(2)*sin(-theta1_max+ws3) obj.a(1)*sin(-theta1_max)],obj.d(1)*ones(1,101),'r','FaceAlpha',0.3);

                for i = 1:100
                    plot3([(obj.a(1)+obj.a(2))*cos(ws1(i)) (obj.a(1)+obj.a(2))*cos(ws1(i))],[(obj.a(1)+obj.a(2))*sin(ws1(i)) (obj.a(1)+obj.a(2))*sin(ws1(i))],[obj.d(1)-d3_max obj.d(1)],'r');

                    plot3([obj.a(1)*cos(theta1_max)+obj.a(2)*cos(theta1_max+ws2(i)) obj.a(1)*cos(theta1_max)+obj.a(2)*cos(theta1_max+ws2(i))],[obj.a(1)*sin(theta1_max)+obj.a(2)*sin(theta1_max+ws2(i)) obj.a(1)*sin(theta1_max)+obj.a(2)*sin(theta1_max+ws2(i))],[obj.d(1)-d3_max obj.d(1)],'r');

                    plot3([obj.a(1)*cos(-theta1_max)+obj.a(2)*cos(-theta1_max+ws3(i)) obj.a(1)*cos(-theta1_max)+obj.a(2)*cos(-theta1_max+ws3(i))],[obj.a(1)*sin(-theta1_max)+obj.a(2)*sin(-theta1_max+ws3(i)) obj.a(1)*sin(-theta1_max)+obj.a(2)*sin(-theta1_max+ws3(i))],[obj.d(1)-d3_max obj.d(1)]);
                end            
        end

        %% Vẽ không gian biểu diễn robot
        function plot(obj, axes, coords, workspace)
            cla(axes)
            hold on;
            rotate3d(axes, 'on');
            xlabel(axes, 'x');
            ylabel(axes, 'y');
            zlabel(axes, 'z');
            xlim(axes, [-700 700]);
            ylim(axes, [-700 700]);
            zlim(axes, [0 700]);
            if coords
                obj.plot_coords(axes);
            end
            obj.plot_arm(axes);
            if workspace
                obj.plot_workspace(axes);
            end
            view(axes, 3);
            drawnow;
            grid on;
        end
    end
end