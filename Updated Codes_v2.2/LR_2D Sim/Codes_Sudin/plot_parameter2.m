function [] = plot_parameter2(x_var1, x_Desc1, y_var1, y_Desc1, y_var2, y_Desc2,y_var3, y_Desc3, plot_title)  

figure(5)
subplot(2,1,1)
hold on
plot(x_var1,y_var1,'-ro')
plot(x_var1,y_var2,'-bo')
title(sprintf('%s',plot_title))
xlabel(sprintf('%s',x_Desc1))
ylabel(sprintf('%s\n%s',y_Desc1,y_Desc2))
h = legend((sprintf('%s',y_Desc1)),sprintf('%s',y_Desc2));
grid on

subplot(2,1,2)
hold on
plot(x_var1,y_var3,'-go')
xlabel(sprintf('%s',x_Desc1))
ylabel(sprintf('%s',y_Desc3))
k = legend(sprintf('%s',y_Desc3));
grid on

end