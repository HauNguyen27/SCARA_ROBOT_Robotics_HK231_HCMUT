function T = forward(n, d, theta, a, alpha)
    T(:,:,1) = eye(4);
    for i=1:n
        T(:,:,i+1)= T(:,:,i)*DH_matrix(d(i), theta(i), a(i), alpha(i));
    end
end