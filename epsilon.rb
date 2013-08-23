def epsilon
  d = 0.5
  while 1 != 1+d do
    puts "#{d}"
    d = d.fdiv 2
  end
end
# result => 2.220446049250313e-16
# result  => Float::EPSILON => 2.220446049250313e-16
# 0.5
# 0.25
# 0.125
# 0.0625
# 0.03125
# 0.015625
# 0.0078125
# 0.00390625
# 0.001953125
# 0.0009765625
# 0.00048828125
# 0.000244140625
# 0.0001220703125
# 6.103515625e-05
# 3.0517578125e-05
# 1.52587890625e-05
# 7.62939453125e-06
# 3.814697265625e-06
# 1.9073486328125e-06
# 9.5367431640625e-07
# 4.76837158203125e-07
# 2.384185791015625e-07
# 1.1920928955078125e-07
# 5.960464477539063e-08
# 2.9802322387695312e-08
# 1.4901161193847656e-08
# 7.450580596923828e-09
# 3.725290298461914e-09
# 1.862645149230957e-09
# 9.313225746154785e-10
# 4.656612873077393e-10
# 2.3283064365386963e-10
# 1.1641532182693481e-10
# 5.820766091346741e-11
# 2.9103830456733704e-11
# 1.4551915228366852e-11
# 7.275957614183426e-12
# 3.637978807091713e-12
# 1.8189894035458565e-12
# 9.094947017729282e-13
# 4.547473508864641e-13
# 2.2737367544323206e-13
# 1.1368683772161603e-13
# 5.684341886080802e-14
# 2.842170943040401e-14
# 1.4210854715202004e-14
# 7.105427357601002e-15
# 3.552713678800501e-15
# 1.7763568394002505e-15
# 8.881784197001252e-16
# 4.440892098500626e-16
# 2.220446049250313e-16