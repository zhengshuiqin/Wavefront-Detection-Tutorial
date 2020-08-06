function var = space(Width,X_num,Height,Y_num)

[var.x_,var.fx_]=domain(Width,X_num);

[var.y_,var.fy_]=domain(Height,Y_num);

[var.x,var.y] = meshgrid(var.x_,var.y_);
[var.fx,var.fy] = meshgrid(var.fx_,var.fy_);

[var.theta var.rho] =cart2pol(var.x,var.y);
