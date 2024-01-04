function set_ee(scara, handles)
    set(handles.x_val, 'String', num2str(round(scara.x_end, 2)));
    set(handles.y_val, 'String', num2str(round(scara.y_end, 2)));
    set(handles.z_val, 'String', num2str(round(scara.z_end, 2)));
    set(handles.yaw_val, 'String', num2str(round(rad2deg(scara.yaw_end), 2)));
end