function scatter_generate_recover(x, y)

figure; scatter(x, y); v = axis; lo = min( v(1:2:end) ); up = max( v(2:2:end) ); axis( [lo up lo up] ); refline(1, 0);

end