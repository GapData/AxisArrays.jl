
# Test SortedVector
v = SortedVector(collect([1.; 10.; 10:15.]))
A = AxisArray(reshape(1:16, 8, 2), v, [:a, :b])
@test A[ClosedInterval(8.,12.), :] == A[2:5, :]
@test A[1. .. 1., :] == A[1:1, :]
@test A[10. .. 10., :] == A[2:3, :]

# Test SortedVector with a hierarchical index (indexed using Tuples)
srand(1234)
data = reshape(1.:40., 20, 2)
v = collect(zip([:a, :b, :c][rand(1:3,20)], [:x,:y][rand(1:2,20)], [:x,:y][rand(1:2,20)]))
idx = sortperm(v)
A = AxisArray(data[idx,:], SortedVector(v[idx]), [:a, :b])
@test A[:b, :] == A[5:12, :]
@test A[[:a,:c], :] == A[[1:4;13:end], :]
@test A[(:a,:y), :] == A[2:4, :]
@test A[(:c,:y,:y), :] == A[16:end, :]
@test A[ClosedInterval(:a,:b), :] == A[1:12, :]
@test A[ClosedInterval((:a,:x),(:b,:x)), :] ==  A[1:9, :]
@test A[[ClosedInterval((:a,:x),(:b,:x)),:c], :] ==  A[[1:9;13:end], :]
